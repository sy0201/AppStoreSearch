//
//  ViewController.swift
//  appStoreSearch
//
//  Created by siyeon park on 2023/07/10.
//

import UIKit

enum TableViewSectionType: Int, CaseIterable {
    case newDiscovery
    case recommendedAppAndGames
}

final class ViewController: UIViewController {

    private var tableView: UITableView = UITableView()

    private lazy var historyListVC: HistoryListViewController = {
        let viewController = HistoryListViewController()
        viewController.listener = self
        return viewController
    }()

    private let searchViewModel = SearchViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        setupNavigationBar()
        searchViewModel.setListData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupConstraint()
    }

    private lazy var searchController: UISearchController = {
        var searchController = UISearchController(searchResultsController: historyListVC)
        searchController.searchBar.placeholder = "search_placeholder".localized
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.delegate = self
        searchController.searchBar.delegate = self
        return searchController
    }()

    private var displaySections: [TableViewSectionType] {
        var resultSections: [TableViewSectionType] = []
        TableViewSectionType.allCases.forEach {
            switch $0 {
            case .newDiscovery:
                if searchViewModel.dataList.isEmpty {
                    break
                } else {
                    resultSections.append(.newDiscovery)
                }
            case .recommendedAppAndGames:
                resultSections.append(.recommendedAppAndGames)
            }
        }
        return resultSections
    }
}

// MARK: - Private Methods

private extension ViewController {
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

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension

        tableView.register(HorizontalTableViewCell.self, forCellReuseIdentifier: HorizontalTableViewCell.reuseIdentifier)
        tableView.register(ResultTableViewCell.self, forCellReuseIdentifier: ResultTableViewCell.reuseIdentifier)
        tableView.register(TableHeaderView.self, forHeaderFooterViewReuseIdentifier: TableHeaderView.reuseIdentifier)
    }

    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "search_title".localized
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.largeTitleDisplayMode = .always
    }
}

// MARK: - UISearchController Protocol

extension ViewController: UISearchControllerDelegate {
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        updateSearchHistory(query: text)
        historyListVC.setupHistoryQuerys()
    }

    func updateSearchHistory(query: String) {
        if let row = historyListVC.historyItem.firstIndex(of: query) {
            historyListVC.historyItem.remove(at: row)
        }
        historyListVC.historyItem.insert(query, at: 0)
        if historyListVC.historyItem.count > 10 {
            historyListVC.historyItem.removeLast(historyListVC.historyItem.count - 10)
        }

        UserDefaultsManager.updateStringArray(value: historyListVC.historyItem, key: .recentSearchTerms)

        tableView.reloadData()
    }
}

// MARK: - UITableView Protocol

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        print("section : \(TableViewSectionType.RawValue())")
        return displaySections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch displaySections[section] {
        case .newDiscovery:
            return Int(ceil(Double(searchViewModel.dataList.count) / 2.0))
        case .recommendedAppAndGames:
            return searchViewModel.recommendList.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch displaySections[indexPath.section] {
        case .newDiscovery:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HorizontalTableViewCell", for: indexPath) as? HorizontalTableViewCell else { return UITableViewCell() }

            let row에해당하는첫번째index: Int = indexPath.row * 2
            var row에해당하는마지막index: Int = (indexPath.row + 1) * 2 - 1

            if searchViewModel.dataList.count - 1 < row에해당하는마지막index {
                row에해당하는마지막index -= 1
            }

            let newDataList = searchViewModel.dataList[row에해당하는첫번째index...row에해당하는마지막index]
            cell.setup(items: Array(newDataList))

            return cell
        case .recommendedAppAndGames:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ResultTableViewCell", for: indexPath) as? ResultTableViewCell else { return UITableViewCell() }

            guard let data = searchViewModel.recommendList[safe: indexPath.row] else { return UITableViewCell() }

            cell.setupItem(data)

            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tableViewCell didSelect At \(indexPath.row)")
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TableHeaderView") as? TableHeaderView else {
            return UIView()
        }

        headerView.titleLabel.font = .systemFont(ofSize: 22, weight: .bold)

        switch displaySections[section] {
        case .newDiscovery:
            headerView.titleLabel.text = "새로운 발견"
        case .recommendedAppAndGames:
            headerView.titleLabel.text = "추천 앱과 게임"
        }
        return headerView
    }
}

// MARK: - HistoryListViewControllerListener

extension ViewController: HistoryListViewControllerListener {
    func pushToDetail(searchKeyword: String) {
        let viewController = DetailViewController(searchKeyword: searchKeyword)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
