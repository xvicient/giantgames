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
    let cover: Int

    func toDomain() -> Game {
        Game(id: id, name: name, cover: cover)
    }
}
