import SwiftUI

public protocol Router {
    associatedtype V: View
    
    @ViewBuilder
    func view() -> V
}
