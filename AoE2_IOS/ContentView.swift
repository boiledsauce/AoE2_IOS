//
//  ContentView.swift
//  AoE2_IOS
//
//  Created by William Branth on 2022-06-24.
//

import SwiftUI
import AuthenticationServices
import BetterSafariView
import SwiftSoup
import Starscream

struct PlayerListItem: Identifiable {
    let id = UUID()
    let key: String
    let value: String
    var items: [PlayerListItem]?
}


var apiAOE = "https://www.ageofempires.com/stats/?profileId=198200&game=age2"

var authUrl = "https://steamcommunity.com/openid/login?openid.ns=http://specs.openid.net/auth/2.0&openid.claimed_id=http://specs.openid.net/auth/2.0/identifier_select&openid.identity=http://specs.openid.net/auth/2.0/identifier_select&openid.return_to=https://callbackios.willyeah.repl.co/steam/auth&openid.realm=https://callbackios.willyeah.repl.co&openid.mode=checkid_setup"


struct ContentView: View {
    @AppStorage("profile_id") var profile_id: String = ""
    @State private var showPlayers = false
    
    var body: some View {
        NavigationView {
            List {
                Section ("Search for a players AoE2.net Profile ID if your game is starting") {
                    TextField(
                          "aoe2.net player id",
                          text: $profile_id
                      )
                      .onSubmit {
                          self.showPlayers = true
                      }
                      .textInputAutocapitalization(.never)
                      .disableAutocorrection(true)
                      .border(.secondary)
                }
                .headerProminence(.increased)
                
                if showPlayers {
                    NavigationLink(destination: PlayersView(searchId: self.profile_id), isActive: $showPlayers) {
                        EmptyView()
                    }
                }
            }
            .listStyle(.inset)
            .navigationTitle("AoE2 Follow player")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

/*
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
 */
