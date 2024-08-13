import Foundation

struct AlertItem: Identifiable {
    let id = UUID() // Уникальный идентификатор
    let title: String
    let message: String
}
