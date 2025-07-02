import SwiftUI

final class MyAppViewModel: ObservableObject {
  enum State {
    case pending
    case finished
    case error
  }

  @Published var state: State = .pending
}
