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
                                TextField("Score", value: $scoreTeamOne, formatter:  NumberFormatter())
                                    .keyboardType(.numbersAndPunctuation)
                            }
                            
                            VStack {
                                Text(match.playerThree)
                                Text(match.playerFour)
                                TextField("Score", value: $scoreTeamTwo, formatter:  NumberFormatter())
                                    .keyboardType(.numbersAndPunctuation)
                            }
                        }
                        
                    }
                    
                }
                .textFieldStyle(.roundedBorder)
                
                Button("Save") {
                    
                    if match.scoreTeamOne == 0 {
                        match.scoreTeamOne = scoreTeamOne ?? 0
                        
                    } else {
                        match.scoreTeamOne += scoreTeamOne ?? 0
                    }
                    
                    if match.scoreTeamTwo == 0 {
                        match.scoreTeamTwo = scoreTeamTwo ?? 0
                    } else {
                        match.scoreTeamTwo += scoreTeamTwo ?? 0
                    }
                    
                    match.playerOne = playerOne
                    match.playerTwo = playerTwo
                    match.playerThree = playerThree
                    match.playerFour = playerFour
                    match.targetScore = targetScore ?? 3000
                    
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
}
