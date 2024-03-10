//Created by Halbus Development

import SwiftUI

struct MatchDetailView: View {
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
        Form {
            if !match.isMatchFinished {
                Group {
                    VStack {
                        Text("Pontuação de Vitória")
                        Text(match.targetScore.description)
                        
                        HStack {
                            VStack {
                                Text(match.playerOne)
                                Text(match.playerTwo)
                                Text("Pontos de Canastras")
                                TextField("Pontos", value: $canastraScoreOne, format: .number)
                                    .keyboardType(.numbersAndPunctuation)
                                Text("Pontos das Cartas")
                                TextField("Pontos", value: $cardScoreOne, format: .number)
                                    .keyboardType(.numbersAndPunctuation)
                                Text("Pontos à descontar")
                                TextField("Pontos", value: $negativeScoreOne, format: .number)
                                    .keyboardType(.numbersAndPunctuation)
                            }
                            
                            VStack {
                                Text(match.playerThree)
                                Text(match.playerFour)
                                Text("Pontos de Canastras")
                                TextField("Pontos", value: $canastraScoreTwo, format: .number)
                                    .keyboardType(.numbersAndPunctuation)
                                Text("Pontos das Cartas")
                                TextField("Pontos", value: $cardScoreTwo, format: .number)
                                    .keyboardType(.numbersAndPunctuation)
                                Text("Pontos à descontar")
                                TextField("Pontos", value: $negativeScoreTwo, format: .number)
                                    .keyboardType(.numbersAndPunctuation)
                            }
                        }
                        
                    }
                    
                }
                .textFieldStyle(.roundedBorder)
                
                Button("Save") {
                                      
                    match.playerOne = playerOne
                    match.playerTwo = playerTwo
                    match.playerThree = playerThree
                    match.playerFour = playerFour
                    match.targetScore = targetScore ?? 3000
                    match.scoreTeamOne = calculeTeamScore(
                        dbScore: match.scoreTeamOne,
                        canastraScore: canastraScoreOne ?? 0,
                        cardScore: cardScoreOne ?? 0,
                        negativeScore: negativeScoreOne ?? 0
                    )
                    match.scoreTeamTwo = calculeTeamScore(
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
                        try context.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                    dismiss()
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
        }
//        .toolbar {
//            ToolbarItem(placement: .topBarTrailing) {
//                Button(isEditing ? "Done" : "Edit") {
//                    isEditing.toggle()
//                }
//            }
//        }
//        .navigationTitle("Detalhes da Partida")
    }
    
    private func calculeTeamScore(dbScore: Int, canastraScore: Int, cardScore: Int, negativeScore: Int) -> Int {
        let parcialScore: Int =  (canastraScore + cardScore - negativeScore)
        return parcialScore + dbScore
    }
}
