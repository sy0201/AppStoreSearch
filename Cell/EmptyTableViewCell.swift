//
//  EmptyTableViewCell.swift
//  appStoreSearch
//
//  Created by siyeon park on 2023/07/12.
//

import UIKit

final class EmptyTableViewCell: UITableViewCell, ReuseIdentifying {

    let emptyLabel: UILabel = {
        let emptyLabel = UILabel()
        emptyLabel.text = ""
        return emptyLabel
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func setup(text: String) {
        setupTitle(text: text)
        setupConstraint()
    }
}

private extension EmptyTableViewCell {
    func setupTitle(text: String) {
        emptyLabel.text = text
        contentView.addSubview(emptyLabel)
    }

    func setupConstraint() {
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            emptyLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 55),
            emptyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -55),
            emptyLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
