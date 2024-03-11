//Created by Halbus Development

import SwiftUI
import SwiftData

struct AddNewMatchView: View {
    
    @State private var playerOne: String = ""
    @State private var playerTwo: String = ""
    @State private var playerThree: String = ""
    @State private var playerFour: String = ""
    @State private var targetScore: Int?
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    var isValid: Bool {
        !playerOne.isEmpty && !playerTwo.isEmpty && targetScore != nil
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Criar Nova Partida")
                    .font(.title2)
                    .foregroundStyle(Color.primary)
                    .padding(.bottom, 20 )
                
                addNewMatchViewHeader
                    .padding(.bottom, 10)
                
                addNewMatchViewTeams
                    .padding(.bottom, 20)
    
                HStack {
                    
                    Spacer()
                    
                    Button("Cancel", role: .destructive) {
                        dismiss()
                    }
                    .buttonStyle(.bordered)
                    
                    Spacer()
                    
                    Button("Save") {
                        guard let targetScore else { return }
                        let match: Match = Match(
                            date: Date(),
                            playerOne: playerOne,
                            playerTwo: playerTwo,
                            playerThree: playerThree,
                            playerFour: playerFour,
                            scoreTeamOne: 0,
                            scoreTeamTwo: 0,
                            targetScore: targetScore, 
                            isMatchFinished: false
                        )
                        
                        context.insert(match)
                        
                        do {
                            try context.save()
                        } catch {
                            print(error.localizedDescription)
                        }
                        
                        dismiss()
                    }
                    .buttonStyle(.bordered)
                    .disabled(!isValid)
                    
                    Spacer()
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Iniciar uma nova partida")
    }
    
    private var addNewMatchViewHeader: some View {
        VStack {
            Text("Digite a Pontuação Mínima de Vitória")
                .font(.title3)
            TextField("Entre a pontuação", value: $targetScore, format: .number)
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)
                .multilineTextAlignment(TextAlignment.center)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.textFieldBorderColor)
                )
        }
        .padding(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .inset(by: 2)
                .stroke(Color.cardColor, lineWidth: 2)
        )
    }
    
    private var addNewMatchViewTeams: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Dupla 1")
                    .font(.title)
                TextField("Nome do Jogador 1", text: $playerOne)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.textFieldBorderColor)
                    )
                TextField("Nome do Jogador 2", text: $playerTwo)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.textFieldBorderColor)
                    )
            }
            .multilineTextAlignment(TextAlignment.leading)
            .textFieldStyle(.roundedBorder)
            
            VStack(alignment: .trailing) {
                Text("Dupla 2")
                    .font(.title)
                TextField("Nome do Jogador 1", text: $playerThree)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.textFieldBorderColor)
                    )
                TextField("Nome do Jogador 2", text: $playerFour)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.textFieldBorderColor)
                    )
            }
            .multilineTextAlignment(TextAlignment.trailing)
            .textFieldStyle(.roundedBorder)
        }
        .padding(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .inset(by: 2)
                .stroke(Color.cardColor, lineWidth: 2)
        )
    }
}
