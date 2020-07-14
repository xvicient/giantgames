//
//  GameImageService.swift
//  GiantGames
//
//  Created by Xavier on 14/07/2020.
//  Copyright © 2020 GiantGames. All rights reserved.
//

// MARK: - GameImageServiceApi

// sourcery: AutoMockable
protocol GameImageServiceApi {
    func cover(_ id: Int, completion: @escaping (Result<[GameImage], APIError>) -> Void)
    func screenshot(_ id: Int, completion: @escaping (Result<[GameImage], APIError>) -> Void)
}

// MARK: - GameImageService

struct GameImageService {
    private let apiClient: APIClientApi

    init(apiClient: APIClientApi) {
        self.apiClient = apiClient
    }
}

extension GameImageService: GameImageServiceApi {
    func cover(_ id: Int, completion: @escaping (Result<[GameImage], APIError>) -> Void) {
        apiClient.request(.cover(id)) { (result: Result<[GameImageCodable], APIError>) in
            completion(result.map { $0.map { $0.toDomain() }})
        }
    }

    func screenshot(_ id: Int, completion: @escaping (Result<[GameImage], APIError>) -> Void) {
        apiClient.request(.screenshot(id)) { (result: Result<[GameImageCodable], APIError>) in
            completion(result.map { $0.map { $0.toDomain() }})
        }
    }
}
