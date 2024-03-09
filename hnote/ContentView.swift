//Created by Halbus Development

import SwiftUI

struct ContentView: View {
    @State private var launchAddNewMatch: Bool = false
    
    var body: some View {
//        Button("Inicar nova partida") {
//            launchAddNewMatch.toggle()
//        }
//        .sheet(isPresented: $launchAddNewMatch, content: {
//            AddNewMatchView()
//        })
        
        MatchListView()
    }
}

#Preview {
    ContentView()
}
