//
//  Image.swift
//  GiantGames
//
//  Created by Xavier on 14/07/2020.
//  Copyright © 2020 GiantGames. All rights reserved.
//

import Foundation

struct Image {
    let id: Int
    let imageId: Int
    let width: Int
    let height: Int

    func url(_ size: ImageSize) -> URL? {
        size.url(imageId)
    }
}
