//
//  GameMock.swift
//  GiantGamesTests
//
//  Created by Xavier on 13/07/2020.
//  Copyright © 2020 GiantGames. All rights reserved.
//

@testable import GiantGames

struct GameMock {
    static var game: Game {
        Game(id: 0, name: "Test", cover: 0, storyline: "Test", screenshots: [1, 2, 3, 4, 5], videos: [1, 2, 3, 4, 5])
    }

    static func games(_ count: Int) -> [Game] {
        var games = [Game]()
        for index in 1...count {
            games.append(Game(id: index,
                              name: "Name\(index)",
                              cover: 0,
                              storyline: "Storyline\(index)",
                              screenshots: [1, 2, 3, 4, 5],
                              videos: [1, 2, 3, 4, 5]))
        }
        return games
    }
}
