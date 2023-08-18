//
//  StreakWidget.swift
//  StreakWidget
//
//  Created by Imamuzzaki Abu Salam on 18/08/23.
//

import WidgetKit
import SwiftUI

struct WidgetData: Decodable {
  var text: String
}

struct Provider: AppIntentTimelineProvider {
  
  func placeholder(in context: Context) -> SimpleEntry {
    SimpleEntry(date: Date(), configuration: ConfigurationAppIntent(), text: "Placeholder")
  }
  
  func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
    let entry = SimpleEntry(date: Date(), configuration: configuration, text: "365 days")
    return entry
  }
  
  func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
    let userDefaults = UserDefaults.init(suiteName: "group.dev.imam.rnwidget.streak")
    let entryDate = Date()
    
    if userDefaults != nil {
      if let savedData = userDefaults!.string(forKey: "widgetKey") {
        let decoder = JSONDecoder()
        let data = savedData.data(using: .utf8)
        if let parsedData = try? decoder.decode(WidgetData.self, from: data!) {
          let nextRefresh = Calendar.current.date(byAdding: .minute, value: 5, to: entryDate)!
          let entry = SimpleEntry(date: nextRefresh, configuration: configuration, text: parsedData.text)
          let timeline = Timeline(entries: [entry], policy: .atEnd)
          return timeline
        } else {
          print("Could not parse data")
        }
      } else {
        let nextRefresh = Calendar.current.date(byAdding: .minute, value: 5, to: entryDate)!
        let entry = SimpleEntry(date: nextRefresh, configuration: configuration, text: "No data set")
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        return timeline
      }
    }
    
    let nextRefresh = Calendar.current.date(byAdding: .minute, value: 5, to: entryDate)!
    let entry = SimpleEntry(date: nextRefresh, configuration: configuration, text: "Error!")
    let timeline = Timeline(entries: [entry], policy: .atEnd)
    return timeline
  }
}

struct SimpleEntry: TimelineEntry {
  let date: Date
  let configuration: ConfigurationAppIntent
  let text: String
}

struct StreakWidgetEntryView : View {
  var entry: Provider.Entry
  
  var body: some View {
    HStack {
      VStack(alignment: .leading, spacing: 0) {
        HStack(alignment: .center) {
          Image("streak")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 37, height: 37)
          Text(entry.text)
            .foregroundColor(Color(red: 1.00, green: 0.59, blue: 0.00))
            .font(Font.system(size: 21, weight: .bold, design: .rounded))
            .padding(.leading, -8.0)
        }
        .padding(.top, 10.0)
        .frame(maxWidth: .infinity)
        Text("Way to go!")
          .foregroundColor(Color(red: 0.69, green: 0.69, blue: 0.69))
          .font(Font.system(size: 14))
          .frame(maxWidth: .infinity)
        Image("duo")
          .renderingMode(.original)
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(maxWidth: .infinity)
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}

struct StreakWidget: Widget {
  let kind: String = "StreakWidget"
  
  var body: some WidgetConfiguration {
    AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
      StreakWidgetEntryView(entry: entry)
        .containerBackground(.fill.tertiary, for: .widget)
    }
    .configurationDisplayName("My Widget")
    .description("This is an example widget.")
    .contentMarginsDisabled()
  }
}

#Preview(as: .systemSmall) {
  StreakWidget()
} timeline: {
  SimpleEntry(date: .now, configuration: ConfigurationAppIntent(), text: "123 days")
}
