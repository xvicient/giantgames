//
//  String+Localization.swift
//  GiantGames
//
//  Created by Xavier on 12/07/2020.
//  Copyright © 2020 GiantGames. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
