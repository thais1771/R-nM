//
//  ListViewController.swift
//  R'nM
//
//  Created by Thais Rodríguez on 21/1/23.
//

import Networking
import UIKit

protocol ListDisplayLogic {
    func displayCharacters(_ response: [CharacterResponseModel])
}

final class ListViewController: UIViewController {
    var characters: [CharacterResponseModel] = []
    private lazy var interactor: ListBusinessLogic = {
        let interactor = ListInteractor(viewController: self)
        return interactor
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
        interactor.loadData()
    }
}

// MARK: - Private methods

extension ListViewController {
    private func paginateIfNeeded(at index: Int) {
        if index == characters.count - 4 {
            interactor.loadData()
        }
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .init(systemName: .magnifyingglass), primaryAction: .init(handler: openSearchVC))

        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 40),
            imageView.heightAnchor.constraint(equalToConstant: 40)
        ])

        navigationItem.titleView = imageView
    }

    private func addSubviews() {
        [collectionView].forEach { view.addSubview($0) }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func openSearchVC(_ action: UIAction) {
        let vc = SearchViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - ListDisplayLogic

extension ListViewController: ListDisplayLogic {
    func displayCharacters(_ response: [CharacterResponseModel]) {
        characters.append(contentsOf: response)

        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

// MARK: UICollectionViewDelegate

extension ListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController(character: characters[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: UICollectionViewDataSource

extension ListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { characters.count }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.reuseID, for: indexPath) as? ListCollectionViewCell else { return UICollectionViewCell() }
        cell.setCharacter(characters[indexPath.row])

        paginateIfNeeded(at: indexPath.row)

        return cell
    }
}
