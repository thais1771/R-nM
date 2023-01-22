//
//  CharacterEndpoint.swift
//  
//
//  Created by Thais Rodríguez on 19/1/23.
//

import Foundation

enum CharacterEndpoint: Endpoint {
    case getAllCharacters(page: Int? = nil)
    case getCharacter(id: Int)
    case getCharacters(ids: [Int])
    case getCharactersFiltered(filter: String, page: Int)
    
    var path: String {
        let basePath = "character"
        
        switch self {
        case .getAllCharacters:
            return basePath
        case let .getCharacter(id):
            return [basePath, String(id)].joined(separator: "/")
        case let .getCharacters(ids):
            let idsToRequest = ids.map { String($0) }.joined(separator: ",")
            return [basePath, idsToRequest].joined(separator: "/")
        case .getCharactersFiltered:
            return basePath
        }
    }
    
    var method: HTTPMethod<Body> {
        switch self {
        default:
            return .GET
        }
    }
    
    var params: [String: String]? {
        switch self {
        case let .getAllCharacters(page):
            if let page {
                return ["page": String(page)]
            }
            return nil
        case let .getCharactersFiltered(filter, page):
            return ["page": String(page),
                    "name": filter]
        default:
            return nil
        }
    }
}
