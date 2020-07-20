//
//  Game.swift
//  GiantGames
//
//  Created by Xavier on 12/07/2020.
//  Copyright © 2020 GiantGames. All rights reserved.
//

import Foundation

struct Game: Equatable {
    let id: Int
    let name: String
    let cover: Int?
    let storyline: String
    let screenshots: [Int]?
    let videos: [Int]?
    let rating: String
    let summary: String
    let releaseDate: Date
}
