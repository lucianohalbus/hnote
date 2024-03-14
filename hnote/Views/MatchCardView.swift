//Created by Halbus Development

import SwiftUI

struct MatchCardView: View {
    let matchDB: MatchDB
    
    var body: some View {
        NavigationLink(value: matchDB) {
            VStack {
                Text(matchDB.myDate, format: Date.FormatStyle(date: .numeric))
                    .foregroundStyle(Color.primary)
                    .font(.title2)
                
                HStack {
                    
                    VStack(alignment: .leading) {
                        Text(matchDB.playerOne)
                        Text(matchDB.playerTwo)
                        Text(matchDB.finalScoreOne.description)
                            .foregroundStyle(matchDB.finalScoreOne >= matchDB.finalScoreTwo ? Color.green : Color.red)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text(matchDB.playerThree)
                        Text(matchDB.playerFour)
                        Text(matchDB.finalScoreTwo.description)
                            .foregroundStyle(matchDB.finalScoreTwo >= matchDB.finalScoreOne ? Color.green : Color.red)
                    }
                }
                .foregroundStyle(Color.primary)
                .font(.title2)
                .padding(.horizontal, 10)
                .padding(.bottom, 20)
            }
            .padding(.top, 10)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .inset(by: 2)
                    .stroke(Color.cardColor, lineWidth: 2)
            )
        }

    }
}
