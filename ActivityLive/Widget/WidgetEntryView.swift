import SwiftUI

struct WidgetEntryView: View {
    var entry: Provider.Entry
    let dataManager = DataManager.shared

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(entry.dataItems.transcription)
                    .font(.system(size: 13))
                    .opacity(0.5)
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .invalidatableContent()
                Text(entry.dataItems.title)
                    .font(.system(size: 24))
                    .bold()
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .invalidatableContent()
                
                Text(entry.dataItems.description)
                    .font(.system(size: 15))
                    .italic()
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .invalidatableContent()
            }
            Spacer()
            VStack(alignment: .center, spacing: 16) {
                WidgetActionButtonsViews(recordID: entry.dataItems.id.uuidString, next: false, index: dataManager.currentIndexWidget)
                WidgetActionButtonsViews(recordID: entry.dataItems.id.uuidString, next: true, index: dataManager.currentIndexWidget)
            }
            .padding(.trailing, 8)
        }
        .containerBackground(for: .widget) {
            LinearGradient(gradient: Gradient(colors: [Color(red: 0.4, green: 0.1, blue: 0.6), Color(red: 0.1, green: 0.3, blue: 0.7)]), startPoint: .top, endPoint: .bottom)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
