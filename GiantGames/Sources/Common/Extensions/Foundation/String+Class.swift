//
//  String+Class.swift
//  GiantGames
//
//  Created by Xavier on 12/07/2020.
//  Copyright © 2020 GiantGames. All rights reserved.
//

import UIKit

extension String {
    static func stringFromClass(_ objectClass: AnyClass) -> String {
        return NSStringFromClass(objectClass).components(separatedBy: ".").last!
    }
}
