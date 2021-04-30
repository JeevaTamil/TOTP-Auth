//
//  WidgetView.swift
//  Widget Auth
//
//  Created by Azhagusundaram Tamil on 01/04/21.
//

import SwiftUI
import WidgetKit

// MARK:- TimelineEntry
struct OAWidgetEntry: TimelineEntry {
    var date: Date
    let displayDate: Date
    let otps: [OTPModel]
}


// MARK:- TimeLineProvider
struct OAWidgetProvider: IntentTimelineProvider {
    typealias Intent = SelectOTPIntent
    typealias Entry = OAWidgetEntry
    
    func placeholder(in context: Context) -> OAWidgetEntry {
        let firstDate = Calendar.current.date(byAdding: .second, value: 30, to: Date())!
        return Entry(date: Date(), displayDate: firstDate, otps: [
            OTPModel(issuer: "Google", name: "emma@gmail.com", secret: "Google"),
            OTPModel(issuer: "Facebook", name: "alex@facebook.com", secret: "Facebook"),
            OTPModel(issuer: "Apple", name: "jeeva@apple.com", secret: "Apple"),
        ])
    }
    
    func getSnapshot(for configuration: SelectOTPIntent, in context: Context, completion: @escaping (OAWidgetEntry) -> Void) {
        let firstDate = Calendar.current.date(byAdding: .second, value: 30, to: Date())!
        completion(Entry(date: Date(), displayDate: firstDate, otps: [
            OTPModel(issuer: "Google", name: "emma@gmail.com", secret: "Google"),
            OTPModel(issuer: "Facebook", name: "alex@facebook.com", secret: "Facebook"),
            OTPModel(issuer: "Apple", name: "jeeva@apple.com", secret: "Apple"),
        ]))
    }
    
    func getTimeline(for configuration: SelectOTPIntent, in context: Context, completion: @escaping (Timeline<OAWidgetEntry>) -> Void) {
       
        var entries = [Entry]()
        guard let otpArr = configuration.otp1 else { return }
        var otp = [OTPValue]()
        
        for widgetOTP in otpArr {
            let flag = getAllOTPModels().contains { (OTPModel) -> Bool in
                OTPModel.secret == widgetOTP.secret
            }
            
            if flag {
                otp.append(widgetOTP)
            }
        }
        
        var otpModelArr = [OTPModel]()
        for item in otp {
            if let name = item.name, let email = item.email, let secret = item.secret {
                otpModelArr.append(OTPModel(issuer: name, name: email, secret: secret))
            }
        }
        let currentDate = Date()
        let remainingTimeDate = Calendar.current.date(byAdding: .second, value: getRemainingTime(at: currentDate), to: currentDate)!
        let entry = Entry(date: currentDate, displayDate: remainingTimeDate, otps: otpModelArr)
        entries.append(entry)

        var first = Calendar.current.date(byAdding: .second, value: getRemainingTime(at: remainingTimeDate), to: remainingTimeDate)!
        var second = Date()
        var flag = false
        
        for _ in 1..<60 {
            var entry = Entry(date: flag ? getDateBeforeOneSecond(for: second) : getDateBeforeOneSecond(for: remainingTimeDate), displayDate: first, otps: otpModelArr)
            entries.append(entry)
            flag = true

            second = Calendar.current.date(byAdding: .second, value: getRemainingTime(at: first), to: first)!
            entry = Entry(date:  getDateBeforeOneSecond(for: first), displayDate: second, otps: otpModelArr)
            entries.append(entry)
            
            first = Calendar.current.date(byAdding: .second, value: getRemainingTime(at: second), to: second)!
        }
        // Create Timeline that display in widget (Array of Entry)
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
    func getDateBeforeOneSecond(for date: Date) -> Date {
        return  Calendar.current.date(byAdding: .second, value: -1, to: date)!
    }
    
    func getRemainingTime(at date: Date) -> Int {
        var components = DateComponents.init()
        components = Calendar.current.dateComponents([.hour, .minute, .second], from: date)
        let second = components.second
        let timeRemaining = 30 - (second!%30)
        return timeRemaining
    }
}

//MARK:- WidgetView
struct OAWidgetView: View {
    var entry: OAWidgetProvider.Entry
    @Environment(\.widgetFamily) var widgetFamily
    
    var body: some View {
        
        switch widgetFamily {
        case .systemSmall:
            if entry.otps.isEmpty {
                EmptyStateView()
            } else {
            ZStack {
                Color("WidgetBackground")
            SmallWidget(otpModel: entry.otps.first!, atDate: entry.date, displayDate: entry.displayDate)
            }
            }
        default:
            ZStack {
                Color("WidgetBackground")
            VStack(spacing: 5) {
                ForEach(entry.otps) { otpModel in
                    Link(destination: URL(string: "oa://\(otpModel.secret)")!) {
                        OASingleOTPView(otpModel: otpModel, atDate: entry.date, displayDate: entry.displayDate)
                    }
                    Divider()
                }
            }.padding(.all)
            }
        }
    }
}

// MARK:- Single OTP view
struct OASingleOTPView: View {
    let otpModel: OTPModel
    let atDate: Date
    let displayDate: Date
    
