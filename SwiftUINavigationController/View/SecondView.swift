import SwiftUI

struct SecondView: View {
    @EnvironmentObject private var navigator: UINavigationController
    let number: Int
    var body: some View {
        VStack {
            Text("\(number)")
                .font(.title)
            Spacer()
            HStack(spacing: 50) {
                Button(action: {
                    navigator.pop()
                }, label: {
                    Text("Back to 1")
                })
                Button(action: {
                    navigator.navigateTo(route: .secondView(number: 3))
                }, label: {
                    Text("Move to 3")
                })
            }
        }
        .padding()
    }
}

#Preview {
    FirstView()
}

