//Created by Halbus Development

import SwiftUI

struct MatchResumeView: View {
    var match: Match
    @State private var presentMatchDetailView: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                matchResumeViewHeader
                ScrollView {
                    VStack {
                        ForEach((1...3), id: \.self) {_ in
                            matchResumeViewList
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.top, 30)
                    .background()
                    .cornerRadius(20)
                }
                
                Button {
                    presentMatchDetailView.toggle()
                } label: {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(Color.white, Color.white)
                        .bold()
                }
                .sheet(isPresented: $presentMatchDetailView, content: {
                    MatchDetailView(match: match)
                })
                
                Spacer()
            }
            .padding()
        }
        .background(Color.cardColor, ignoresSafeAreaEdges: .all)
    }
    
    private var matchResumeViewHeader: some View {
        VStack {
            Text("3000")
                .font(.title)
                .foregroundColor(.white)
                .bold()
            
            HStack {

                VStack (alignment: .leading) {
                    Text("Player")
                    Text("Player")
                }
                
                Spacer()
                
                Divider()
                    .frame(width: 1, height: 50)
                    .background(Color.white)
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("Player")
                    Text("Player")
                }
            }
            .font(.title)
            .foregroundColor(.white)
            .padding(15)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .inset(by: 2)
                    .stroke(Color.white, lineWidth: 2)
            )
        }
    }
    
    private var matchResumeViewList: some View {
        VStack {
            Text(Date().formatted(date: .abbreviated, time: .shortened))
               
            HStack {
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("--")
                    Text("--")
                }
                
                Spacer()
                
                VStack(alignment: .center) {
                    Text("Pontos da Rodada")
                    Text("Total Parcial")
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("--")
                    Text("--")
                }
                
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
