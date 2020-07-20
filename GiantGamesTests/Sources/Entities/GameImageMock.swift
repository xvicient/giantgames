//
//  GameImageMock.swift
//  GiantGamesTests
//
//  Created by Xavier on 15/07/2020.
//  Copyright © 2020 GiantGames. All rights reserved.
//

@testable import GiantGames

struct GameImageMock {
    static var gameImage: GameImage {
        GameImage(id: 0, imageId: "1", width: 0, height: 0)
    }

    static func gameImages(_ count: Int) -> [GameImage] {
        var gameImages = [GameImage]()
        for index in 1...count {
            gameImages.append(GameImage(id: index, imageId: "\(index)", width: 0, height: 0))
        }
        return gameImages
    }
}
