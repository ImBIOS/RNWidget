//
//  StreakWidgetLiveActivity.swift
//  StreakWidget
//
//  Created by Imamuzzaki Abu Salam on 18/08/23.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct StreakWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct StreakWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: StreakWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension StreakWidgetAttributes {
    fileprivate static var preview: StreakWidgetAttributes {
        StreakWidgetAttributes(name: "World")
    }
}

extension StreakWidgetAttributes.ContentState {
    fileprivate static var smiley: StreakWidgetAttributes.ContentState {
        StreakWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: StreakWidgetAttributes.ContentState {
         StreakWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: StreakWidgetAttributes.preview) {
   StreakWidgetLiveActivity()
} contentStates: {
    StreakWidgetAttributes.ContentState.smiley
    StreakWidgetAttributes.ContentState.starEyes
}
