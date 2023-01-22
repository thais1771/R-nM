//
//  ListPresenter.swift
//  R'nM
//
//  Created by Thais Rodríguez on 21/1/23.
//

import Foundation
import Networking

protocol ListPresentationLogic {
    func presentCharacters(_ response: AllCharactersResponseModel)
}

final class ListPresenter: ListPresentationLogic {
    private let viewController: ListDisplayLogic

    init(viewController: ListDisplayLogic) {
        self.viewController = viewController
    }
    
    func presentCharacters(_ response: AllCharactersResponseModel) {
        viewController.displayCharacters(response.results)
    }
}
