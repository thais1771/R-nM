//
//  ListWorker.swift
//  R'nM
//
//  Created by Thais Rodríguez on 21/1/23.
//

import Foundation
import Networking

final class ListWorker {
    let apiClient = APIClient()
    var charactersPage = 1
    
    func loadCharacters() async throws -> AllCharactersResponseModel {
        do {
            let response = try await apiClient.getAllCharacters(page: charactersPage)
            charactersPage += 1
            return response
        } catch {
            throw(error)
        }
    }
}
