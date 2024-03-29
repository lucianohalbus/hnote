//Created by Halbus Development

import SwiftUI

struct MatchResumeView: View {
    var matchDB: MatchDB
    @State private var presentAddNewMatchTurnView: Bool = false
    
    var body: some View {
        VStack {
            
            matchResumeViewHeader
            
            ScrollView {
                
                matchResumeViewList
                
                if !matchDB.isMatchFinished {
                
                    Button {
                        
                        presentAddNewMatchTurnView.toggle()
                        
                    } label: {
                        Text("Adinonar nova rodada")
                            .font(.title2)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.cardColor)
                            .cornerRadius(20)
                            .foregroundStyle(Color.white)
                            .bold()
                            .padding(.top, 20)
                    }
                    .sheet(isPresented: $presentAddNewMatchTurnView, content: {
                        
                        AddNewMatchTurnView(match: matchDB)
                            .presentationDetents([.fraction(0.7)])
                            .interactiveDismissDisabled()
                    })
                
                } 
            }
        }
        .padding()
        
    }
    
    private var matchResumeViewHeader: some View {
        VStack {
            Text(!matchDB.isMatchFinished ? "Pontuação" : "Partida Encerrada")
                .font(.title)
                .foregroundColor(.cardColor)
                .bold()
            
            HStack {

                VStack (alignment: .leading) {
                    Text(matchDB.playerOne)
                    Text(matchDB.playerTwo)
                    Text(matchDB.scoreTeamOne.description)
                        .foregroundStyle(Color.cardColor)
                        .bold()
                }
                .foregroundStyle(Color.black)
                
                Spacer()
                
                Divider()
                    .frame(width: 1, height: 50)
                    .background(Color.white)
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text(matchDB.playerThree)
                    Text(matchDB.playerFour)
                    Text(matchDB.scoreTeamTwo.description)
                        .foregroundStyle(Color.cardColor)
                        .bold()
                }
                .foregroundStyle(Color.black)
            }
            .font(.title)
            .foregroundColor(.white)
            .padding(15)
            .background(Color.textViewBackgroundColor)
            .cornerRadius(20)
        }
    }
    
    private var matchResumeViewList: some View {
        VStack(spacing: 5) {
            ForEach(matchDB.matchResumeDB) { matchResume in
    
                HStack(spacing: 5) {

                    Text(matchResume.partialScoreTeamOne.description)
                    Spacer()
                    
                    Text(matchResume.date.formatted(date: .abbreviated, time: .shortened))
                    
                    Spacer()
                    Text(matchResume.partialScoreTeamTwo.description)

                }
                .font(.callout)
                .padding(.horizontal, 15)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.vertical, 10)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .inset(by: 2)
                .stroke(Color.cardColor, lineWidth: 2)
        )
    }
}
