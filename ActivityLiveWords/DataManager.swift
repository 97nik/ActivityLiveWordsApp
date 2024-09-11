//
//  DataItems.swift
//  ActivityLiveWords
//
//  Created by Nikita on 19.07.2024.
//

import Foundation

struct DataItems: Identifiable, Codable, Hashable {
    var id = UUID()
    var transcription: String
    var title: String
    var description: String
    var translation: String
    var descriptionTranslation: String
}

class DataManager {
    static let shared = DataManager()
    
    private let appGroup = "group.com.yourAppGroup"
    private let defaults: UserDefaults?
    private let dataKey = "dataItems"
    private let indexLVKey = "currentIndexLV"
    private let indexWidgetKey = "currentIndexWidget"
    
    var currentIndexLV: Int {
        get {
            return defaults?.integer(forKey: indexLVKey) ?? 0
        }
        set {
            defaults?.set(newValue, forKey: indexLVKey)
        }
    }
    
    var currentIndexWidget: Int {
        get {
            return defaults?.integer(forKey: indexWidgetKey) ?? 0
        }
        set {
            defaults?.set(newValue, forKey: indexWidgetKey)
        }
    }
    
    init() {
        defaults = UserDefaults(suiteName: appGroup)
        saveDataItems(dataItems)
    }
    
    func saveDataItems(_ items: [DataItems]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(items) {
            defaults?.set(encoded, forKey: dataKey)
        }
    }
    
    func loadDataItems() -> [DataItems] {
        if let savedData = defaults?.data(forKey: dataKey) {
            let decoder = JSONDecoder()
            if let loadedData = try? decoder.decode([DataItems].self, from: savedData) {
                return loadedData
            }
        }
        return []
    }
    
    func updateCurrentIndexLV(to index: Int) async {
        self.currentIndexLV = index
    }
    
    func updateCurrentIndexWidget(to index: Int) async {
        self.currentIndexWidget = index
    }
}

let dataItems: [DataItems] = [
    DataItems(transcription: "[ɪɡˈzæmpl]", title: "Example", description: "A representative form or pattern.", translation: "Пример", descriptionTranslation: "Представительная форма или образец."),
    DataItems(transcription: "[ˈæktɪv]", title: "Active", description: "Engaging or ready to engage in physically energetic pursuits.", translation: "Активный", descriptionTranslation: "Занимающийся или готовый заниматься физически энергичными занятиями."),
    DataItems(transcription: "[kənˈklud]", title: "Conclude", description: "To bring to an end.", translation: "Заключить", descriptionTranslation: "Привести к завершению."),
    DataItems(transcription: "[ˈsʌbʤɪkt]", title: "Subject", description: "A person or thing that is being discussed.", translation: "Предмет", descriptionTranslation: "Лицо или вещь, о которой идет речь."),
    DataItems(transcription: "[ˈɪnflʊəns]", title: "Influence", description: "The capacity to have an effect on the character, development, or behavior of someone or something.", translation: "Влияние", descriptionTranslation: "Способность оказывать влияние на характер, развитие или поведение кого-то или чего-то."),
    DataItems(transcription: "[ˈsʌbstəns]", title: "Substance", description: "The real physical matter of which a person or thing consists.", translation: "Субстанция", descriptionTranslation: "Реальное физическое вещество, из которого состоит человек или вещь."),
    DataItems(transcription: "[ˈædvəˌkeɪt]", title: "Advocate", description: "A person who publicly supports or recommends a particular cause or policy.", translation: "Адвокат", descriptionTranslation: "Человек, который публично поддерживает или рекомендует определенную причину или политику."),
    DataItems(transcription: "[ˈbɛnɪfɪt]", title: "Benefit", description: "An advantage or profit gained from something.", translation: "Польза", descriptionTranslation: "Преимущество или выгода, полученная от чего-то."),
    DataItems(transcription: "[ˈkɒntɛkst]", title: "Context", description: "The circumstances that form the setting for an event, statement, or idea.", translation: "Контекст", descriptionTranslation: "Обстоятельства, которые формируют обстановку для события, утверждения или идеи.")
]
