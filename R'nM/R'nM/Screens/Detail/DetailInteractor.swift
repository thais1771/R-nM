//
//  DetailInteractor.swift
//  R'nM
//
//  Created by Thais Rodríguez on 21/1/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol DetailBusinessLogic {
}

final class DetailInteractor: DetailBusinessLogic {
    private let presenter: DetailPresentationLogic
    private let worker: DetailWorker
    
    init(viewController: DetailDisplayLogic) {
        presenter = DetailPresenter(viewController: viewController)
        worker = DetailWorker()
    }
}
