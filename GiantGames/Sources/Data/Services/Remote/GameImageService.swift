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
    func covers(_ id: Int, completion: @escaping (Result<[GameImage], APIError>) -> Void)
    func screenshots(_ id: Int, completion: @escaping (Result<[GameImage], APIError>) -> Void)
}

// MARK: - GameImageService

struct GameImageService {
    private let apiClient: APIClientApi

    init(apiClient: APIClientApi) {
        self.apiClient = apiClient
    }
}

extension GameImageService: GameImageServiceApi {
    func covers(_ id: Int, completion: @escaping (Result<[GameImage], APIError>) -> Void) {
        apiClient.request(.covers(id)) { (result: Result<[GameImageCodable], APIError>) in
            completion(result.map { $0.map { $0.toDomain() }})
        }
    }

    func screenshots(_ id: Int, completion: @escaping (Result<[GameImage], APIError>) -> Void) {
        apiClient.request(.screenshots(id)) { (result: Result<[GameImageCodable], APIError>) in
            completion(result.map { $0.map { $0.toDomain() }})
        }
    }
}
