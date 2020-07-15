//
//  GameVideoService.swift
//  GiantGames
//
//  Created by Xavier on 15/07/2020.
//  Copyright © 2020 GiantGames. All rights reserved.
//

// MARK: - GameVideoServiceApi

// sourcery: AutoMockable
protocol GameVideoServiceApi {
    func videos(_ id: Int, completion: @escaping (Result<[GameVideo], APIError>) -> Void)
}

// MARK: - GameVideoService

struct GameVideoService {
    private let apiClient: APIClientApi

    init(apiClient: APIClientApi) {
        self.apiClient = apiClient
    }
}

extension GameVideoService: GameVideoServiceApi {
    func videos(_ id: Int, completion: @escaping (Result<[GameVideo], APIError>) -> Void) {
        apiClient.request(.gameVideos(id)) { (result: Result<[GameVideoCodable], APIError>) in
            completion(result.map { $0.map { $0.toDomain() }})
        }
    }
}
