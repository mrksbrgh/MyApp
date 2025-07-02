import Foundation

public protocol AppLaunchStep {
  var name: String { get }

  func execute() async throws
}
