//
//  ListInteractor.swift
//  R'nM
//
//  Created by Thais Rodríguez on 21/1/23.
//

import Foundation

protocol ListBusinessLogic {
    func loadData()
}

final class ListInteractor: ListBusinessLogic {
    private let presenter: ListPresentationLogic
    private let worker: ListWorker

    init(viewController: ListDisplayLogic) {
        presenter = ListPresenter(viewController: viewController)
        worker = ListWorker()
    }
    
    func loadData() {
        Task.init {
            do {
                let response = try await worker.loadCharacters()
                presenter.presentCharacters(response)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
