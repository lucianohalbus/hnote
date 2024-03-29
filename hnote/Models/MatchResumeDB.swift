// Created by Halbus Development
// March 10th, 2024

import Foundation
import SwiftData

@Model
final class MatchResumeDB {
    var date: Date
    var partialScoreTeamOne: Int
    var partialScoreTeamTwo: Int
    var matchDB: MatchDB?
    
    init(date: Date, partialScoreTeamOne: Int, partialScoreTeamTwo: Int, match: MatchDB? = nil) {
        self.date = date
        self.partialScoreTeamOne = partialScoreTeamOne
        self.partialScoreTeamTwo = partialScoreTeamTwo
        self.matchDB = matchDB
    }
}
