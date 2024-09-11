import SwiftUI
import WidgetKit

// Основная структура виджета ActivityWidget, которая реализует протокол Widget
struct ActivityWidget: Widget {
    // Уникальный идентификатор виджета
    let kind: String = "ActivityWidget"

    // Свойство body определяет конфигурацию виджета
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            // Представление виджета для каждой записи
            WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Activity Widget") // Имя, отображаемое в галерее виджетов
        .description("Этот виджет показывает тот же контент, что и Живая Активность.") // Описание в галерее виджетов
        .supportedFamilies([.systemMedium]) // Поддерживаемые размеры виджета
    }
}

// Поставщик временной шкалы для виджета, определяет данные и логику обновления
struct Provider: TimelineProvider {
    // Общий экземпляр менеджера данных
    let dataManager = DataManager.shared
    
    // Данные-заполнитель, показываемые в галерее виджетов
    func placeholder(in context: Context) -> SimpleEntry {
        // Получаем текущий элемент данных с использованием текущего индекса виджета
        let dataItem = dataItems[dataManager.currentIndexWidget]
        return SimpleEntry(dataItems: dataItem)
    }

    // Снимок данных, используемый для предварительного просмотра виджета
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        // Получаем текущий элемент данных для снимка
        let dataItem = dataItems[dataManager.currentIndexWidget]
        let entry = SimpleEntry(dataItems: dataItem)
        completion(entry)
    }

    // Временная шкала данных для регулярного обновления виджета
    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        // Получаем текущий элемент данных для временной шкалы
        let dataItem = dataItems[dataManager.currentIndexWidget]
        // Создаем временную шкалу с единственной записью и политикой обновления в конце
        let entries = [SimpleEntry(dataItems: dataItem)]
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

// Структура записи для временной шкалы виджета
struct SimpleEntry: TimelineEntry {
    // Дата записи, по умолчанию текущее время
    var date: Date = .now
    // Элементы данных, связанные с этой записью
    let dataItems: DataItems
}


#Preview(as: WidgetFamily.systemMedium) {
    ActivityWidget()
} timeline: {
    SimpleEntry(dataItems: dataItems[0])
    SimpleEntry(dataItems: dataItems[5])
    SimpleEntry(dataItems: dataItems[2])
}
