//Created by Halbus Development

import SwiftUI

struct MatchResumeView: View {
    var match: Match
    @State private var presentMatchDetailView: Bool = false
    
    var body: some View {
        VStack {
            
            matchResumeViewHeader
            
            ScrollView {
                VStack {
                    ForEach(match.matchResume) { matchResume in
                        
                        VStack {
                            Text(Date().formatted(date: .abbreviated, time: .shortened))
                               
                            HStack {
                                Spacer()
                                Text(matchResume.partialScoreTeamOne.description)
                                
                                Spacer()
                                Text("Pontos da Rodada")
                                
                                
                                Spacer()
                                Text(matchResume.partialScoreTeamTwo.description)
                                
                                Spacer()
                            }
                            
                            Divider()
                                .frame(width: 100, height: 1)
                                .background(Color.cardColor)
                                .padding(.bottom, 10)
                        }
                        .font(.callout)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.top, 10)
                .background()
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .inset(by: 2)
                        .stroke(Color.cardColor, lineWidth: 2)
                )
                
                
                
                Button {
                    
                    presentMatchDetailView.toggle()
                    
                } label: {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 30)
                        .foregroundStyle(Color.white, Color.white)
                        .bold()
                }
                .buttonStyle(.borderedProminent)
                .tint(Color.cardColor)
                
            }
            .sheet(isPresented: $presentMatchDetailView, content: {
                
                MatchDetailView(match: match)
                    .presentationDetents([.fraction(0.7)])
                    .interactiveDismissDisabled()
            })
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
                        .foregroundStyle(Color.cardColor)
                }
                
                Spacer()
                
                Divider()
                    .frame(width: 1, height: 50)
                    .background(Color.white)
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text(match.playerThree)
                    Text(match.playerFour)
                    Text(match.scoreTeamTwo.description)
                        .foregroundStyle(Color.cardColor)
                }
            }
            .font(.title)
            .foregroundColor(.black)
            .padding(15)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .inset(by: 2)
                    .stroke(Color.cardColor, lineWidth: 2)
            )
        }
    }
    
//    private var matchResumeViewList: some View {
//
//    }
}
