//Created by Halbus Development

import SwiftUI
import SwiftData

struct MatchListView: View {
    
    @Query private var matches: [Match]
    @Environment(\.modelContext) private var context
    @State private var presentAddNewMAtchView: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(matches) { match in
                   MatchCardView(match: match)
                        .padding(.bottom, 10)
                }
                .onDelete(perform: delete(indexSet:))
                .listRowInsets(EdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            .scrollContentBackground(.hidden)
            .navigationTitle("Lista de Partidas")
            .navigationDestination(for: Match.self) { match in
                MatchDetailView(match: match)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        presentAddNewMAtchView.toggle()
                    } label: {
                        Image(systemName: "plus.circle")
                            .foregroundStyle(Color.white, Color.white)
                            .bold()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color.cardColor)
                    .sheet(isPresented: $presentAddNewMAtchView, content: {
                        AddNewMatchView()
                    })
                }
            }
        }
    }
    
    private func delete(indexSet: IndexSet) {
        indexSet.forEach { index in
            let match = matches[index]
            context.delete(match)
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    MatchListView()
}
