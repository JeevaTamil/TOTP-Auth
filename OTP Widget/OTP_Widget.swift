//
//  OTP_Widget.swift
//  OTP Widget
//
//  Created by Azhagusundaram Tamil on 26/10/20.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        //SimpleEntry(date: Date(), configuration: ConfigurationIntent())
        
        SimpleEntry(date: Date(), configuration: ConfigurationIntent(), otps: [OTPModel(name: "Zoho", email: "zylker@zoho.com", secret: "ILOVEZOHO")])
        
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration, otps: [OTPModel(name: "Zoho", email: "zylker@zoho.com", secret: "ILOVEZOHO")])
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
//        let currentDate = Date()
//
//        let nextWidgetUpdateDate = Calendar.current.date(byAdding: .second, value: 30, to: currentDate)
//
//        let currentOTPEntry = SimpleEntry(date: currentDate, configuration: configuration, otps: [])
//
//        let timeline = Timeline(entries: [currentOTPEntry], policy: .after(nextWidgetUpdateDate))
//
//
//
        
        
        
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let otps: [OTPModel]
}

struct OTP_WidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        Text(entry.date, style: .time)
    }
}

@main
struct OTP_Widget: Widget {
    let kind: String = "OTP_Widget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: SelectOTPIntent.self, provider: Provider()) { entry in
            OTP_WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My OTPs")
        .description("Select a OTP to display in the widget")
        
    }
}

struct OTP_Widget_Previews: PreviewProvider {
    static var previews: some View {
        OTP_WidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
