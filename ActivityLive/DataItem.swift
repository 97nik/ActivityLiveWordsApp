//
//  DataItems.swift
//  ActivityLiveWords
//
//  Created by Nikita on 19.07.2024.
//

import Foundation

struct DataItem: Identifiable, Codable, Hashable {
    var id = UUID()
    var transcription: String
    var title: String
    var description: String
}

let dataItems: [DataItem] = [
    DataItem(transcription: "[ˈhɛtərəˌdɒks]", title: "Heterodox", description: "Having unusual or different beliefs."),
    DataItem(transcription: "[ɪɡˈzæmpl]", title: "Example", description: "A representative form or pattern."),
    DataItem(transcription: "[ˈæktɪv]", title: "Active", description: "Engaging or ready to engage in physically energetic pursuits."),
    DataItem(transcription: "[kənˈklud]", title: "Conclude", description: "To bring to an end."),
    DataItem(transcription: "[ˈsʌbʤɪkt]", title: "Subject", description: "A person or thing that is being discussed."),
    DataItem(transcription: "[ˈɪnflʊəns]", title: "Influence", description: "The capacity to have an effect on the character, development, or behavior of someone or something."),
    DataItem(transcription: "[ˈsʌbstəns]", title: "Substance", description: "The real physical matter of which a person or thing consists."),
    DataItem(transcription: "[ˈædvəˌkeɪt]", title: "Advocate", description: "A person who publicly supports or recommends a particular cause or policy."),
    DataItem(transcription: "[ˈbɛnɪfɪt]", title: "Benefit", description: "An advantage or profit gained from something."),
    DataItem(transcription: "[ˈkɒntɛkst]", title: "Context", description: "The circumstances that form the setting for an event, statement, or idea.The circumstances that form the setting for an event, statement, or idea. The circumstances that form the setting for an event, statement, or idea. The circumstances that form the setting for an event, statement, or idea.")
]
