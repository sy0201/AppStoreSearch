//
//  ResultTableViewCell.swift
//  appStoreSearch
//
//  Created by siyeon park on 2023/07/10.
//

import UIKit
import Kingfisher

final class ResultTableViewCell: UITableViewCell, ReuseIdentifying {

    private let img: UIImageView = UIImageView()
    private let titleLabel: UILabel =  UILabel()
    private let corpNameLabel: UILabel = UILabel()
    private let userRatingCountLabel: UILabel = UILabel()
    private let downloadButton: UIButton = UIButton()

    private let stackView: UIStackView = {
        let stackView = UIStackView()

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 2
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraint()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

// MARK: - Internal Methods

extension ResultTableViewCell {
    func setupUI() {
        img.layer.cornerRadius = 10
        img.layer.masksToBounds = true

        titleLabel.font = .systemFont(ofSize: 16)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        corpNameLabel.font = .systemFont(ofSize: 14)
        corpNameLabel.textColor = .lightGray

        downloadButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        downloadButton.setTitleColor(.blue, for: .normal)
        downloadButton.setTitle("받기", for: .normal)
        downloadButton.backgroundColor = .systemGray6
        downloadButton.layer.cornerRadius = 17
        downloadButton.layer.masksToBounds = true

        contentView.addSubview(img)
        contentView.addSubview(stackView)
        contentView.addSubview(downloadButton)
    }

    func setupConstraint() {
        img.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        corpNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userRatingCountLabel.translatesAutoresizingMaskIntoConstraints = false
        downloadButton.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        corpNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true

        [titleLabel, corpNameLabel, userRatingCountLabel].forEach {
            self.stackView.addArrangedSubview($0)
        }

        NSLayoutConstraint.activate([
            img.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            img.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            img.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            img.widthAnchor.constraint(equalToConstant: 60),
            img.heightAnchor.constraint(equalToConstant: 60),
            stackView.leadingAnchor.constraint(equalTo: img.trailingAnchor, constant: 10),
            stackView.centerYAnchor.constraint(equalTo: img.centerYAnchor),
            downloadButton.widthAnchor.constraint(equalToConstant: 80),
            downloadButton.leadingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 5),
            downloadButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            downloadButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    func setupItem(_ list: RecommendModel.RecommendData) {
        titleLabel.text = list.title
        corpNameLabel.text = list.description
        downloadButton.isHidden = false
    }

}
