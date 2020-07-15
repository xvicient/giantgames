//
//  Endpoint+GameVideos.swift
//  GiantGames
//
//  Created by Xavier on 15/07/2020.
//  Copyright © 2020 GiantGames. All rights reserved.
//

extension Endpoint {
    static func gameVideos(_ id: Int) -> Endpoint {
        Endpoint(path: "game_videos/\(id)/",
                 method: .get,
                 headers: nil,
                 queryParams: ["fields": "video_id,name"],
                 body: nil)
    }
}
