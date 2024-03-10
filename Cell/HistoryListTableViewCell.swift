//
//  SearchLiskTableViewCell.swift
//  appStoreSearch
//
//  Created by siyeon park on 2023/07/10.
//

import UIKit

final class HistoryListTableViewCell: UITableViewCell, ReuseIdentifying {

    private let historyLabel: UILabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("초기화할 수 없습니다.")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setup(model: SearchTermCellModel) {
        setupTitle(text: model.title)
    }
}

// MARK: - Private methods
private extension HistoryListTableViewCell {
    func setupTitle(text: String) {
        historyLabel.font = .systemFont(ofSize: 20)
        historyLabel.textColor = .blue
        historyLabel.text = text
    }

    func setupUI() {
        contentView.addSubview(historyLabel)
        self.selectionStyle = .none
    }

    func setupConstraint() {
        historyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            historyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            historyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            historyLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            historyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            historyLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
