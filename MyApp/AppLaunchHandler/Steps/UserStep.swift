import Foundation

struct UserStep: AppLaunchStep {
  let name: String = "User"

  func execute() async throws {
    try await Task.sleep(for: .seconds(2.0))
  }
}
