//Created by Halbus Development

import SwiftUI

struct MatchResumeView: View {
   // var match: Match
    
    var body: some View {
        VStack {
            HStack {

                VStack (alignment: .leading) {
                    Text("Time 1")
                    Text("Player")
                    Text("Player")
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("Time 2")
                    Text("Player")
                    Text("Player")
                }

            }
            .padding(.horizontal, 30)
            
            Divider()
                .frame(height: 1)
                .background(Color.cardColor)
                .padding(.vertical, 10)
            
            ScrollView {
                ForEach((1...3), id: \.self) {_ in
                    Text(Date().formatted(date: .abbreviated, time: .shortened))
                        .font(.headline)
                    
                    HStack {
                        
                        Spacer()
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Text("--")
                            }
                            
                            HStack {
                                Text("--")
                            }
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .center) {
                            HStack {
                                Text("")
                                Text("Pontos da Rodada: ")
                                Text("")
                            }
                            
                            HStack {
                                Text("")
                                Text("Total Parcial: ")
                                Text("")
                            }
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing) {
                            HStack {
                                Text("--")
                            }
                            
                            HStack {
                                Text("--")
                            }
                        }
                        
                        Spacer()
 
                    }
                    .font(.headline)
                    .padding(.bottom, 10)
                }
            
                Spacer()
                
            }
        }
        .padding()
    }
}

#Preview {
    MatchResumeView(
        //match:
//        Match(
//            date: Date(),
//            playerOne: "Zico",
//            playerTwo: "Sócrates",
//            playerThree: "Junior",
//            playerFour: "Leandro",
//            scoreTeamOne: 2000,
//            scoreTeamTwo: 1000,
//            targetScore: 3000,
//            isMatchFinished: true
//        )
    )
}
