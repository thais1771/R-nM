//
//  SearchViewController.swift
//  R'nM
//
//  Created by Thais Rodríguez on 19/1/23.
//

import Networking
import UIKit

protocol SearchDisplayLogic {
    func displayPaginationCharacters(_ response: [CharacterResponseModel])
    func displayCharacters(_ response: [CharacterResponseModel])
    func displayError(_ error: Error)
}

final class SearchViewController: UIViewController {
    var characters: [CharacterResponseModel] = []

    private lazy var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.delegate = self
        bar.barStyle = .default
        bar.searchBarStyle = .minimal
        bar.becomeFirstResponder()
        bar.translatesAutoresizingMaskIntoConstraints = false

        return bar
    }()

    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: .defaultLayout())
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .clear
        view.showsVerticalScrollIndicator = false
        view.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: ListCollectionViewCell.reuseID)
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    // MARK: Properties
    lazy var interactor: SearchBusinessLogic = {
        let interactor = SearchInteractor(viewController: self)
        return interactor
    }()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupUI()
        addSubviews()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Private methods

extension SearchViewController {
    private func setupUI() {
        view.backgroundColor = .systemBackground
    }

    private func addSubviews() {
        [searchBar, collectionView].forEach { view.addSubview($0) }
    }

    private func setupConstraints() {
        searchBarConstraints()
        collectionViewConstraints()
    }

    private func searchBarConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func collectionViewConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - Internal methods {
extension SearchViewController {
    func paginateIfNeeded(at index: Int) {
        if index == characters.count - 4 {
            guard let characterSearch = searchBar.text?.trimmingCharacters(in: .whitespaces) else { return }
            interactor.paginate(characterSearch)
        }
    }
}

// MARK: - SearchDisplyLogic

extension SearchViewController: SearchDisplayLogic {
    func displayPaginationCharacters(_ response: [CharacterResponseModel]) {
        characters.append(contentsOf: response)

        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    func displayCharacters(_ response: [CharacterResponseModel]) {
        characters = response

        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.collectionView.scrollsToTop = true
        }
    }

    func displayError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close app", style: .destructive, handler: { _ in
            fatalError()
        }))

        DispatchQueue.main.async {
//            self.navigationController?.present(alert, animated: true)
        }
    }
}
