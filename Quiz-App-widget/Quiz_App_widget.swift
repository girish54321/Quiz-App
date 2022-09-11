//
//  Quiz_App_widget.swift
//  Quiz-App-widget
//
//  Created by Girish Parate on 11/09/22.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    @AppStorage(appStorageKey, store: UserDefaults(suiteName: appStorageKey))
    var appData : Data = Data()
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent(),appData: HighScore(score: "0", scoreNumber: 0))
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
//        let entry = SimpleEntry(date: Date(), configuration: configuration)
//        completion(entry)
        if let data = try? JSONDecoder().decode(HighScore.self, from: appData) {
            let entry = SimpleEntry(date: Date(), configuration: configuration, appData: data)
            completion(entry)
        }
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
//        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//        let currentDate = Date()
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = SimpleEntry(date: entryDate, configuration: configuration)
//            entries.append(entry)
//        }
//
//        let timeline = Timeline(entries: entries, policy: .atEnd)
//        completion(timeline)
        if let data = try? JSONDecoder().decode(HighScore.self, from: appData) {
            let date = Date()
            
            let entry = SimpleEntry(date: date, configuration: configuration, appData: data)

            let timeline = Timeline(entries: [entry], policy: .never)
            completion(timeline)
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let appData: HighScore
}

struct Quiz_App_widgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        WidgetView(score: entry.appData.score)
    }
}

@main
struct Quiz_App_widget: Widget {
    let kind: String = "Quiz_App_widget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            Quiz_App_widgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Scorer Widget")
        .description("Kepp track of your Scorer.")
    }
}

struct Quiz_App_widget_Previews: PreviewProvider {
    static var previews: some View {
        Quiz_App_widgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), appData: HighScore(score: "0", scoreNumber: 0)))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
