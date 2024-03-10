//
//  ResultViewController.swift
//  appStoreSearch
//
//  Created by siyeon park on 2023/07/10.
//

import UIKit

final class ResultViewController: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    private var items: [SearchItemResult] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                let isEmpty = self.items.count.words.isEmpty
                self.tableView.isHidden = isEmpty
            }
        }
    }

    let searchViewModel = SearchViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setConstraint()
        setTableView()
    }
}

// MARK: - Private Method

private extension ResultViewController {
    func setConstraint() {
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }

    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.separatorStyle = .none

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension

        tableView.register(ResultTableViewCell.self, forCellReuseIdentifier: ResultTableViewCell.reuseIdentifier)
        tableView.register(EmptyTableViewCell.self, forCellReuseIdentifier: EmptyTableViewCell.reuseIdentifier)
    }
}

// MARK: - Internal Method

extension ResultViewController {
    func searchItems(term: String) {
        searchViewModel.searchItems(term: term) { response in
            let items = response.results
            self.items = items
        }
    }
}

extension ResultViewController: UITableViewDelegate {

}

extension ResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if items.isEmpty {
            return 1
        }
        print("bool: \(items.isEmpty)")
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if items.isEmpty {
            print("cell count: \(items.isEmpty)")
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EmptyTableViewCell.reuseIdentifier, for: indexPath) as? EmptyTableViewCell else { return UITableViewCell() }
            cell.setup(text: "검색하신 내용이 없습니다.")

            return cell
        }

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ResultTableViewCell", for: indexPath) as? ResultTableViewCell else { return UITableViewCell() }

        guard let item = items[safe: indexPath.row] else {
            return cell
        }

        cell.setupItem(item: item)
        return cell
    }
}
