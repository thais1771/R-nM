//
//  SearchPresenter.swift
//  R'nM
//
//  Created by Thais Rodríguez on 19/1/23.
//

import Foundation
import Networking

protocol SearchPresentationLogic {
    func presentPaginationCharacters(_ response: AllCharactersResponseModel)
    func presentCharacters(_ response: AllCharactersResponseModel)
    func presentError(_ error: Error)
}

final class SearchPresenter: SearchPresentationLogic {
    private let viewController: SearchDisplayLogic

    init(viewController: SearchDisplayLogic) {
        self.viewController = viewController
    }
    
    func presentPaginationCharacters(_ response: AllCharactersResponseModel) {
        viewController.displayPaginationCharacters(response.results)
    }
    
    func presentCharacters(_ response: AllCharactersResponseModel) {
        viewController.displayCharacters(response.results)
    }
    
    func presentError(_ error: Error) {
        viewController.displayError(error)
    }
}
