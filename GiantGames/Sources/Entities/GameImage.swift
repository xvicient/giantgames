//
//  GameImage.swift
//  GiantGames
//
//  Created by Xavier on 14/07/2020.
//  Copyright © 2020 GiantGames. All rights reserved.
//

import Foundation

struct GameImage {
    let id: Int
    let imageId: String
    let width: Int
    let height: Int

    /// based on igdb api images reference https://api-docs.igdb.com/?swift#images
    enum Size: String {
        case small = "cover_small"
        case medium = "cover_big"
        case large = "screenshot_med"

        func url(_ id: String) -> URL? {
            URL(string: "https://images.igdb.com/igdb/image/upload/t_\(rawValue)/\(id).jpg")
        }
    }

    func url(_ size: Size) -> URL? {
        size.url(imageId)
    }
}
