//
//  Endpoint.swift
//  GiantGames
//
//  Created by Xavier on 12/07/2020.
//  Copyright © 2020 GiantGames. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    case get, post, put, patch, delete
}

public struct Body {
    public typealias Output = (data: Data, contentType: String)

    let generator: () throws -> (Output)

    public init(generator: @escaping () throws -> (Output)) {
        self.generator = generator
    }
}

public extension Body {
    static func json(params: [String: Any?]) -> Self {
        Body {
            let data = try JSONSerialization.data(withJSONObject: params)
            return (data, "application/json")
        }
    }

    static func formEncoded(params: [String: Any?]) -> Self {
        Body {
            let paramsString = params.compactMap {
                guard let value = $0.value else { return nil }
                return "\($0.key)=\(value)"
            }.joined(separator: "&")

            guard let data = paramsString.data(using: .utf8) else {
                throw APIError.invalidInput
            }

            return (data, "application/x-www-form-urlencoded; charset=utf-8")
        }
    }
}

public struct Endpoint {
    public let path: String
    public let method: HTTPMethod
    public let headers: [String: String]?
    public let queryParams: [String: String]?
    public let body: Body?

    public init(path: String, method: HTTPMethod, headers: [String: String]?, queryParams: [String: String]?, body: Body?) {
        self.path = path
        self.method = method
        self.headers = headers
        self.queryParams = queryParams
        self.body = body
    }

    func urlRequest(baseURL: String) throws -> URLRequest {
        guard let url = completeURL(baseURL: baseURL) else {
            throw APIError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue.uppercased()
        request.allHTTPHeaderFields = headers
        if let body = try body?.generator() {
            request.httpBody = body.data
            request.setValue(body.contentType, forHTTPHeaderField: "Content-Type")
        }
        return request
    }

    private func completeURL(baseURL: String) -> URL? {
        var urlComponents = URLComponents(string: baseURL + path)
        if let queryParams = queryParams {
            let queryItems = queryParams.reduce(into: [], { result, keyValue in
                result.append(URLQueryItem(name: keyValue.key, value: keyValue.value))
            })
            if urlComponents?.queryItems != nil {
                urlComponents?.queryItems?.append(contentsOf: queryItems)
            } else {
                urlComponents?.queryItems = queryItems
            }
        }
        return urlComponents?.url
    }
}
