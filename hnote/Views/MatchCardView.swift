//Created by Halbus Development

import SwiftUI

struct MatchCardView: View {
    let match: Match
    
    var body: some View {
        VStack {
            Text(Date(), format: Date.FormatStyle(date: .numeric))
                .foregroundStyle(Color.primary)
                .font(.title2)
            
            HStack {
                
                VStack(alignment: .leading) {
                    Text(match.playerOne)
                    Text(match.playerTwo)
                    Text(match.scoreTeamOne.description)
                        .foregroundStyle(match.scoreTeamOne >= match.scoreTeamTwo ? Color.green : Color.red)
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text(match.playerThree)
                    Text(match.playerFour)
                    Text(match.scoreTeamTwo.description)
                        .foregroundStyle(match.scoreTeamTwo >= match.scoreTeamOne ? Color.green : Color.red)
                }
            }
            .foregroundStyle(Color.primary)
            .font(.title2)
            .padding(.horizontal, 10)
            .padding(.bottom, 20)
        }
        .padding(.top, 20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .inset(by: 3)
                .stroke(Color.cardColor, lineWidth: 3)
        )
    }
}
