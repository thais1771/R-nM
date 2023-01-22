//
//  ListCollectionViewCell.swift
//  R'nM
//
//  Created by Thais Rodríguez on 21/1/23.
//

import Networking
import UIKit
import NukeExtensions

class ListCollectionViewCell: UICollectionViewCell {
    static let reuseID = "ListCollectionViewCellID"
    
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
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var lblLocation: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.backgroundColor = .clear
        label.font = .preferredFont(forTextStyle: .caption1)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private methods

extension ListCollectionViewCell {
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func addSubviews() {
        [lblLocation, lblName, image].forEach { contentView.addSubview($0) }
    }
    
    private func setupConstraints() {
        lblDescriptionConstraints()
        lblNameConstraints()
        bkgImageConstraints()
    }
    
    private func lblDescriptionConstraints() {
        NSLayoutConstraint.activate([
            lblLocation.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            lblLocation.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            lblLocation.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func lblNameConstraints() {
        NSLayoutConstraint.activate([
            lblName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            lblName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            lblName.bottomAnchor.constraint(equalTo: lblLocation.topAnchor, constant: -5)
        ])
    }

    private func bkgImageConstraints() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            image.bottomAnchor.constraint(equalTo: lblName.topAnchor, constant: -5)
        ])
    }
}

// MARK: - Internal methods

extension ListCollectionViewCell {
    func setCharacter(_ character: CharacterResponseModel) {
        lblLocation.text = character.location.name
        lblName.text = character.name
        image.nukeLoad(url: character.image)
    }
}
