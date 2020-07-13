//
//  Endpoint+Games.swift
//  GiantGames
//
//  Created by Xavier on 12/07/2020.
//  Copyright © 2020 GiantGames. All rights reserved.
//

extension Endpoint {
    static func games() -> Endpoint {
        Endpoint(path: "games/",
                 method: .get,
                 headers: nil,
                 queryParams: ["fields": "name,popularity",
                               "limit": "20",
                               "offset": "0"],
                 body: nil)
    }
}
