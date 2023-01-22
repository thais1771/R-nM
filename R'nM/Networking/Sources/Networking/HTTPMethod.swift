//
//  HTTPMethod.swift
//  
//
//  Created by Thais Rodríguez on 19/1/23.
//

import Foundation

typealias Body = Data
enum HTTPMethod<Body> {
    case GET
    case POST(Body? = nil)

    var rawValue: String {
        switch self {
        case .GET:
            return "GET"
        case .POST:
            return "POST"
        }
    }
}
