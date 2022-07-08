import Foundation

// MARK: - Match
struct Match: Codable {
    let profileID: Int
    let steamID, name, clan, country: String?
    var lastMatch: LastMatch

    enum CodingKeys: String, CodingKey {
        case profileID = "profile_id"
        case steamID = "steam_id"
        case name, clan, country
        case lastMatch = "last_match"
    }
}

// MARK: - LastMatch
struct LastMatch: Codable {
    let matchID: String?
    let lobbyID: String?
    let matchUUID, version, name: String?
    let numPlayers, numSlots: Int?
    let averageRating: Int?
    let cheats, fullTechTree: Bool?
    let endingAge: Int?
    let expansion: String?
    let gameType: Int?
    let hasCustomContent: Bool?
    let hasPassword, lockSpeed, lockTeams: Bool?
    let mapSize, mapType, pop: Int?
    let ranked: Bool?
    let leaderboardID, ratingType, resources: Int?
    let rms, scenario: String?
    let server: String?
    let sharedExploration: Bool?
    let speed, startingAge: Int?
    let teamTogether, teamPositions: Bool?
    let treatyLength: Int?
    let turbo: Bool?
    let victory, victoryTime, visibility, opened: Int?
    let started, finished: Int?
    var players: [Player]

    enum CodingKeys: String, CodingKey {
        case matchID = "match_id"
        case lobbyID = "lobby_id"
        case matchUUID = "match_uuid"
        case version, name
        case numPlayers = "num_players"
        case numSlots = "num_slots"
        case averageRating = "average_rating"
        case cheats
        case fullTechTree = "full_tech_tree"
        case endingAge = "ending_age"
        case expansion
        case gameType = "game_type"
        case hasCustomContent = "has_custom_content"
        case hasPassword = "has_password"
        case lockSpeed = "lock_speed"
        case lockTeams = "lock_teams"
        case mapSize = "map_size"
        case mapType = "map_type"
        case pop, ranked
        case leaderboardID = "leaderboard_id"
        case ratingType = "rating_type"
        case resources, rms, scenario, server
        case sharedExploration = "shared_exploration"
        case speed
        case startingAge = "starting_age"
        case teamTogether = "team_together"
        case teamPositions = "team_positions"
        case treatyLength = "treaty_length"
        case turbo, victory
        case victoryTime = "victory_time"
        case visibility, opened, started, finished, players
    }
}

// MARK: - Player
struct Player: Codable, Hashable, Equatable {
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.profileID == rhs.profileID
    }
    
    let profileID: Int?
    let steamID, name: String?
    let clan, country: String?
    let slot, slotType, rating: Int?
    let ratingChange, games, wins, streak: Int?
    let drops: Int?
    let color, team, civ, civAlpha: Int?
    let won: Bool?
    var ratingDetails: RatingDetails?

    func hash(into hasher: inout Hasher) {
        hasher.combine(profileID)
    }
    
    enum CodingKeys: String, CodingKey {
        case profileID = "profile_id"
        case steamID = "steam_id"
        case name, clan, country, slot
        case slotType = "slot_type"
        case rating
        case ratingDetails
        case ratingChange = "rating_change"
        case games, wins, streak, drops, color, team, civ
        case civAlpha = "civ_alpha"
        case won
    }
}

// MARK: - Encode/decode helpers

class JSONNull: NSObject, Codable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    /*
    public var hashValue: Int {
        return 0
    }

    public init() {}
*/
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
