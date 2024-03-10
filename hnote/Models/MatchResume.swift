// Created by Halbus Development
// March 10th, 2024

import Foundation
import SwiftData

@Model
final class MatchResume {
    var date: Date
    var scoreTeamOne: Int
    var scoreTeamTwo: Int
    var match: Match?
    
    init(date: Date, scoreTeamOne: Int, scoreTeamTwo: Int, match: Match? = nil) {
        self.date = date
        self.scoreTeamOne = scoreTeamOne
        self.scoreTeamTwo = scoreTeamTwo
        self.match = match
    }
}
