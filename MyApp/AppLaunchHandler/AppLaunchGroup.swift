import Foundation

enum AppLaunchGroupType {
  case sequential
  case parallel
}

struct AppLaunchGroup: AppLaunchStep {
  let name: String
  let type: AppLaunchGroupType
  let steps: [AppLaunchStep]

  init(
    name: String,
    type: AppLaunchGroupType,
    @AppLaunchBuilder builder: () -> [AppLaunchStep]
  ) {
    self.type = type
    self.name = name
    self.steps = builder()
  }

  func execute() async throws {
    switch type {
    case .sequential:
      for step in steps {
        print("\(step.name) initiated")
        try await step.execute()
        print("\(step.name) finished")
      }
    case .parallel:
      try await withThrowingTaskGroup(of: Void.self) { group in
        for step in steps {
          group.addTask {
            print("\(step.name) initiated")
            try await step.execute()
            print("\(step.name) finished")
          }
        }

        try await group.waitForAll()
      }
    }
  }
}
