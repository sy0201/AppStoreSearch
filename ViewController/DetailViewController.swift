//
//  DetailViewController.swift
//  appStoreSearch
//
//  Created by siyeon park on 2023/07/20.
//

import UIKit

final class DetailViewController: UIViewController {
    private let searchKeyword: String

    private(set) var tableView: UITableView = UITableView()
    let searchList = NetworkingManager.shared

    private var items: [SearchItemResult] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                let isEmpty = self.items.isEmpty
                self.tableView.isHidden = isEmpty
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.largeTitleDisplayMode = .never
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraint()
        setupTableView()

        requestData(keyword: searchKeyword)
    }

    init(searchKeyword: String) {
        self.searchKeyword = searchKeyword
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Methods

extension DetailViewController {
    func setupUI() {
        title = "디테일"

        tableView = UITableView(frame: .zero, style: .plain)
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.sectionFooterHeight = 0
        tableView.backgroundColor = .white
        tableView.rowHeight = UITableView.automaticDimension

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

        tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.reuseIdentifier)
    }

    func requestData(keyword: String) {
        searchList.searchItunesAPI(term: keyword, completionHandler: { [weak self] result in
            guard let self = self else { return }
            self.items = result
        }, failure: { error in
            print(error)
        })
    }
}

// MARK: - UITableView Protocol

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.reuseIdentifier, for: indexPath) as? DetailTableViewCell else { return UITableViewCell() }

        guard let item = items[safe: indexPath.row] else {
            return cell
        }

        cell.setupItem(item)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
}
