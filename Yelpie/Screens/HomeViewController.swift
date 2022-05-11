//
//  HomeViewController.swift
//  Yelpie
//
//  Created by KhuongPham on 11/05/2022.
//

import Foundation
import UIKit
import RxSwift

final class HomeViewController: UIViewController {
    private let viewModel: HomeViewModel

    private let tableView = UITableView()

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupLayout()
        viewModel.fetchBusinesses()
            .subscribe { [weak self] _ in
                self?.tableView.reloadData()
            } onError: { error in
                print(error)
            }
            .disposed(by: rx.disposeBag)
    }

    private func setupLayout() {
        view.addSubview(tableView)

        tableView.edgesToSuperview()
    }

    private func setupTableView() {
        tableView.register(HomeTableViewCell.self)
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.businesses.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(HomeTableViewCell.self, for: indexPath)
        let business = viewModel.businesses[indexPath.row]
        cell.set(business)
        return cell
    }
}
