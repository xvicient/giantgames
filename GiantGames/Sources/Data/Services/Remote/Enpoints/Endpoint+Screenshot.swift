//
//  Endpoint+Screenshot.swift
//  GiantGames
//
//  Created by Xavier on 14/07/2020.
//  Copyright © 2020 GiantGames. All rights reserved.
//

extension Endpoint {
    static func screenshot(_ screenshotId: Int) -> Endpoint {
        Endpoint(path: "screenshots/\(screenshotId)/",
                 method: .get,
                 headers: nil,
                 queryParams: ["fields": "url,width,height"],
                 body: nil)
    }
}
