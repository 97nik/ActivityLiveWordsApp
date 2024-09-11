import UIKit
import BackgroundTasks
import ActivityKit

class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Регистрация фоновой задачи
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "ru.touchin.ActivityLiveWords.up", using: nil) { task in
            self.handleBackgroundUpdate(task: task as! BGAppRefreshTask)
        }
        
        // Запланировать фоновое обновление при запуске приложения
        scheduleBackgroundUpdate()
        
        return true
    }

    // Планирование фоновой задачи
    func scheduleBackgroundUpdate() {
        let request = BGAppRefreshTaskRequest(identifier: "ru.touchin.ActivityLiveWords.up")
        request.earliestBeginDate = Date(timeIntervalSinceNow: 10) // Через 1 минуту
        
        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print("Ошибка планирования фоновой задачи: \(error)")
        }
    }

    // Обработка фоновой задачи
    func handleBackgroundUpdate(task: BGAppRefreshTask) {
        // Запланировать следующее обновление
        scheduleBackgroundUpdate()
        
        // Обновить активность Live Activity
        Task {
            await updateLiveActivity()
        }

        // Уведомить систему, что задача завершена
        task.setTaskCompleted(success: true)
    }

    // Метод для обновления активности
    func updateLiveActivity() async {
        guard let currentActivity = LiveActivityManager.shared.currentActivity else {
            print("Live Activity не найдена.")
            return
        }

        let updatedState = LiveActivityAttributes.ContentState(
            transcription: dataItems[1].transcription,
            title: dataItems[1].title,
            description: dataItems[1].description,
            engLanguage: true,
            index: 1
        )
        
        // Обновляем активность
        await currentActivity.update(ActivityContent(state: updatedState, staleDate: Date.now, relevanceScore: 100), alertConfiguration: nil)
        print("Live Activity обновлена.")
    }
}
