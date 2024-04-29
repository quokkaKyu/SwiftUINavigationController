import SwiftUI

struct FirstView: View {
    @EnvironmentObject private var navigator: UINavigationController
    let number = 1
    var body: some View {
        VStack {
            Text("\(number)")
                .font(.title)
            Spacer()
            HStack {
                Button(action: {
                    navigator.navigateTo(route: .secondView(number: 2))
                }, label: {
                    Text("Move to 2")
                })
            }
        }
        .padding()
    }
}

#Preview {
    FirstView()
}
