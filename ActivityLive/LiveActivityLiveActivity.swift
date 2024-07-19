//
//  ActivityLiveLiveActivity.swift
//  ActivityLive
//
//  Created by Nikita on 19.07.2024.
//

import ActivityKit
import WidgetKit
import SwiftUI
import AppIntents


struct LiveActivityAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var transcription: String
        var title: String
        var description: String
        var index : Int
    }
    var name: String
}

@available(iOS 16.1, *)
struct LiveActivityLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LiveActivityAttributes.self) { context in
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(context.state.transcription)
                        .font(.system(size: 13))
                        .opacity(0.5)
                        .foregroundColor(.white)
                        .padding(.top, 8)
                        .padding(.horizontal, 16)
                    
                    Text(context.state.title)
                        .font(.system(size: 24))
                        .bold()
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                    
                    Text(context.state.description)
                        .font(.system(size: 15))
                        .italic()
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                }.padding(.bottom, 8)
                Spacer()
                VStack(alignment: .center, spacing: 16) {
                    LiveActivityActionButtonsView(recordID: context.activityID, next: false, index: context.state.index)
                    LiveActivityActionButtonsView(recordID: context.activityID, next: true, index: context.state.index)
                }
                .padding(.trailing, 16)
            }
            .frame(maxHeight: 160)
            .background(LinearGradient(gradient: Gradient(colors: [Color(red: 0.4, green: 0.1, blue: 0.6), Color(red: 0.1, green: 0.3, blue: 0.7)]), startPoint: .top, endPoint: .bottom))
            .cornerRadius(16)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {}
                DynamicIslandExpandedRegion(.trailing) {}
                DynamicIslandExpandedRegion(.bottom) {}
            }
        compactLeading: {}
        compactTrailing: {}
        minimal: {}
                .widgetURL(URL(string: "http://www.apple.com"))
                .keylineTint(Color.red)
        }
    }
}

extension LiveActivityAttributes {
    fileprivate static var preview: LiveActivityAttributes {
        LiveActivityAttributes(name: "World")
    }
}

#Preview("Notification", as: .content, using: LiveActivityAttributes.preview) {
    LiveActivityLiveActivity()
} contentStates: {
    LiveActivityAttributes.ContentState(
        transcription: dataItems[0].transcription,
        title: dataItems[0].title,
        description: dataItems[0].description, index: 0
    )
}
