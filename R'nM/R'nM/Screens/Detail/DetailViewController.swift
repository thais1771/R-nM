//
//  DetailViewController.swift
//  R'nM
//
//  Created by Thais Rodríguez on 21/1/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Networking
import UIKit

protocol DetailDisplayLogic {}

final class DetailViewController: UIViewController {
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.isDirectionalLockEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false

        return image
    }()
    
    private lazy var lblName: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.backgroundColor = .clear
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var lblgender: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.backgroundColor = .clear
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var lblLocationTitle: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.backgroundColor = .clear
        label.font = .preferredFont(forTextStyle: .title3)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var lblLocation: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.backgroundColor = .clear
        label.font = .preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var lblSpeciesTitle: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.backgroundColor = .clear
        label.font = .preferredFont(forTextStyle: .title3)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var lblSpecies: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.backgroundColor = .clear
        label.font = .preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var lblStatusTitle: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.backgroundColor = .clear
        label.font = .preferredFont(forTextStyle: .title3)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var lblStatus: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.backgroundColor = .clear
        label.font = .preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    private lazy var interactor: DetailBusinessLogic = {
        let interactor = DetailInteractor(viewController: self)
        return interactor
    }()

    init(character: CharacterResponseModel) {
        super.init(nibName: nil, bundle: nil)
        setupUI(with: character)
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

extension DetailViewController {
    private func setupUI(with character: CharacterResponseModel) {
        view.backgroundColor = .systemBackground
        image.nukeLoad(url: character.image)
        lblName.text = character.name
        lblgender.text = character.gender == "Male" ? "♂" : "♀"
        lblgender.textColor = character.gender == "Male" ? .systemBlue : .init(named: "pink")
        lblLocationTitle.attributedText = "Location:".underLined
        lblLocation.text = character.origin.name + " / " + character.location.name
        lblSpeciesTitle.attributedText = "Species:".underLined
        lblSpecies.text = character.species
        lblStatusTitle.attributedText = "Status:".underLined
        lblStatus.text = character.status
    }

    private func addSubviews() {
        [image, lblName, lblgender, lblLocationTitle, lblLocation, lblSpeciesTitle, lblSpecies, lblStatusTitle, lblStatus].forEach { scrollView.addSubview($0) }
        [scrollView].forEach { view.addSubview($0) }
    }

    private func setupConstraints() {
        scrollViewConstraints()
        imageConstraints()
        lblNameConstraints()
        lblGenderConstraints()
        lblLocationTitleConstraints()
        lblLocationConstraints()
        lblSpeciesTitleConstraints()
        lblSpeciesConstraints()
        lblStatusTitleConstraints()
        lblStatusConstraints()
    }

    private func scrollViewConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func imageConstraints() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: scrollView.topAnchor),
            image.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            image.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            image.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            image.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 2.5)
        ])
    }

    private func lblNameConstraints() {
        NSLayoutConstraint.activate([
            lblName.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 20),
            lblName.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10)
        ])
    }
    
    private func lblGenderConstraints() {
        NSLayoutConstraint.activate([
            lblgender.topAnchor.constraint(equalTo: lblName.topAnchor),
            lblgender.leadingAnchor.constraint(equalTo: lblName.trailingAnchor, constant: 10),
            lblgender.heightAnchor.constraint(equalTo: lblName.heightAnchor),
            lblgender.widthAnchor.constraint(equalTo: lblgender.heightAnchor),
            lblgender.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20)
        ])
    }

    private func lblLocationTitleConstraints() {
        NSLayoutConstraint.activate([
            lblLocationTitle.topAnchor.constraint(equalTo: lblName.bottomAnchor, constant: 20),
            lblLocationTitle.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            lblLocationTitle.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            lblLocationTitle.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20)
        ])
    }

    private func lblLocationConstraints() {
        NSLayoutConstraint.activate([
            lblLocation.topAnchor.constraint(equalTo: lblLocationTitle.bottomAnchor, constant: 5),
            lblLocation.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            lblLocation.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            lblLocation.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20)
        ])
    }

    private func lblSpeciesTitleConstraints() {
        NSLayoutConstraint.activate([
            lblSpeciesTitle.topAnchor.constraint(equalTo: lblLocation.bottomAnchor, constant: 10),
            lblSpeciesTitle.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            lblSpeciesTitle.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            lblSpeciesTitle.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20)
        ])
    }

    private func lblSpeciesConstraints() {
        NSLayoutConstraint.activate([
            lblSpecies.topAnchor.constraint(equalTo: lblSpeciesTitle.bottomAnchor, constant: 5),
            lblSpecies.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            lblSpecies.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            lblSpecies.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20)
        ])
    }

    private func lblStatusTitleConstraints() {
        NSLayoutConstraint.activate([
            lblStatusTitle.topAnchor.constraint(equalTo: lblSpecies.bottomAnchor, constant: 10),
            lblStatusTitle.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            lblStatusTitle.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            lblStatusTitle.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20)
        ])
    }

    private func lblStatusConstraints() {
        NSLayoutConstraint.activate([
            lblStatus.topAnchor.constraint(equalTo: lblStatusTitle.bottomAnchor, constant: 5),
            lblStatus.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            lblStatus.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            lblStatus.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            lblStatus.bottomAnchor.constraint(lessThanOrEqualTo: scrollView.bottomAnchor)
        ])
    }
}

// MARK: - DetailDisplayLogic

extension DetailViewController: DetailDisplayLogic {}
