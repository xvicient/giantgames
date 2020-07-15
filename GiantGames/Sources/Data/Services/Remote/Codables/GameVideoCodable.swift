//
//  GameVideoCodable.swift
//  GiantGames
//
//  Created by Xavier on 15/07/2020.
//  Copyright © 2020 GiantGames. All rights reserved.
//

struct GameVideoCodable: Codable, Domain {
    let videoId: String
    let name: String

    func toDomain() -> GameVideo {
        GameVideo(id: videoId, name: name)
    }
}
