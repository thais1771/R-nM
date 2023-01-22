//
//  SearchViewController+SearchDelegates.swift
//  R'nM
//
//  Created by Thais Rodríguez on 22/1/23.
//

import UIKit

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let characterSearch = searchBar.text?.trimmingCharacters(in: .whitespaces) else { return }
        interactor.searchCharacters(characterSearch)
    }
}
