//
//  Endpoint+Cover.swift
//  GiantGames
//
//  Created by Xavier on 14/07/2020.
//  Copyright © 2020 GiantGames. All rights reserved.
//

extension Endpoint {
    static func cover(_ coverId: Int) -> Endpoint {
        Endpoint(path: "covers/\(coverId)/",
                 method: .get,
                 headers: nil,
                 queryParams: ["fields": "url,width,height"],
                 body: nil)
    }
}
