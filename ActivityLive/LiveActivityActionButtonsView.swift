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
    let next: Bool
    let index: Int
    
    var body: some View {
        HStack {
            if next {
                Button(intent: CompleteTaskAppIntent(recordID: recordID, next: next, index: index), label: {
                    Image(systemName: "chevron.right")
                })
                .foregroundColor(.white)
                .frame(width: 30, height: 30)
                .background(Color.gray.opacity(0.8))
                .clipShape(Circle())
            } else {
                Button(intent: CompleteTaskAppIntent(recordID: recordID, next: next, index: index), label: {
                    Image(systemName: "chevron.left")
                })
                .foregroundColor(.white)
                .frame(width: 30, height: 30)
                .background(Color.gray.opacity(0.8))
                .clipShape(Circle())
            }
        }
    }
}
