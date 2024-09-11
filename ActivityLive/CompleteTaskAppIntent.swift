import Foundation
import AppIntents

// Определяем AppIntent для завершения задачи
@available(iOS 17.0, *)
struct CompleteTaskAppIntent: LiveActivityIntent {
    init() {}
    
    // Определяем параметры для интента
    @Parameter(title: "RecordID")
    var recordID: String
    @Parameter(title: "true")
    var engLanguage: Bool
    @Parameter(title: "1")
    var index: Int
    
    // Инициализатор с параметрами
    init(recordID: String, engLanguage: Bool, index: Int) {
        self.recordID = recordID
        self.engLanguage = engLanguage
        self.index = index
    }
    
    // Конфигурируем свойства интента
    static var openAppWhenRun: Bool = false
    static var title: LocalizedStringResource = "Live activity"
    static var isDiscoverable: Bool = false
    
    // Определяем действие выполнения для интента
    func perform() async throws -> some IntentResult {
        LiveActivityManager.shared.updateActivity(id: recordID, engLanguage: engLanguage, index: index)
        return .result()
    }
}
