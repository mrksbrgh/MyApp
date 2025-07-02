import Foundation

struct FirebaseStep: AppLaunchStep {
  enum FirebaseError: Error {
    case requestError
  }

  let name: String = "Firebase"

  func execute() async throws {
    // throw FirebaseError.requestError

    try await Task.sleep(for: .seconds(0.5))
  }
}
