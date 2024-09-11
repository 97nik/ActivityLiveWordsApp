import ActivityKit
import WidgetKit
import SwiftUI
import AppIntents

// Определяем атрибуты для живых активностей, используя протокол ActivityAttributes
struct LiveActivityAttributes: ActivityAttributes {
    // Определяем состояние активности
    public struct ContentState: Codable, Hashable {
        var transcription: String
        var title: String
        var description: String
        var engLanguage: Bool
        var index: Int
    }
    var name: String
}

@available(iOS 16.1, *)
struct LiveActivityLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LiveActivityAttributes.self) { context in
            // Определяем макет виджета с использованием HStack и VStack
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
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                    
                    Text(context.state.description)
                        .font(.system(size: 15))
                        .italic()
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                }
                .padding(.bottom, 8)
                Spacer()
                VStack(alignment: .center, spacing: 16) {
                    // Включаем пользовательский вид кнопок действий
                    LiveActivityActionButtonsView(recordID: context.activityID, engLanguage: context.state.engLanguage, index: context.state.index)
                }
                .padding(.trailing, 16)
            }
            .frame(maxHeight: 160)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color(red: 0.4, green: 0.1, blue: 0.6), Color(red: 0.1, green: 0.3, blue: 0.7)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .cornerRadius(16)
        } dynamicIsland: { context in
            // Определяем макет для взаимодействия в Dynamic Island
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
    // Предоставляем предварительный просмотр LiveActivityAttributes
    fileprivate static var preview: LiveActivityAttributes {
        LiveActivityAttributes(name: "World")
    }
}

// Предварительный просмотр виджета с примерными данными
#Preview("Notification", as: .content, using: LiveActivityAttributes.preview) {
    LiveActivityLiveActivity()
} contentStates: {
    LiveActivityAttributes.ContentState(
        transcription: dataItems[0].transcription,
        title: dataItems[0].title,
        description: dataItems[0].description,
        engLanguage: true,
        index: 0
    )
}
