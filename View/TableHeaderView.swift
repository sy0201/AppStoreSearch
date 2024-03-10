//
//  TableHaederView.swift
//  appStoreSearch
//
//  Created by siyeon park on 2023/07/17.
//

import UIKit

final class TableHeaderView: UITableViewHeaderFooterView, ReuseIdentifying {

    let titleLabel: UILabel = UILabel()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraint()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension TableHeaderView {
    func setupUI() {
        contentView.addSubview(titleLabel)
    }

    func setupConstraint() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
}
