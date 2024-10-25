import SwiftUI
import SwiftData

@main
struct Approval_MatrixApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Matrix.self)
    }
    init(){print(URL.applicationSupportDirectory.path(percentEncoded: false))}
}
