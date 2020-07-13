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
        Game(id: 0, name: "Test", popularity: 0)
    }

    static func games(_ count: Int) -> [Game] {
        var games = [Game]()
        for index in 1...count {
            games.append(Game(id: index, name: "Test\(index)", popularity: 0))
        }
        return games
    }
}
