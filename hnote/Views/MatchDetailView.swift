//Created by Halbus Development

import SwiftUI

struct AddNewMatchTurnView: View {
    let match: Match
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
    
    init(match: Match) {
        self.match = match
        self._playerOne = State.init(initialValue: match.playerOne)
        self._playerTwo = State.init(initialValue: match.playerTwo)
        self._playerThree = State.init(initialValue: match.playerThree)
        self._playerFour = State.init(initialValue: match.playerFour)
        self._scoreTeamOne = State.init(initialValue:  match.scoreTeamOne)
        self._scoreTeamTwo = State.init(initialValue: match.scoreTeamTwo)
        self._targetScore = State.init(initialValue: match.targetScore)
    }
    var body: some View {
        VStack {
            if !match.isMatchFinished {
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
                                          
                        match.playerOne = playerOne
                        match.playerTwo = playerTwo
                        match.playerThree = playerThree
                        match.playerFour = playerFour
                        match.targetScore = targetScore ?? 3000
                        match.scoreTeamOne = calculateTotalScore(
                            dbScore: match.scoreTeamOne,
                            canastraScore: canastraScoreOne ?? 0,
                            cardScore: cardScoreOne ?? 0,
                            negativeScore: negativeScoreOne ?? 0
                        )
                        
                        match.scoreTeamTwo = calculateTotalScore(
                            dbScore: match.scoreTeamTwo,
                            canastraScore: canastraScoreTwo ?? 0,
                            cardScore: cardScoreTwo ?? 0,
                            negativeScore: negativeScoreTwo ?? 0
                        )
                        
                        if match.scoreTeamOne >= targetScore ?? 3000  || match.scoreTeamTwo >= targetScore ?? 30000 {
                            match.isMatchFinished = true
                        } else {
                            match.isMatchFinished = false
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
                            
                            let matchResume: MatchResume = MatchResume(
                                date: Date(),
                                partialScoreTeamOne: partialScoreTeamOne,
                                partialScoreTeamTwo: partialScoreTeamTwo
                            )
                            
                            match.matchResume.append(matchResume)
                            
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
                    Text(match.targetScore.description)
                    
                    HStack {
                        VStack {
                            Text(match.playerOne)
                            Text(match.playerTwo)
                            Text(match.scoreTeamOne.description)
                        }
                        
                        VStack {
                            Text(match.playerThree)
                            Text(match.playerFour)
                            Text(match.scoreTeamTwo.description)
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
            Text(match.playerOne)
                .font(.title2)
                .bold()
            
            Text(match.playerTwo)
                .font(.title2)
                .bold()
            
            Text(match.scoreTeamOne.description)
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
            Text(match.playerThree)
                .font(.title2)
                .bold()
            
            Text(match.playerFour)
                .font(.title2)
                .bold()
            
            Text(match.scoreTeamTwo.description)
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
