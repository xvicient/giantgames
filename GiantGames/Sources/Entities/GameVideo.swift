//
//  GameVideo.swift
//  GiantGames
//
//  Created by Xavier on 15/07/2020.
//  Copyright © 2020 GiantGames. All rights reserved.
//

import Foundation

struct GameVideo {
    let id: String
    let name: String

    enum URLType {
        case embed
        case fullscreen

        func url(_ id: String) -> URL? {
            switch self {
            case .embed:
                return URL(string: "https://youtube.com/embed/\(id)")
            case .fullscreen:
                return URL(string: "https://youtu.be/\(id)")
            }
        }
    }

    /// based on igdb api game videos reference
    func url(_ type: URLType) -> URL? {
        type.url(id)
    }
}
