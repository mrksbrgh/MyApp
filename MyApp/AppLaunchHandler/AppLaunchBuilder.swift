import Foundation

@resultBuilder
struct AppLaunchBuilder {
  static func buildBlock(_ steps: AppLaunchStep...) -> [AppLaunchStep] {
    steps
  }

  static func buildOptional(_ steps: [AppLaunchStep]?) -> [any AppLaunchStep] {
    steps ?? []
  }
}
