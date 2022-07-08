//
//  PlayersView.swift
//  AoE2_IOS
//
//  Created by William Branth on 2022-07-08.
//

import SwiftUI

struct PlayersView: View {
    let _searchId: String
    @ObservedObject private var _playersViewModel: PlayersViewModel
    
    init(searchId: String) {
        self._searchId = searchId
        _playersViewModel = PlayersViewModel(searchId: searchId)
    }

    
    var body: some View {
        
            List(self._playersViewModel.items, children: \.items) { row in
                HStack {
                    if (row.key != "Name") {
                        Text(row.key)
                            .bold()
                        Spacer()
                    } else {
                        let listIndex = self._playersViewModel.items.firstIndex(where: { $0.id == row.id})!+1
                        Image(systemName: "\(listIndex).circle")
                    }
                    Text(row.value)
                }
            }
            .frame(maxWidth: .infinity, minHeight: 400)
    }
}

/*
struct PlayersView_Previews: PreviewProvider {
    static var previews: some View {
        PlayersView(searchId)
    }
}*/
