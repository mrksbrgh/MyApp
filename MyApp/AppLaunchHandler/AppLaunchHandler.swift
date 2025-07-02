import Foundation

struct AppLaunchHandler {
  enum StatusError: Error {
    case groupFailed
  }

  private let groups: [AppLaunchStep]

  init(@AppLaunchBuilder _ builder: () -> [AppLaunchStep]) {
    self.groups = builder()
  }

  func handler() -> AsyncThrowingStream<String, Error> {
    AsyncThrowingStream { continuation in
      Task {
        for group in groups {
          do {
            print("\(group.name) initiated")
            try await group.execute()
            continuation.yield(group.name)
            print("\(group.name) finished")
          } catch {
            continuation.finish(throwing: StatusError.groupFailed)
          }
        }

        continuation.finish()
      }
    }
  }
}
