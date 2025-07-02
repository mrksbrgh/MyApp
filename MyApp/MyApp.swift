import SwiftUI

@main
struct MyApp: App {
  @StateObject private var viewModel = MyAppViewModel()

  private let launch: AppLaunchHandler

  init() {
    launch = AppLaunchHandler {
      AppLaunchGroup(name: "Parent group", type: .sequential) {
        CompabilityStep()
        FirebaseStep()

        AppLaunchGroup(name: "Child group", type: .parallel) {
          TrackingStep()
          UserStep()
        }
      }
    }
  }

  func configure() {
    Task { @MainActor in
      do {
        for try await _ in launch.handler() {
          // Handle status
        }

        print("🎉 All launch steps completed. Continue to UI.")

        viewModel.state = .finished
      } catch {
        print("❌ Launch failed with unexpected error: \(error)")

        viewModel.state = .error
      }
    }
  }

  var body: some Scene {
    WindowGroup {
      VStack {
        switch viewModel.state {
        case .pending:
          ProgressView()
        case .error:
          Text("Something went wrong.")
        case .finished:
          ContentView()
        }
      }
      .onAppear {
        configure()
      }
    }
  }
}
