//
//  AoESocket.swift
//  AoE2_IOS
//
//  Created by William Branth on 2022-07-03.
//

import Foundation
import Starscream


class AoESocket {
    private var request: URLRequest
    private let socket: WebSocket
    private var isConnected = false
    public var dataBuffer: Array<RatingDetails> = []
    
    init() {
        self.request = URLRequest(url: URL(string: "wss://aoe2.net/ws")!)
        self.request.timeoutInterval = 10
        self.socket = WebSocket(request: request)
        socket.connect()
        self.listenToEvents()
    }
    
    private func listenToEvents(){
        socket.onEvent = { event in
            switch event {
                // handle events just like above...
            case .connected(let headers):
                self.isConnected = true
                    print("websocket is connected: \(headers)")
                case .disconnected(let reason, let code):
                self.isConnected = false
                    print("websocket is disconnected: \(reason) with code: \(code)")
                case .text(let string):
                guard let ratingDetails = try? JSONDecoder().decode(RatingDetails.self, from: string.data(using: String.Encoding.utf8)!) else {
                    return
                }
                    self.dataBuffer.append(ratingDetails)
                    //print(ratingDetails)
                    //print("Received text: \(string)")
                case .binary(let data):
                    print("Received data: \(data.count)")
                case .ping(_):
                    print("PING")
                    break
                case .pong(_):
                    print("PONG")
                    break
                case .viabilityChanged(_):
                    break
                case .reconnectSuggested(_):
                    break
                case .cancelled:
                self.isConnected = false
                case .error(let error):
                    self.isConnected = false
                }
        }
    }
    
    private func getLeaderBoardJSONMessage(id: String) -> String {
        let encoder = JSONEncoder()
        let msg = ["message": "playerleaderboardstats", "id": id]
        let jsonData = try! encoder.encode(msg)
        let jsonString = String(data: jsonData, encoding: .utf8)

        return jsonString!
    }
    
    public func getDataBufferSize() -> Int {
        return self.dataBuffer.count
    }
    
    public func sendLeaderBoardStatsRequest(id: String) {
        let msg = self.getLeaderBoardJSONMessage(id: id)
        socket.write(string: msg)
    }
}
