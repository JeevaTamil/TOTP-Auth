//
//  OTP_Widget_Extn.swift
//  OTP Widget Extn
//
//  Created by Azhagusundaram Tamil on 26/10/20.
//

import WidgetKit
import SwiftUI

// MARK:- Provider
struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), otps: OTPModel(name: "Zoho", email: "zylker@zoho.com", secret: "ILOVEZOHO"), atTime: Date(), timeRemaining: 10)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), otps: OTPModel(name: "Zoho", email: "zylker@zoho.com", secret: "ILOVEZOHO"), atTime: Date(), timeRemaining: 20)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        let currentDate = Date()
        print("current time - \(currentDate)")
        let fetchedOTPS = fetchAllOTPs()
        var entries: [SimpleEntry] = []
        var policyTimeline = Date()
        var nextWidgetUpateDate: Date = Date()
        
        policyTimeline = Calendar.current.date(byAdding: .second, value: 20, to: currentDate)!
        print("refresh after time - \(policyTimeline)")
        
        for index in 0 ..< 60 {
            nextWidgetUpateDate = Calendar.current.date(byAdding: .second, value: index, to: currentDate)!
            var components = DateComponents.init()
            components = Calendar.current.dateComponents([.hour, .minute, .second], from: nextWidgetUpateDate)
            let second = components.second
            let timeRemaining = 30 - (second!%30)
            let currentOTPEntry =  SimpleEntry(date: nextWidgetUpateDate, otps: fetchedOTPS.first!, atTime: nextWidgetUpateDate, timeRemaining: timeRemaining)
            
            entries.append(currentOTPEntry)
        }
        
        let timeline = Timeline(entries: entries, policy: .after(policyTimeline))
        completion(timeline)
    }
}


struct DemoEntry: TimelineEntry {
    let date: Date
}





// MARK:- Entry
struct SimpleEntry: TimelineEntry {
    let date: Date
    let otps: OTPModel
    let atTime: Date
    let timeRemaining: Int
}


struct DemoWidget: View {
    var entry: SelectableOTPProvider.Entry
    var body: some View {
        
        Text("\(entry.date)")
    }
}




// MARK:- EntryView
struct OTP_Widget_ExtnEntryView : View {
    var entry: Provider.Entry
    
    @State private var timeRemaining = 0
    let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main,  in: .common).autoconnect()
    
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "HH:mm:ss"
        return formatter
    }()
    
    
    var body: some View {
        HStack {
            if (entry.otps.secret == "ILOVEZOHO") || (entry.otps.secret == "") {
                Text("No OTPs added")
            } else {
                VStack(alignment: .leading) {
                    Text(entry.otps.name)
                    Text(entry.otps.email)
                        .foregroundColor(.secondary)
                }
                Spacer()
                VStack(spacing: 20) {
                   // ForEach(entry.otps) { otp in
                    Text(generateOTP(otp: entry.otps, at: entry.atTime))
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                        Text("\(entry.timeRemaining)")
                  //  }
                   
                }
            }
        }
        .padding(.horizontal)
    }
    
    func scheduleTimer() -> Int {
        var components = DateComponents.init()
        components = Calendar.current.dateComponents([.hour, .minute, .second], from: Date())
        let second = components.second
        return 30 - (second!%30)
    }
    
    func generateOTP(otp: OTPModel, at time: Date) -> String {
        let period : Int = 30
        let digits : Int = 6
        let algorithm = "SHA1"
        
        let secretData = NSData(base32String: otp.secret)
        let timeStamp = time.timeIntervalSince1970
        let generator =  TOTPGenerator(secret: secretData as Data?, algorithm: algorithm, digits: UInt(digits), period: TimeInterval(period))
        let code = generator?.generateOTP(for: Date.init(timeIntervalSince1970: TimeInterval(timeStamp))).separating(every: 3, separator: " ")
        guard let codeVal = code else {
            return "123 456"
        }
        return codeVal
    }
}



