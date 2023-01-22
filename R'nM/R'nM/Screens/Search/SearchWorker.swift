//
//  SearchWorker.swift
//  R'nM
//
//  Created by Thais Rodríguez on 19/1/23.
//

import Foundation
import Networking

final class SearchWorker {
    let apiClient = APIClient()
    var charactersPage = 1
    var searchPage = 1
    
    func loadCharacters() async throws -> AllCharactersResponseModel {
        do {
            let response = try await apiClient.getAllCharacters(page: charactersPage)
            charactersPage += 1
            return response
        } catch {
            throw(error)
        }
    }
    
    func search(_ filter: String) async throws -> AllCharactersResponseModel {
        do {
            let response = try await apiClient.getCharactersFilteredWith(filter: filter, andPage: searchPage)
            searchPage += 1
            return response
        } catch {
            throw(error)
        }
    }
}
