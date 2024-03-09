//Created by Halbus Development

import Foundation
import SwiftData

@Model
final class Match: Identifiable {
    var date: Date
    var playerOne: String
    var playerTwo: String
    var playerThree: String
    var playerFour: String
    var scoreTeamOne: Int
    var scoreTeamTwo: Int
    var targetScore: Int

    init(date: Date, playerOne: String, playerTwo: String, playerThree: String, playerFour: String, scoreTeamOne: Int, scoreTeamTwo: Int, targetScore: Int) {
        self.date = date
        self.playerOne = playerOne
        self.playerTwo = playerTwo
        self.playerThree = playerThree
        self.playerFour = playerFour
        self.scoreTeamOne = scoreTeamOne
        self.scoreTeamTwo = scoreTeamTwo
        self.targetScore = targetScore
    }
}