// MARK:- Selectable OTP Widget
struct SelectableOTPProvider: IntentTimelineProvider {
    typealias entry = DemoEntry
    
    
    func placeholder(in context: Context) -> entry {
      //  SimpleEntry(date: Date(), otps: OTPModel(name: "Zoho", email: "zylker@zoho.com", secret: "ILOVEZOHO"), atTime: Date(), timeRemaining: 10)
        entry(date: Date())
    }
    
    func getSnapshot(for configuration: SelectOTPIntent, in context: Context, completion: @escaping (entry) -> Void) {
        
//        let entry = SimpleEntry(date: Date(), otps: OTPModel(name: "Zoho", email: "zylker@zoho.com", secret: "ILOVEZOHO"), atTime: Date(), timeRemaining: 20)
//        completion(entry)
        completion(entry(date: Date()))
    }
    
    func getTimeline(for configuration: SelectOTPIntent, in context: Context, completion: @escaping (Timeline<entry>) -> Void) {
        
        let currentDate = Date()
        print("current time - \(currentDate)")
        var entries: [entry] = []
        var policyTimeline = Date()
        var nextWidgetUpateDate: Date = Date()
        
        
        
        policyTimeline = Calendar.current.date(byAdding: .second, value: 20, to: currentDate)!
        print("refresh after time - \(policyTimeline)")
        
        for index in 0 ..< 60 {
            nextWidgetUpateDate = Calendar.current.date(byAdding: .second, value: index, to: currentDate)!
            var components = DateComponents.init()
            components = Calendar.current.dateComponents([.hour, .minute, .second], from: nextWidgetUpateDate)
            let second = components.second
            let timeRemaining = 30 - (second!%30)
            
//            guard let otp1 = configuration.otp else {
//                print("otp is null")
//            }
//
//            guard let otp2 = configuration.otp2 else {
//                print("otp2 is null")
//            }
//
//            let model1 = OTPModel(name: otp1.name!, email: otp1.email!, secret: otp1.secret!)
            
//            let model = OTPModel(name: configuration.otp1?.name ?? "", email:  configuration.otp1?..email ?? "", secret: configuration.otp1?.secret ?? "")
//            let currentOTPEntry =  SimpleEntry(date: nextWidgetUpateDate, otps: model, atTime: nextWidgetUpateDate, timeRemaining: timeRemaining)
            
           // entries.append(currentOTPEntry)
        }
        
        let timeline = Timeline(entries: entries, policy: .after(policyTimeline))
        completion(timeline)
        
    }
    
}

// MARK:- Widgets
struct SelectableOTPWidget: Widget {
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: "Selectable_OTP_Extn", intent: SelectOTPIntent.self, provider: SelectableOTPProvider()) { entry in
           // OTP_Widget_ExtnEntryView(entry: entry)
            DemoWidget(entry: entry)
        }
        .configurationDisplayName("Selectable OTP Widget")
        .description("You can select your own OTP")
        .supportedFamilies([.systemMedium])
    }
}


struct OTP_Widget_Extn: Widget {
    let kind: String = "OTP_Widget_Extn"
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            OTP_Widget_ExtnEntryView(entry: entry)
        }
        .configurationDisplayName("Show First OTP")
        .description("First OTP will be displayed in this OTP")
        .supportedFamilies([.systemMedium])
    }
}

// MARK:- Widget bundle
@main
struct OTPWidgetBunlde: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        OAWidget()
        CountdownWidget()
    }
}


// MARK:- Preview
struct OTP_Widget_Extn_Previews: PreviewProvider {
    static var previews: some View {
        OTP_Widget_ExtnEntryView(entry: SimpleEntry(date: Date(), otps: OTPModel(name: "Zoho", email: "zylker@zoho.com", secret: "ILOVEZOHO"), atTime: Date(), timeRemaining: 12))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}


extension String {
    func separating(every: Int, separator: String) -> String {
        let regex = #"(.{\#(every)})(?=.)"#
        return self.replacingOccurrences(of: regex, with: "$1\(separator)", options: [.regularExpression])
    }
}
