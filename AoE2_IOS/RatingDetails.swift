// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let ratingDetails = try? newJSONDecoder().decode(RatingDetails.self, from: jsonData)

import Foundation

// MARK: - RatingDetails
struct RatingDetails: Codable {
    let data: [LeaderBoardDetails]
    let id, message: String?
}

// MARK: - Datum
struct LeaderBoardDetails: Codable {
    let rankTypeID: Int?
    let leaderboardName: String?
    let rank, rating, previousRating, highestRating: Int?
    let streak, lowestStreak, highestStreak, games: Int?
    let wins, losses, drops, lastMatch: Int?

    enum CodingKeys: String, CodingKey {
        case rankTypeID = "rankTypeId"
        case leaderboardName, rank, rating, previousRating, highestRating, streak, lowestStreak, highestStreak, games, wins, losses, drops, lastMatch
    }
}
