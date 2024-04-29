import SwiftUI

enum AppRoute: Router {

    case firstView
    case secondView(number: Int)
    case thirdView(number: Int)

    @ViewBuilder
    func view() -> some View {
        switch self {
        case .firstView:
            FirstView()
        case .secondView(let number):
            SecondView(number: number)
        case .thirdView(let number):
            ThirdView(number: number)
        }
    }
}
