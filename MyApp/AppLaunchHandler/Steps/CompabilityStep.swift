import Foundation

struct CompabilityStep: AppLaunchStep {
  enum CompabilityError: Error {
    case requestError
  }

  let name: String = "Compability"

  func execute() async throws {
    // throw CompabilityError.requestError
    
    try await Task.sleep(for: .seconds(0.5))
  }
}
