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

    enum ImageSize: String {
        case small = "cover_small"
        case medium = "cover_big"
        case large = "screenshot_med"

        func url(_ id: String) -> URL? {
            URL(string: String(format: "https://images.igdb.com/igdb/image/upload/t_%@/%@.jpg", rawValue, id))
        }
    }

    func url(_ size: ImageSize) -> URL? {
        size.url(imageId)
    }
}
