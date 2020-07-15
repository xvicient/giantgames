//
//  GameVideo.swift
//  GiantGames
//
//  Created by Xavier on 15/07/2020.
//  Copyright © 2020 GiantGames. All rights reserved.
//

import Foundation

struct GameVideo {
    let id: String
    let name: String

    /// based on igdb api game videos reference
    var url: URL? {
        URL(string: "https://youtu.be/\(id)")
    }
}
