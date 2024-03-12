//Created by Halbus Development

import SwiftUI
import SwiftData
import Firebase

@main
struct hnoteApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [Match.self])
                
        }
    }
}