    var body: some View {
            HStack {
                Image(uiImage: UIImage.init(named: otpModel.issuer.lowercased()) ?? UIImage(named: "shield")!)
                        .resizable()
                        .scaledToFit()
                        .clipShape(ContainerRelativeShape())
                        .frame(width: 32, height: 32, alignment: .center)
                
                VStack(alignment: .leading) {
                    Text(otpModel.issuer)
                        .font(.system(size: 12, weight: .bold, design: .monospaced))
                        .bold()
                    Text(otpModel.name)
                        .font(.system(size: 12, weight: .semibold, design: .monospaced))
                        .foregroundColor(.secondary)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text(generateOTP(otp: otpModel, at: atDate))
                        .font(.system(size: 18, weight: .bold, design: .monospaced))
                        .fixedSize()
                    
                    Text(displayDate, style: .timer)
                        .font(.system(size: 12, weight: .medium, design: .monospaced))
                        .foregroundColor(.blue)
                        .frame(width: 35)
                }
            }
    }
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

//MARK:- Empty View
struct EmptyStateView: View {
    var body: some View {
        ZStack {
            Color("WidgetBackground")
        VStack {
            Image("AppIcon")
                .resizable()
                .frame(width: 24, height: 24, alignment: .center)
            
            Text("Add atleast 1 OTP to display")
        }
        .padding()
        }
    }
}


// MARK:- Small widget
struct SmallWidget: View {
    let otpModel: OTPModel
    let atDate: Date
    let displayDate: Date
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 12) {
                    Image(uiImage: UIImage.init(named: otpModel.issuer.lowercased()) ?? UIImage(named: "shield")!)
                        .resizable()
                        .scaledToFit()
                        .clipShape(ContainerRelativeShape())
                        .frame(width: 24, height: 24, alignment: .center)
                    VStack(alignment: .leading, spacing: 4) {
                    Text(otpModel.issuer)
                        .font(.system(size: 12, weight: .bold, design: .monospaced))
                        .bold()
                    
                    Text(otpModel.name)
                        .font(.system(size: 12, weight: .semibold, design: .monospaced))
                        .foregroundColor(.secondary)
                    }
                }
                Spacer()
            }
            .padding([.leading, .top], 16)
            Spacer()
            HStack {
                Spacer()
                VStack(alignment: .trailing) {
                    Text(generateOTP(otp: otpModel, at: atDate))
                        .font(.system(size: 18, weight: .bold, design: .monospaced))
                        .fixedSize()
                    
                    Text(displayDate, style: .timer)
                        .font(.system(size: 12, weight: .medium, design: .monospaced))
                        .foregroundColor(.blue)
                        .frame(width: 35)
                }
            }
            .padding([.bottom, .trailing], 16)
            
        }
        .clipShape(ContainerRelativeShape())
    }
}



// MARK:- Widgets
struct OAWidget: Widget {
    var kind = "OAWidget"
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: SelectOTPIntent.self, provider: OAWidgetProvider()) { entry in
            OAWidgetView(entry: entry)
        }
        .configurationDisplayName("OneAuth OTPs")
        .description("Quick access to your OneAuth OTP Authenticator")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

// MARK:- Widget bundle
@main
struct OTPWidgetBunlde: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        OAWidget()
    }
}

struct WidgetView: View {
    let otpModelArr: [OTPModel]
    
    var body: some View {
        OAWidgetView(entry: .init(date: Date(), displayDate: Calendar.current.date(byAdding: .second, value: 30, to: Date())!, otps: otpModelArr))
    }
}

struct WidgetView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WidgetView(
                otpModelArr: [
                    OTPModel(issuer: "Demo", name: "emma@gmail.com", secret: "Google"),
                    OTPModel(issuer: "Facebook", name: "alex@facebook.com", secret: "Facebook"),
                    OTPModel(issuer: "Apple", name: "jeeva@apple.com", secret: "Apple")
                    ]
            )
            .previewContext(WidgetPreviewContext(family: .systemMedium))
            
            WidgetView(
                otpModelArr: [
                   
                    ]
            )
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        }
        
    }
}

//MARK:- Util Method
func fetchAllOTPs() -> [OTPModel] {
    let suiteName = "group.com.jeeva.widgetauth"
    let k_otp_secret = "otp_secrets"
    var fetchedOTPs = [OTPModel]()
    
    do {
        if let userDefaults =  UserDefaults(suiteName: suiteName) {
            if let encodedOTPs = userDefaults.data(forKey: k_otp_secret) {
                let decoadedOTPs = try JSONDecoder().decode([OTPModel].self, from: encodedOTPs)
                fetchedOTPs = decoadedOTPs
            } else {
                print("No data found for the key in userdefaults")
            }
        }
    } catch {
        print("decoading error")
    }
    
    return fetchedOTPs
}


extension String {
    func separating(every: Int, separator: String) -> String {
        let regex = #"(.{\#(every)})(?=.)"#
        return self.replacingOccurrences(of: regex, with: "$1\(separator)", options: [.regularExpression])
    }
}
