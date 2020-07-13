//
//  DomainProtocols.swift
//  GiantGames
//
//  Created by Xavier on 12/07/2020.
//  Copyright © 2020 GiantGames. All rights reserved.
//

protocol Domain {
    associatedtype T
    func toDomain() -> T
}
