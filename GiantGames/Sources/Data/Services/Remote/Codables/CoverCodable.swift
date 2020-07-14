//
//  CoverCodable.swift
//  GiantGames
//
//  Created by Xavier on 14/07/2020.
//  Copyright © 2020 GiantGames. All rights reserved.
//

import Foundation

struct CoverCodable: Codable, Domain {
    let id: Int
    let url: String
    let width: Int
    let height: Int

    func toDomain() -> Cover {
        Cover(id: id, url: fullURL, width: width, height: height)
    }
}

private extension CoverCodable {
    var fullURL: URL? {
        guard var url = URL(string: self.url) else { return nil }
        url.setScheme("https")
        return url
    }
}
