import Foundation
import ActivityKit
import SwiftUI

open class LiveActivityManager: NSObject, ObservableObject {
    public static let shared: LiveActivityManager = LiveActivityManager()
    
    private var currentActivity: Activity<LiveActivityAttributes>? = nil
    @Published var alertItem: AlertItem?

    override init() {
        super.init()
    }
    
    func startActivity() {
        guard ActivityAuthorizationInfo().areActivitiesEnabled else {
            alertItem = AlertItem(title: "Ошибка", message: "Вы не можете запустить Live Activity.")
            return
        }
        
        // Проверка на наличие активной активности
        if currentActivity != nil {
            alertItem = AlertItem(title: "Ошибка", message: "Live Activity уже запущена.")
            return
        }
        
        let attributes = LiveActivityAttributes(name: "Пример Live Activity")
        let initialState = LiveActivityAttributes.ContentState(
            transcription: dataItems[0].transcription,
            title: dataItems[0].title,
            description: dataItems[0].description,
            index: 0
        )
        do {
            let activity = try Activity<LiveActivityAttributes>.request(
                attributes: attributes,
                content: .init(state: initialState, staleDate: nil),
                pushType: nil
            )
            currentActivity = activity
            print("LiveActivityService: \(activity.id) Live Activity создана.")
        } catch {
            alertItem = AlertItem(title: "Ошибка", message: "Ошибка при создании Live Activity: \(error.localizedDescription).")
        }
    }
    
    func endActivity() {
        Task {
            guard let activity = currentActivity else {
                print("Нет активной Live Activity для завершения.")
                return
            }
            await activity.end(dismissalPolicy: .immediate)
            currentActivity = nil
            print("LiveActivityService: Live Activity завершена.")
        }
    }
    
    func updateActivity(id: String, next: Bool, index: Int) {
        Task {
            guard let activity = Activity<LiveActivityAttributes>.activities.first(where: { $0.id == id }) else {
                return
            }
            var nextIndex = (index - 1 + dataItems.count) % dataItems.count

            if next {
                nextIndex = (nextIndex + 2) % dataItems.count
            } else {
                nextIndex = (nextIndex + dataItems.count) % dataItems.count
            }

            let contentState = LiveActivityAttributes.ContentState(
                transcription: dataItems[nextIndex].transcription,
                title: dataItems[nextIndex].title,
                description: dataItems[nextIndex].description,
                index: nextIndex
            )
            await activity.update(ActivityContent(state: contentState, staleDate: Date.now, relevanceScore: 100), alertConfiguration: nil)
        }
    }
}
