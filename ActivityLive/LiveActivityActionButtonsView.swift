//
//  LiveActivityActionButtonsView.swift
//  ActivityLiveWords
//
//  Created by Nikita on 19.07.2024.
//

import Foundation
import SwiftUI

@available(iOS 16.1, *)
struct LiveActivityActionButtonsView: View {
    let recordID: String
    let engLanguage: Bool
    let index: Int
    
    var body: some View {
        HStack {
            Button(intent: CompleteTaskAppIntent(recordID: recordID, engLanguage: engLanguage, index: index), label: {
                Image(systemName: "arrow.up.arrow.down")
            })
            .foregroundColor(.white)
            .frame(width: 30, height: 30)
            .background(Color.gray.opacity(0.8))
            .clipShape(Circle())
        }
    }
}
