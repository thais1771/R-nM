//
//  Endpoint.swift
//  
//
//  Created by Thais Rodríguez on 19/1/23.
//

import Foundation

protocol Endpoint {
    var contentType: String { get }
    var path: String { get }
    var method: HTTPMethod<Body> { get }
    var params: [String: String]? { get }
    var cachePolicy: URLRequest.CachePolicy { get }
}

extension Endpoint {
    var contentType: String {
        "application/json"
    }

    var cachePolicy: URLRequest.CachePolicy {
        .returnCacheDataElseLoad
    }

    var urlRequest: URLRequest? {
        var request = URLRequest(url: urlComponents.url!)

        switch method {
        case .GET:
            break

        case let .POST(body):
            request.httpBody = body
        }

        request.httpMethod = method.rawValue

        let headers = [
            "Content-Type": contentType,
        ]

        headers.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }

        request.cachePolicy = cachePolicy

        return request
    }

    private var urlComponents: URLComponents {
        var urlComponents = URLComponents()

        urlComponents.scheme = "https"
        urlComponents.host = "rickandmortyapi.com"
        urlComponents.path = ["/api", path].joined(separator: "/")

        if let params {
            urlComponents.queryItems = params.compactMap {
                URLQueryItem(name: $0.key, value: $0.value)
            }
        }

        return urlComponents
    }
}
