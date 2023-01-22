//
//  AllCharactersResponseModel.swift
//  
//
//  Created by Thais Rodríguez on 19/1/23.
//

import Foundation

public struct AllCharactersResponseModel: Decodable, Equatable {
    public let results: [CharacterResponseModel]
    public let info: AllCharactesrPaginationInfo
}

public struct AllCharactesrPaginationInfo: Decodable, Equatable {
    public let pages: Int
}
