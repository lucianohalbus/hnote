// Created by Halbus Development
// March 10th, 2024

import Foundation
import SwiftData

@Model
final class MatchResume {
    var date: Date
    var partialScoreTeamOne: Int
    var partialScoreTeamTwo: Int
    var match: Match?
    
    init(date: Date, partialScoreTeamOne: Int, partialScoreTeamTwo: Int, match: Match? = nil) {
        self.date = date
        self.partialScoreTeamOne = partialScoreTeamOne
        self.partialScoreTeamTwo = partialScoreTeamTwo
        self.match = match
    }
}
