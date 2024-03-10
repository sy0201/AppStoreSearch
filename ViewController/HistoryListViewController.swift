//
//  HistoryListViewController.swift
//  appStoreSearch
//
//  Created by siyeon park on 2023/07/10.
//

import UIKit

final class HistoryListViewController: UIViewController {
    weak var listener: HistoryListViewControllerListener?

    private var tableView: UITableView = UITableView()

    var historyItem: [String] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                let isEmpty = self.historyItem.isEmpty
                self.tableView.isHidden = isEmpty
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraint()
        setupTableView()
        setupHistoryQuerys()
    }
}

// MARK: - Private Method

private extension HistoryListViewController {
    func setupUI() {
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.sectionFooterHeight = 0
        tableView.backgroundColor = .white
        self.view.addSubview(tableView)
    }

    func setupConstraint() {
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.separatorInset.right = 15

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension

        tableView.register(HistoryListTableViewCell.self, forCellReuseIdentifier: HistoryListTableViewCell.reuseIdentifier)
        tableView.register(TableHeaderView.self, forHeaderFooterViewReuseIdentifier: TableHeaderView.reuseIdentifier)
    }
}

// MARK: - Internal Method

extension HistoryListViewController {
    func setupHistoryQuerys() {
        historyItem = UserDefaultsManager.getStringArray(key: .recentSearchTerms)
        tableView.reloadData()
    }
}

extension HistoryListViewController: UITableViewDelegate {
}

extension HistoryListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyItem.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryListTableViewCell.reuseIdentifier, for: indexPath) as? HistoryListTableViewCell else { return UITableViewCell() }

        let title = historyItem[safe: indexPath.row] ?? ""
        let data = SearchTermCellModel(title: title)

        cell.setup(model: data)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let title = historyItem[safe: indexPath.row] else {
            return
        }

        listener?.pushToDetail(searchKeyword: title)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TableHeaderView") as? TableHeaderView else {
            return UIView()
        }
        headerView.titleLabel.font = .systemFont(ofSize: 22, weight: .bold)
        headerView.titleLabel.text = "최근 검색어"

        return headerView
    }
}
