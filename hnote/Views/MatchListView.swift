//Created by Halbus Development

import SwiftUI
import SwiftData

struct MatchListView: View {
    
    @Query private var matches: [Match]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(matches) { match in
                   MatchCardView(match: match)
                }
            }
            .navigationTitle("Lista de Partidas")
        }
    }
}

#Preview {
    MatchListView()
}
