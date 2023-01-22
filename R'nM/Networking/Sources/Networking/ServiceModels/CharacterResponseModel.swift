//
//  CharacterResponseModel.swift
//  
//
//  Created by Thais Rodríguez on 19/1/23.
//

import Foundation

public struct CharacterResponseModel: Decodable, Equatable, Identifiable, Hashable {
    public let id: Int
    public let name: String
    public let status: String
    public let species: String
    public let type: String
    public let gender: String
    public let origin: CharacterPlaceData
    public let location: CharacterPlaceData
    public let image: URL
    public let episode: [URL]
    public let url: URL

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

public struct CharacterPlaceData: Decodable, Equatable {
    public let name: String
}
