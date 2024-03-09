//Created by Halbus Development

import SwiftUI
import SwiftData

@main
struct hnoteApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [Match.self])
                
        }
    }
}
