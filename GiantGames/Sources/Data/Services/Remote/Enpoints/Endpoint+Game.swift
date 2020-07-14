//
//  Endpoint+Game.swift
//  GiantGames
//
//  Created by Xavier on 12/07/2020.
//  Copyright © 2020 GiantGames. All rights reserved.
//

extension Endpoint {
    static func topGames(offset: String) -> Endpoint {
        Endpoint(path: "games/",
                 method: .get,
                 headers: nil,
                 queryParams: ["fields": "name,cover,storyline,screenshots",
                               "order": "popularity:desc",
                               "limit": "20",
                               "offset": offset],
                 body: nil)
    }
}