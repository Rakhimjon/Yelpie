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
        .bgColor(.white)

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
        setupTableView()
        setupLayout()
        fetchBusinesses()
        requestLocation()
    }

    private func setupLayout() {
        navigationController?.navigationBar.isHidden = true
        view.addSubviews(filterView, tableView)

        filterView.edgesToSuperview(excluding: .bottom)

        tableView.topToBottom(of: filterView)
        tableView.edgesToSuperview(excluding: .top)
    }

    private func setupTableView() {
        tableView.register(HomeTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }

    private func fetchBusinesses() {
        viewModel.fetchBusinesses()
            .subscribe { [weak self] _ in
                self?.tableView.reloadData()
            } onError: { error in
                print(error)
            }
            .disposed(by: rx.disposeBag)
    }

    private func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
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
