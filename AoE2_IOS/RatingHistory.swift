// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let ratingHistory = try? newJSONDecoder().decode(RatingHistory.self, from: jsonData)

import Foundation

// MARK: - RatingHistoryElement
struct RatingHistoryElement: Codable {
    let rating, numWINS, numLosses, streak: Int?
    let drops, timestamp: Int?

    enum CodingKeys: String, CodingKey {
        case rating
        case numWINS = "num_wins"
        case numLosses = "num_losses"
        case streak, drops, timestamp
    }
}

typealias RatingHistory = [RatingHistoryElement]
