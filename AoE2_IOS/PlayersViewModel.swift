//
//  PlayersViewModel.swift
//  AoE2_IOS
//
//  Created by William Branth on 2022-07-08.
//

import Foundation

class PlayersViewModel : ObservableObject {
    @Published var _profileId: String
    @Published var items: [PlayerListItem]
    private var aoeSocket: AoESocket
    //private var cancelable: AnyCancellable?

    init (searchId: String) {
        self._profileId = searchId
        self.aoeSocket = AoESocket()
        self.items = []
        self.fetch_players_with_id()
    }
    
    public func refreshMatch() {
        self.fetch_players_with_id()
    }
    
    private func fetch_players_with_id() {
        guard let url = URL(string: "https://aoe2.net/api/player/lastmatch?game=aoe2de&profile_id=\(self._profileId)") else {
                return
            }
        /*cancelable = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.main)
            .map({
                print($0.data)
                return $0.data
            })
            .decode(type: Match.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (suscriberCompletion) in
                   switch suscriberCompletion {
                   case .finished:
                                // do something that you want to do when finished
                     break
                   case .failure(let error):
                     print(error.localizedDescription)
                   }
                 }, receiveValue: { [weak self] (Test) in
                     print("Test", Test)
                   //self?.warehouseOrders.append(warehouseOrder)
                 })
         */
        var seconds = 0
        var found_match = false
        Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { timer in
            seconds += 1
            if seconds == 5 || found_match {
                timer.invalidate()
            }
        
            let task = URLSession.shared.dataTask(with: url) { [self] data, response, error in
                if let data = data {
                    do {
                        self.items.removeAll()
                        var match = try JSONDecoder().decode(Match.self, from: data)
                            
                        found_match = true
                        self.aoeSocket.dataBuffer = Array<RatingDetails>()
                        match.lastMatch.players.forEach { Player in
                            self.aoeSocket.sendLeaderBoardStatsRequest(id: String(Player.profileID!))
                        }
                        
                        let found_participants = match.lastMatch.players.count
                        while (found_participants != aoeSocket.self.dataBuffer.count){
                            print(found_participants, " ", self.aoeSocket.self.dataBuffer.count)
                        }
                        
                        self.aoeSocket.self.dataBuffer.forEach { RatingDetails in
                            let index = match.lastMatch.players.firstIndex(where: {$0.profileID == Int(RatingDetails.id!)})!
                            match.lastMatch.players[index].ratingDetails = RatingDetails
                            let player =  match.lastMatch.players[index]

                            var playerListItem = PlayerListItem(key: "Name", value: match.lastMatch.players[index].name!, items: [])
                            playerListItem.items?.append(PlayerListItem(key: "Rating", value: String(player.rating ?? -1)))
                            playerListItem.items?.append(PlayerListItem(key: "Highest 1v1 rating", value: String((player.ratingDetails?.data[0].highestRating ?? -1)!)))
                            playerListItem.items?.append(PlayerListItem(key: "Win / Loss", value: String("\(player.ratingDetails?.data[0].wins ?? -1) / \(player.ratingDetails?.data[0].losses ?? -1)")))
                            playerListItem.items?.append(PlayerListItem(key: "Current Streak", value: String(player.streak ?? -1)))
                            playerListItem.items?.append(PlayerListItem(key: "Highest streak", value: String((player.ratingDetails?.data[0].highestStreak ?? -1)!)))
                            playerListItem.items?.append(PlayerListItem(key: "Lowest streak", value: String((player.ratingDetails?.data[0].lowestStreak ?? -1)!)))
                            playerListItem.items?.append(PlayerListItem(key: "Country", value: String(player.country ?? "Unknown")))

                            self.items.append(playerListItem)
                        }
                        timer.invalidate()

                    } catch let error {
                        print("Failed", error)
                    }
                }
            }
            task.resume()
        }
    }
}

    /*
extension PlayersView {
    
}
*/
