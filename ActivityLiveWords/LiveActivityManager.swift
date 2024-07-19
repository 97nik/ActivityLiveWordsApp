//
//  LiveActivityManager.swift
//  ActivityLiveWords
//
//  Created by Nikita on 19.07.2024.
//

import Foundation
import ActivityKit
import os.log
import UIKit

open class LiveActivityManager: NSObject, ObservableObject {
    public static let shared: LiveActivityManager = LiveActivityManager()
    
    private var currentActivity: Activity<LiveActivityAttributes>? = nil
    
    override init() {
        super.init()
    }
    
    func startActivity() {
        guard ActivityAuthorizationInfo().areActivitiesEnabled else {
            print("You can't start live activity.")
            return
        }
        
        let attributes = LiveActivityAttributes(name: "Live Activity Example")
        let initialState = LiveActivityAttributes.ContentState(
            transcription: dataItems[0].transcription,
            title: dataItems[0].title,
            description: dataItems[0].description,
            index: 0
        )
        do {
            let activity = try Activity<LiveActivityAttributes>.request(
                attributes: attributes,
                content: .init(state:initialState , staleDate: nil),
                pushType: nil
            )
            print("LiveActivityService: \(activity.id) Live Activity created.")
        } catch {
            print("LiveActivityService: Error when make new Live Activity: \(error.localizedDescription).")
        }
        
    }
    
    func endActivity(dismissTimeInterval: Double?) {}
    
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
