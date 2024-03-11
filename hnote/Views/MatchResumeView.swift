//Created by Halbus Development

import SwiftUI

struct MatchResumeView: View {
    var match: Match
    @State private var presentAddNewMatchTurnView: Bool = false
    
    var body: some View {
        VStack {
            
            matchResumeViewHeader
            
            ScrollView {
                
                matchResumeViewList
                
                if !match.isMatchFinished {
                
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
                        
                        AddNewMatchTurnView(match: match)
                            .presentationDetents([.fraction(0.7)])
                            .interactiveDismissDisabled()
                    })
                
                } else {
                    
                    Text("Partida Encerrada!")
                        .font(.title)
                        .foregroundStyle(Color.cardColor)
                        .frame(maxWidth: .infinity)
                        .padding(20)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .inset(by: 2)
                                .stroke(Color.cardColor, lineWidth: 2)
                        )
                }
            }
        }
        .padding()
        
    }
    
    private var matchResumeViewHeader: some View {
        VStack {
            Text("Pontuação da Rodada")
                .font(.title)
                .foregroundColor(.cardColor)
                .bold()
            
            HStack {

                VStack (alignment: .leading) {
                    Text(match.playerOne)
                    Text(match.playerTwo)
                    Text(match.scoreTeamOne.description)
                        .foregroundStyle(Color.yellow)
                        .bold()
                }
                .foregroundStyle(Color.white)
                
                Spacer()
                
                Divider()
                    .frame(width: 1, height: 50)
                    .background(Color.white)
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text(match.playerThree)
                    Text(match.playerFour)
                    Text(match.scoreTeamTwo.description)
                        .foregroundStyle(Color.yellow)
                        .bold()
                }
                .foregroundStyle(Color.white)
            }
            .font(.title)
            .foregroundColor(.white)
            .padding(15)
            .background(Color.cardColor)
            .cornerRadius(20)
        }
    }
    
    private var matchResumeViewList: some View {
        VStack(spacing: 5) {
            ForEach(match.matchResume) { matchResume in
    
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
