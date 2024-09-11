import Foundation
import WidgetKit
import ActivityKit
import SwiftUI
import BackgroundTasks

open class LiveActivityManager: NSObject, ObservableObject {
    public static let shared: LiveActivityManager = LiveActivityManager(dataManager: DataManager.shared)
    
     var currentActivity: Activity<LiveActivityAttributes>? = nil
    @Published var alertItem: AlertItem?
    
    var dataManager : DataManager
    var contentStateNow = LiveActivityAttributes.ContentState.self
    

    init(dataManager: DataManager) {
        self.dataManager = dataManager
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
            transcription: dataItems[dataManager.currentIndexLV].transcription,
            title: dataItems[dataManager.currentIndexLV].title,
            description: dataItems[dataManager.currentIndexLV].description,
            engLanguage: true,
            index: dataManager.currentIndexLV
        )
        do {
            let activity = try Activity<LiveActivityAttributes>.request(
                attributes: attributes,
                content: .init(state: initialState, staleDate: nil),
                pushType: nil
            )
            currentActivity = activity
            print("LiveActivityService: \(activity.id) Live Activity создана.")
            
            Task {
                for await state in activity.activityStateUpdates {
                    if state == .dismissed {
                        print("Live Activity была удалена пользователем.")
                        self.currentActivity = nil
                    }
                }
            }
        } catch {
            alertItem = AlertItem(title: "Ошибка", message: "Ошибка при создании Live Activity: \(error.localizedDescription).")
        }
    }
    
    func endActivity() {}

    // Функция для обновления активности каждые 10 минут
     func nextCardLiveActivity(){
        Task {
            guard let currentActivity = currentActivity else {
                print("Live Activity не найдена.")
                return
            }
            
            var nextIndex = (dataManager.currentIndexLV - 1 + dataItems.count) % dataItems.count
            nextIndex = (nextIndex + 2) % dataItems.count
            
            await dataManager.updateCurrentIndexLV(to: nextIndex)
            
            let updatedState = LiveActivityAttributes.ContentState(
                transcription: dataItems[dataManager.currentIndexLV].transcription,
                title: dataItems[dataManager.currentIndexLV].title,
                description: dataItems[dataManager.currentIndexLV].description,
                engLanguage: true,
                index: dataManager.currentIndexLV
            )
            
            // Отправляем обновление активности
            await currentActivity.update(ActivityContent(state: updatedState, staleDate: Date.now, relevanceScore: 100), alertConfiguration: nil)
            print("Live Activity обновлена.")
        }
    }

    func updateActivity(id: String, engLanguage: Bool, index: Int) {
        Task {
            guard let activity = Activity<LiveActivityAttributes>.activities.first(where: { $0.id == id }) else {
                return
            }
            
            let title = !engLanguage ? dataItems[index].title : dataItems[index].translation
            let description = !engLanguage ? dataItems[index].description : dataItems[index].descriptionTranslation
            
            let contentState = LiveActivityAttributes.ContentState(
                transcription: dataItems[index].transcription,
                title: title,
                description: description,
                engLanguage: !engLanguage,
                index: index
            )
            
            await activity.update(ActivityContent(state: contentState, staleDate: Date.now, relevanceScore: 100), alertConfiguration: nil)
        }
    }
}
