//
//  SearchCollectionViewCell.swift
//  appStoreSearch
//
//  Created by siyeon park on 2023/07/19.
//

import UIKit

final class SearchCollectionViewCell: UICollectionViewCell, ReuseIdentifying {

    private let img: UIImageView = UIImageView()
    private let titleLabel: UILabel = UILabel()

    private let stackView: UIStackView = {
        let stackView = UIStackView()

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(title: String) {
        titleLabel.text = title
    }
}

// MARK: - Private Methods

private extension SearchCollectionViewCell {
    func setupUI() {
        let magnifyingGlassImage = UIImage(systemName: "magnifyingglass")
        img.image = magnifyingGlassImage
        titleLabel.font = .systemFont(ofSize: 16)
        titleLabel.textColor = .blue
        contentView.addSubview(stackView)
    }

    func setupConstraint() {
        img.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        [img, titleLabel].forEach {
            self.stackView.addArrangedSubview($0)
        }

        NSLayoutConstraint.activate([
            img.widthAnchor.constraint(equalToConstant: 18),
            img.heightAnchor.constraint(equalToConstant: 18),
            stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10)
        ])
    }
}
