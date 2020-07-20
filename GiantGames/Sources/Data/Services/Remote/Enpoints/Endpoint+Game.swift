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
                 queryParams: ["fields": "name,cover,storyline,screenshots,videos,rating,summary,first_release_date",
                               "order": "rating:desc",
                               "filter[rating][gte]": "0",
                               "limit": "10",
                               "offset": offset],
                 body: nil)
    }
}
