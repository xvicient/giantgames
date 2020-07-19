//
//  GameVideoMock.swift
//  GiantGamesTests
//
//  Created by Xavier on 19/07/2020.
//  Copyright © 2020 GiantGames. All rights reserved.
//

@testable import GiantGames

struct GameVideoMock {
    static var gameVideo: GameVideo {
        GameVideo(id: "0", name: "GameVideo")
    }

    static func gameVideos(_ count: Int) -> [GameVideo] {
        var gameVideos = [GameVideo]()
        for index in 1...count {
            gameVideos.append(GameVideo(id: "\(index)", name: "GameVideo\(index)"))
        }
        return gameVideos
    }
}
