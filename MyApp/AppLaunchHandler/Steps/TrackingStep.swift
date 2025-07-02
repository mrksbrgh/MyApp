import Foundation

struct TrackingStep: AppLaunchStep {
  let name: String = "Tracking"

  func execute() async throws {
    try await Task.sleep(for: .seconds(3.0))
  }
}
