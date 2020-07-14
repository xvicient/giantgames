//
//  GameImageCodable.swift
//  GiantGames
//
//  Created by Xavier on 14/07/2020.
//  Copyright © 2020 GiantGames. All rights reserved.
//

import Foundation

struct GameImageCodable: Codable, Domain {
    let id: Int
    let imageId: String
    let width: Int
    let height: Int

    func toDomain() -> GameImage {
        GameImage(id: id, imageId: imageId, width: width, height: height)
    }
}
