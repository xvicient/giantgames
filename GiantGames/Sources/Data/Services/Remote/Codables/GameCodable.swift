//
//  GameCodable.swift
//  GiantGames
//
//  Created by Xavier on 12/07/2020.
//  Copyright © 2020 GiantGames. All rights reserved.
//

struct GameCodable: Codable, Domain {
    let id: Int
    let name: String
    let cover: Int?
    let storyline: String?
    let screenshots: [Int]?
    let videos: [Int]?
    let rating: Double?
    let summary: String?

    func toDomain() -> Game {
        Game(id: id,
             name: name,
             cover: cover,
             storyline: storyline ?? summary.orEmpty,
             screenshots: screenshots,
             videos: videos,
             rating: rating == nil ? "N/A" : String(rating!.rounded(1)),
             summary: summary.orEmpty)
    }
}
