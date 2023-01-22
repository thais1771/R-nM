//
//  APIError.swift
//  
//
//  Created by Thais Rodríguez on 19/1/23.
//

import Foundation

public enum APIError: Error, LocalizedError, Equatable {
    case decode
    case invalidURL
    case noResponse
    case unexpectedStatusCode
    case other(Error)
    
    public var errorDescription: String? {
        switch self {
        case .decode:
            return "Cannot decode propertly"
        case .invalidURL:
            return "Invalid URL"
        case .noResponse:
            return "No response"
        case .unexpectedStatusCode:
            return "Server error code"
        case let .other(error):
            return error.localizedDescription
        }
    }
    
    public static func == (lhs: APIError, rhs: APIError) -> Bool {
        guard type(of: lhs) == type(of: rhs) else { return false }
        
        if case let .other(errorLhs) = lhs, case let .other(errorRhs) = rhs {
            return String(reflecting: errorLhs) == String(reflecting: errorRhs)
        }
        
        return true
    }
}
