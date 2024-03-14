//Created by Halbus Development

import SwiftUI

struct AddNewMatchTurnView: View {
    let matchDB: MatchDB
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var playerOne: String = ""
    @State private var playerTwo: String = ""
    @State private var playerThree: String = ""
    @State private var playerFour: String = ""
    @State private var scoreTeamOne: Int? = nil
    @State private var scoreTeamTwo: Int? = nil
    @State private var targetScore: Int? = nil
    @State private var cardScoreOne: Int? = nil
    @State private var canastraScoreOne: Int? = nil
    @State private var negativeScoreOne: Int? = nil
    @State private var cardScoreTwo: Int? = nil
    @State private var canastraScoreTwo: Int? = nil
    @State private var negativeScoreTwo: Int? = nil
    
    private var isValid: Bool {
        cardScoreOne != nil  &&
        cardScoreTwo != nil  &&
        canastraScoreOne != nil  &&
        canastraScoreTwo != nil  &&
        negativeScoreOne != nil  &&
        negativeScoreTwo != nil 
    }
    
    init(match: MatchDB) {
        self.matchDB = match
        self._playerOne = State.init(initialValue: match.playerOne)
        self._playerTwo = State.init(initialValue: match.playerTwo)
        self._playerThree = State.init(initialValue: match.playerThree)
        self._playerFour = State.init(initialValue: match.playerFour)
        self._scoreTeamOne = State.init(initialValue:  match.finalScoreOne)
        self._scoreTeamTwo = State.init(initialValue: match.finalScoreTwo)
        self._targetScore = State.init(initialValue: match.targetScore)
    }
    var body: some View {
        VStack {
            if !matchDB.isMatchFinished {
                Group {
                    VStack {
            
                        Text("Digite a Pontuação da Rodada")
                            .font(.title2)
                            .bold()
                            .padding(.top, 10)
                        
                        Text("Preencha todos os campos")
                            .font(.title3)
                        
                        Divider()
                            .frame(height: 1)
                            .background(Color.cardColor)
                            .padding(.vertical, 10)
                        
                        HStack {

                            scoresLeftSide
                            
                            Divider()
                                .frame(width: 1, height: 300)
                                .background(Color.cardColor)
                            
                            scoresRightSide

                        }
                        
                    }
                    .padding(.horizontal, 10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .inset(by: 2)
                            .stroke(Color.cardColor, lineWidth: 2)
                    )
                    .padding(.horizontal, 5)
                    
                }
                .textFieldStyle(.roundedBorder)
                
                HStack {
                    
                    Spacer()
                    
                    Button("Cancel", role: .destructive) {
                        dismiss()
                    }
                    .buttonStyle(.bordered)
                    
                    Spacer()
                    
                    Button("Save") {
                                          
                        matchDB.playerOne = playerOne
                        matchDB.playerTwo = playerTwo
                        matchDB.playerThree = playerThree
                        matchDB.playerFour = playerFour
                        matchDB.targetScore = targetScore ?? 3000
                        matchDB.finalScoreOne = calculateTotalScore(
                            dbScore: matchDB.finalScoreOne,
                            canastraScore: canastraScoreOne ?? 0,
                            cardScore: cardScoreOne ?? 0,
                            negativeScore: negativeScoreOne ?? 0
                        )
                        
                        matchDB.finalScoreTwo = calculateTotalScore(
                            dbScore: matchDB.finalScoreTwo,
                            canastraScore: canastraScoreTwo ?? 0,
                            cardScore: cardScoreTwo ?? 0,
                            negativeScore: negativeScoreTwo ?? 0
                        )
                        
                        if matchDB.finalScoreOne >= targetScore ?? 3000  || matchDB.finalScoreTwo >= targetScore ?? 30000 {
                            matchDB.isMatchFinished = true
                        } else {
                            matchDB.isMatchFinished = false
                        }
                        
                        do {
                            
                            let partialScoreTeamOne: Int = calculatePartialScore(
                                canastraScore: canastraScoreOne ?? 0,
                                cardScore: cardScoreOne ?? 0,
                                negativeScore: negativeScoreOne ?? 0
                            )
                            
                            let partialScoreTeamTwo: Int = calculatePartialScore(
                                canastraScore: canastraScoreTwo ?? 0,
                                cardScore: cardScoreTwo ?? 0,
                                negativeScore: negativeScoreTwo ?? 0
                            )
                            
                            let matchResume: MatchResumeDB = MatchResumeDB(
                                date: Date(),
                                partialScoreTeamOne: partialScoreTeamOne,
                                partialScoreTeamTwo: partialScoreTeamTwo
                            )
                            
                            matchDB.matchResumeDB.append(matchResume)
                            
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
            } else {
                VStack {
                    Text("Pontuação de Vitória")
                    Text(matchDB.targetScore.description)
                    
                    HStack {
                        VStack {
                            Text(matchDB.playerOne)
                            Text(matchDB.playerTwo)
                            Text(matchDB.finalScoreOne.description)
                        }
                        
                        VStack {
                            Text(matchDB.playerThree)
                            Text(matchDB.playerFour)
                            Text(matchDB.finalScoreTwo.description)
                        }
                    }
                }
            }
            
            Spacer()
        }
        .padding(20)
    }
    
    private var scoresLeftSide: some View {
        VStack(alignment: .leading) {
            Text(matchDB.playerOne)
                .font(.title2)
                .bold()
            
            Text(matchDB.playerTwo)
                .font(.title2)
                .bold()
            
            Text(matchDB.finalScoreOne.description)
                .font(.title2)
                .bold()
                .padding(.bottom, 10)
            
            Text("Pontos de Canastras")
                .font(.headline)
            
            TextField("Pontos", value: $canastraScoreOne, format: .number)
                .keyboardType(.numberPad)
                .padding(.bottom, 20)
            
            Text("Pontos das Cartas")
                .font(.headline)
            
            TextField("Pontos", value: $cardScoreOne, format: .number)
                .keyboardType(.numberPad)
                .padding(.bottom, 20)
            
            Text("Pontos à descontar")
                .font(.headline)
            
            TextField("Pontos", value: $negativeScoreOne, format: .number)
                .keyboardType(.numberPad)
                .padding(.bottom, 20)
        }
        .textFieldStyle(.roundedBorder)
        .multilineTextAlignment(TextAlignment.leading)
    }
    
    private var scoresRightSide: some View {
        VStack(alignment: .trailing) {
            Text(matchDB.playerThree)
                .font(.title2)
                .bold()
            
            Text(matchDB.playerFour)
                .font(.title2)
                .bold()
            
            Text(matchDB.finalScoreTwo.description)
                .font(.title2)
                .bold()
                .padding(.bottom, 10)
            
            Text("Pontos de Canastras")
                .font(.headline)
            
            TextField("Pontos", value: $canastraScoreTwo, format: .number)
                .keyboardType(.numberPad)
                .padding(.bottom, 20)
            
            Text("Pontos das Cartas")
                .font(.headline)
            
            TextField("Pontos", value: $cardScoreTwo, format: .number)
                .keyboardType(.numberPad)
                .padding(.bottom, 20)
            
            Text("Pontos à descontar")
                .font(.headline)
            
            TextField("Pontos", value: $negativeScoreTwo, format: .number)
                .keyboardType(.numberPad)
                .padding(.bottom, 20)
        }
        .textFieldStyle(.roundedBorder)
        .multilineTextAlignment(TextAlignment.trailing)
    }
    
    private func calculatePartialScore(canastraScore: Int, cardScore: Int, negativeScore: Int) -> Int {
        return (canastraScore + cardScore - negativeScore)
        
    }
    
    private func calculateTotalScore(dbScore: Int, canastraScore: Int, cardScore: Int, negativeScore: Int) -> Int {
        let partialScore: Int =  (canastraScore + cardScore - negativeScore)
        return partialScore + dbScore
    }
}
