//
//  DetailPresenter.swift
//  R'nM
//
//  Created by Thais Rodríguez on 21/1/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol DetailPresentationLogic {}

final class DetailPresenter: DetailPresentationLogic {
    private let viewController: DetailDisplayLogic

    init(viewController: DetailDisplayLogic) {
        self.viewController = viewController
    }
}
