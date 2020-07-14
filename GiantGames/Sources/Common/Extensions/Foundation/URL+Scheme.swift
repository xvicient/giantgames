//
//  URL+Scheme.swift
//  GiantGames
//
//  Created by Xavier on 14/07/2020.
//  Copyright © 2020 GiantGames. All rights reserved.
//

import Foundation

extension URL {
    mutating func setScheme(_ scheme: String) {
        guard let components = NSURLComponents.init(url: self, resolvingAgainstBaseURL: true) else { return }
        components.scheme = scheme
        self = components.url!
    }
}
