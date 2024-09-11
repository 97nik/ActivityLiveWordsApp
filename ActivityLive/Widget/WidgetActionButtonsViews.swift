import SwiftUI

struct WidgetActionButtonsViews: View {
    let recordID: String
    let next: Bool
    let index: Int
    
    var body: some View {
        HStack {
            if next {
                Button(intent: WidgetTaskAppIntent(recordID: recordID, next: next, index: index), label: {
                    Image(systemName: "chevron.right")
                })
                .foregroundColor(.white)
                .frame(width: 30, height: 30)
                .background(Color.gray.opacity(0.8))
                .clipShape(Circle())
            } else {
                Button(intent: WidgetTaskAppIntent(recordID: recordID, next: next, index: index), label: {
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
