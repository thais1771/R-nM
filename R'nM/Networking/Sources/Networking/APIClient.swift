//
//  APIClient.swift
//  
//
//  Created by Thais Rodríguez on 19/1/23.
//

import Foundation

public protocol APIClientProtocol {
    func getAllCharacters(page: Int?) async throws -> AllCharactersResponseModel
    func getCharacterWith(id: Int) async throws -> CharacterResponseModel
    func getCharactersWith(ids: [Int]) async throws -> [CharacterResponseModel]
    func getCharactersFilteredWith(filter: String, andPage page: Int) async throws -> AllCharactersResponseModel
}

public final class APIClient: HTTPRequest, APIClientProtocol {
    public init() {}

    public func getAllCharacters(page: Int?) async throws -> AllCharactersResponseModel {
        let endpoint = CharacterEndpoint.getAllCharacters(page: page)
        return try await sendRequest(endpoint: endpoint)
    }

    public func getCharacterWith(id: Int) async throws -> CharacterResponseModel {
        let endpoint = CharacterEndpoint.getCharacter(id: id)
        return try await sendRequest(endpoint: endpoint)
    }

    public func getCharactersWith(ids: [Int]) async throws -> [CharacterResponseModel] {
        let endpoint = CharacterEndpoint.getCharacters(ids: ids)
        return try await sendRequest(endpoint: endpoint)
    }

    public func getCharactersFilteredWith(filter: String, andPage page: Int) async throws -> AllCharactersResponseModel {
        let endpoint = CharacterEndpoint.getCharactersFiltered(filter: filter, page: page)
        return try await sendRequest(endpoint: endpoint)
    }
}
