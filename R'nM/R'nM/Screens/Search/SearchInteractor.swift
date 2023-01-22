//
//  SearchInteractor.swift
//  R'nM
//
//  Created by Thais Rodríguez on 19/1/23.
//

import Foundation
import Networking

protocol SearchBusinessLogic {
    func searchCharacters(_ character: String)
    func paginate(_ character: String)
}

final class SearchInteractor: SearchBusinessLogic {
    private let presenter: SearchPresentationLogic
    private let worker: SearchWorker

    init(viewController: SearchDisplayLogic) {
        presenter = SearchPresenter(viewController: viewController)
        worker = SearchWorker()
    }

    func searchCharacters(_ character: String) {
        Task.init {
            do {
                let response = try await worker.search(character)
                presenter.presentCharacters(response)
            } catch {
                presenter.presentError(error)
            }
        }
    }

    func paginate(_ character: String) {
        Task.init {
            do {
                let response = try await worker.search(character)
                presenter.presentPaginationCharacters(response)
            } catch {
                presenter.presentError(error)
            }
        }
    }
}
