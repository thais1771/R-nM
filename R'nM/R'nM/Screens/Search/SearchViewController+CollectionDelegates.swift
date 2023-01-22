//
//  SearchViewController+CollectionDelegates.swift
//  R'nM
//
//  Created by Thais Rodríguez on 22/1/23.
//

import UIKit

// MARK: UICollectionViewDelegate

extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController(character: characters[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: UICollectionViewDataSource

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { characters.count }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.reuseID, for: indexPath) as? ListCollectionViewCell else { return UICollectionViewCell() }
        cell.setCharacter(characters[indexPath.row])

        paginateIfNeeded(at: indexPath.row)

        return cell
    }
}
