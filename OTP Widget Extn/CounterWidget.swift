//
//  CounterWidget.swift
//  Widget Auth
//
//  Created by Azhagusundaram Tamil on 16/04/21.
//

import Foundation
import SwiftUI
import WidgetKit

private struct CounterProvider: TimelineProvider {
    func placeholder(in context: Context) -> CounterSimpleEntry {
        CounterSimpleEntry(date: Date(), displayDate: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (CounterSimpleEntry) -> Void) {
        let entry = CounterSimpleEntry(date: Date(), displayDate: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<CounterSimpleEntry>) -> Void) {
        let currentDate = Date()
        let firstDate = Calendar.current.date(byAdding: .second, value: 50, to: currentDate)!
        let secondDate = Calendar.current.date(byAdding: .second, value: 60, to: currentDate)!

        let entries = [
            CounterSimpleEntry(date: currentDate, displayDate: secondDate),
            CounterSimpleEntry(date: firstDate, displayDate: secondDate, isDateClose: true),
        ]

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

private struct CounterSimpleEntry: TimelineEntry {
    let date: Date
    let displayDate: Date
    var isDateClose = false
}

private struct CountdownWidgetEntryView: View {
    var entry: CounterProvider.Entry

    var body: some View {
        Text(entry.displayDate, style: .timer)
            .foregroundColor(entry.isDateClose ? .red : .primary)
    }
}

struct CountdownWidget: Widget {
    let kind: String = "CountdownWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: CounterProvider()) { entry in
            CountdownWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Countdown Widget")
        .description("A Widget that displays the remaining time in seconds and changes color when the end date is approaching.")
        .supportedFamilies([.systemSmall])
    }
}
