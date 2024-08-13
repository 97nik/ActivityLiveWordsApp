//
//  ContentView.swift
//  ActivityLiveWords
//
//  Created by Nikita on 19.07.2024.
//
import SwiftUI

struct ContentView: View {
    @StateObject private var liveActivityManager = LiveActivityManager.shared
    
    var body: some View {
        VStack() {
            Spacer()
            Text("💬")
                .font(.system(size: 150))
                .padding(.bottom, 50)
            Spacer()
            Button(action: {
                LiveActivityManager.shared.startActivity()
            }, label: {
                Text("Start Activity")
                    .font(.title)
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
            })
            .padding(.bottom, 64)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: [Color(red: 0.4, green: 0.1, blue: 0.6), Color(red: 0.1, green: 0.3, blue: 0.7)]), startPoint: .top, endPoint: .bottom))
        .alert(item: $liveActivityManager.alertItem) { alertItem in
                   Alert(title: Text(alertItem.title), message: Text(alertItem.message), dismissButton: .default(Text("OK")))
               }
    }
}

#Preview {
    ContentView()
}
