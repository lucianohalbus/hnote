//Created by Halbus Development

import SwiftUI

struct MatchListView: View {

    private var matchesDB: [MatchDB]
    @Environment(\.modelContext) private var context
    @State private var presentAddNewMatchView: Bool = false
    @ObservedObject private var itemListVM = MatchFBListViewModel()
        
        var body: some View {
            NavigationStack {
                VStack {
                    List {
                        ForEach(matchesDB) { match in
                           MatchCardView(matchDB: match)
                                .padding(.bottom, 10)
                        }
                        .onDelete(perform: delete(indexSet:))
                        .listRowInsets(EdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .listRowBackground(Color.clear)
                    }
                    .scrollContentBackground(.hidden)
                    .navigationDestination(for: MatchDB.self) { match in
                        MatchResumeView(matchDB: match)
                    }
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button {
                                presentAddNewMatchView.toggle()
                            } label: {
                                Image(systemName: "plus.circle")
                                    .foregroundStyle(Color.white, Color.white)
                                    .bold()
                            }
                            .buttonStyle(.borderedProminent)
                            .padding(.trailing, 20)
                            .tint(Color.cardColor)
                            .sheet(isPresented: $presentAddNewMatchView, content: {
                                AddNewMatchView()
                                    .presentationDetents([.fraction(0.6)])
                                    .interactiveDismissDisabled()
                            })
                        }
                    }
                }
                .navigationTitle("Lista de Partidas")
            }
        }
        
        private func delete(indexSet: IndexSet) {
            indexSet.forEach { index in
                let match = matchesDB[index]
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
