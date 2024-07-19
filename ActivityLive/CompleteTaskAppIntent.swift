//
//  CompleteTaskAppIntent.swift
//  ActivityLiveWords
//
//  Created by Nikita on 19.07.2024.
//

import Foundation
import AppIntents

@available(iOS 17.0, *)
struct CompleteTaskAppIntent: LiveActivityIntent{
    init() {}
    
    @Parameter(title:"RecordID")
    var recordID : String
    @Parameter(title:"true")
    var next: Bool
    @Parameter(title: "1")
    var index: Int
    
    init(recordID: String, next: Bool, index: Int){
        self.recordID = recordID
        self.next = next
        self.index = index
        
    }
    
    static var openAppWhenRun: Bool = false
    
    static var title: LocalizedStringResource = "Live activity"
    
    static var isDiscoverable: Bool = false
    
    
    func perform() async throws -> some IntentResult {
        LiveActivityManager.shared.updateActivity(id: recordID, next: next, index: index)
        return .result()
    }
}
