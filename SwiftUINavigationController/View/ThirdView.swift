import SwiftUI

struct ThirdView: View {
    @EnvironmentObject private var navigator: UINavigationController
    let number: Int
    var body: some View {
        VStack {
            Text("\(number)")
                .font(.title)
            Spacer()
            HStack(spacing: 50) {
                Button(action: {
                    navigator.popToRoot()
                }, label: {
                    Text("Back to 1")
                })
                Button(action: {
                    navigator.pop()
                }, label: {
                    Text("Back to 2")
                })
            }
        }
        .padding()
    }
}

#Preview {
    FirstView()
}
