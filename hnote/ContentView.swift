//Created by Halbus Development

import SwiftUI

struct ContentView: View {
    @State private var launchAddNewMatch: Bool = false
    
    var body: some View {
        VStack {
            
            MatchListView()
            
            Button("Inicar nova partida") {
                launchAddNewMatch.toggle()
            }
            .sheet(isPresented: $launchAddNewMatch, content: {
                AddNewMatchView()
            })
        }
    }
}

#Preview {
    ContentView()
}
