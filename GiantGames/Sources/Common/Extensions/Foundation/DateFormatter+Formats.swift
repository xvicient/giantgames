//
//  DateFormatter+Formats.swift
//  GiantGames
//
//  Created by Xavier on 20/07/2020.
//  Copyright © 2020 GiantGames. All rights reserved.
//

import Foundation

extension DateFormatter {
    static let ddMMyyyy: DateFormatter = {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("yyyy-MM-dd")
        return formatter
    }()
}
