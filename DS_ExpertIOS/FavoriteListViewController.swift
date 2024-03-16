//
//  FavoriteViewCOntroller.swift
//  DS_FundamentalIOS
//
//  Created by Admin on 23/02/24.
//

import Foundation
import SwiftUI
import UIKit

class FavoriteListViewController: UIViewController {
    
    let favoriteView = FavoriteListView(games: [GameModel(
        id: 0,
        title: "loh lah",
        rating: 0.0,
        releaseDate: "2024-02-22",
        posterPath: "https://images.unsplash.com/photo-1608229191360-7064b0afa639?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=100&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTcwODYxNzg4MQ&ixlib=rb-4.0.3&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=100"
    )])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(
            UIHostingController(rootView: favoriteView).view
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        FavoriteGameCDProvider.localDb.getAll { games in
            DispatchQueue.main.async {
                self.favoriteView.games = games
            }
        }
    }
}
