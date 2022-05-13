//
//  HomeViewController.swift
//  Yelpie
//
//  Created by KhuongPham on 11/05/2022.
//

import Foundation
import UIKit
import RxSwift
import CoreLocation

final class HomeViewController: UIViewController {
    private let filterView = FilterView()

    private let tableView = UITableView()

    private let refreshControl = UIRefreshControl()

    private let viewModel: HomeViewModel
    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.delegate = self
        return locationManager
    }()

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupTableView()
        setupFilterView()
        requestLocation()
        fetchBusinesses()
    }

    private func setupLayout() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        view.addSubviews(filterView, tableView)

        filterView.edgesToSuperview(excluding: .bottom)

        tableView.topToBottom(of: filterView)
        tableView.edgesToSuperview(excluding: .top)
    }

    private func setupFilterView() {
        filterView.onTextChange = { [unowned self] searchText in
            if let searchText = searchText, !searchText.isEmpty {
                viewModel.filteredBusinesses = viewModel.businesses
                    .filter { $0.name.lowercased().contains(searchText.lowercased()) }
            } else {
                viewModel.filteredBusinesses = viewModel.businesses
            }
            tableView.reloadData()
        }

        filterView.onTapFilter = { [unowned self] in
            let filterViewModel = FilterViewModel()
            let filterViewController = FilterViewController(viewModel: filterViewModel)
            navigationController?.pushViewController(filterViewController, animated: true)
        }
    }

    private func setupTableView() {
        tableView.register(HomeTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none

        refreshControl.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }

    private func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }

    private func fetchBusinesses() {
        viewModel.fetchBusinesses()
            .subscribe { [weak self] _ in
                guard let self = self else {
                    return
                }
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            } onError: { [weak self] error in
                self?.refreshControl.endRefreshing()
            }
            .disposed(by: rx.disposeBag)
    }

    @objc func pullToRefresh(_ sender: AnyObject) {
       fetchBusinesses()
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredBusinesses.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(HomeTableViewCell.self, for: indexPath)
        let business = viewModel.filteredBusinesses[indexPath.row]
        cell.set(business)
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}

extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print(location)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.requestLocation()
        default:
            manager.requestWhenInUseAuthorization()
        }
    }
}
