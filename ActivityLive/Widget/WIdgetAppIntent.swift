import AppIntents
import WidgetKit

// AppIntent для обработки задач, связанных с виджетом
struct WidgetTaskAppIntent: AppIntent {
    init() {}
    
    // Свойства для намерения
    @Parameter(title: "RecordID")
    var recordID: String
    @Parameter(title: "Next")
    var next: Bool
    @Parameter(title: "Index")
    var index: Int
    
    // Пользовательский инициализатор
    init(recordID: String, next: Bool, index: Int) {
        self.recordID = recordID
        self.next = next
        self.index = index
    }
    
    // Заголовок намерения
    static var title: LocalizedStringResource = "Widget"
    
    // Функция для выполнения действия намерения
    func perform() async throws -> some IntentResult {
        // Доступ к общему экземпляру менеджера данных
        let dataManager = DataManager.shared
        
        // Вычисляем следующий индекс для элементов данных
        var nextIndex = (dataManager.currentIndexWidget - 1 + dataItems.count) % dataItems.count

        // Обновляем индекс на основе булевого значения `next`
        if next {
            nextIndex = (nextIndex + 2) % dataItems.count
        } else {
            nextIndex = (nextIndex + dataItems.count) % dataItems.count
        }
        
        // Обновляем текущий индекс в менеджере данных и перезагружаем временные шкалы виджетов
        await dataManager.updateCurrentIndexWidget(to: nextIndex)
        WidgetCenter.shared.reloadTimelines(ofKind: "ActivityWidget")
        
        return .result()
    }
}
