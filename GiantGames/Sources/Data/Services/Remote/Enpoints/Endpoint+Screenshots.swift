//
//  Endpoint+Screenshots.swift
//  GiantGames
//
//  Created by Xavier on 14/07/2020.
//  Copyright © 2020 GiantGames. All rights reserved.
//

extension Endpoint {
    static func screenshots(_ id: Int) -> Endpoint {
        Endpoint(path: "screenshots/\(id)/",
                 method: .get,
                 headers: nil,
                 queryParams: ["fields": "image_id,width,height"],
                 body: nil)
    }
}
