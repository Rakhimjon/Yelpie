//
//  FilterViewController.swift
//  Yelpie
//
//  Created by KhuongPham on 12/05/2022.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import TinyConstraints
import CoreLocation

final class FilterViewController: UIViewController {
    enum Cuisine: String {
        case restanrant = "Restaurant"
        case fastFood = "Fast Food"
    }

    private let textField = TextField()
        .font(.medium(14))
        .placeholder("Search location")
        .bgColor(.white).color(.darkText)

    private let tableView = UITableView()
        .bgColor(.white.withAlphaComponent(0.4))

    private let cuisineLabel = UILabel("Cuisine")
        .font(.bold(16))

    private let restaurantButton = UIButton()
        .title(Cuisine.restanrant.rawValue)
        .font(.bold(16))
        .bgColor(.ratingBackground)
        .titleColor(.darkText, .normal)
        .titleColor(.white, .selected)

    private let fastFoodButton = UIButton()
        .title(Cuisine.fastFood.rawValue)
        .font(.bold(16))
        .bgColor(.ratingBackground)
        .titleColor(.darkText, .normal)
        .titleColor(.white, .selected)

    private let viewModel: FilterViewModel

    var onSelectCuisineAndCoordinate: ((String?, CLLocationCoordinate2D?) -> Void)?

    init(viewModel: FilterViewModel) {
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
        setupEvents()
    }

    private func setupLayout() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        textField.borderStyle(.roundedRect)
        restaurantButton.round(by: 8)
        fastFoodButton.round(by: 8)

        view.addSubviews(textField, tableView, cuisineLabel, restaurantButton, fastFoodButton)

        textField.edgesToSuperview(excluding: .bottom, insets: .top(20) + .horizontal(10), usingSafeArea: true)

        tableView.topToBottom(of: textField, offset: 4)
        tableView.edgesToSuperview(excluding: [.top, .bottom], insets: .horizontal(10))
        tableView.height(350)

        cuisineLabel.topToBottom(of: tableView, offset: 20)
        cuisineLabel.leadingToSuperview(offset: 10)

        restaurantButton.topToBottom(of: cuisineLabel, offset: 8)
        restaurantButton.leading(to: cuisineLabel)
        restaurantButton.width(120)
        restaurantButton.height(40)

        fastFoodButton.centerY(to: restaurantButton)
        fastFoodButton.leadingToTrailing(of: restaurantButton, offset: 8)
        fastFoodButton.width(to: restaurantButton)
        fastFoodButton.height(to: restaurantButton)
    }

    private func setupTableView() {
        tableView.round(by: 8)
        tableView.setBorder(with: .seperateLine, width: 0.5)
        tableView.register(LocationTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }

    private func setupEvents() {
        textField.rx.text.orEmpty
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] searchText in
                viewModel.searchLocation(by: searchText)
            })
            .disposed(by: rx.disposeBag)

        viewModel.locations
            .subscribe(onNext: { [weak self] locations in
                self?.tableView.reloadData()
            })
            .disposed(by: rx.disposeBag)

        restaurantButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                if viewModel.selectedCuisine == Cuisine.restanrant.rawValue {
                    restaurantButton.backgroundColor = .ratingBackground
                    restaurantButton.isSelected = false
                    viewModel.selectedCuisine = nil
                } else {
                    restaurantButton.backgroundColor = .primaryColor
                    restaurantButton.isSelected = true
                    viewModel.selectedCuisine = restaurantButton.titleLabel?.text
                }
            })
            .disposed(by: rx.disposeBag)

        fastFoodButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                if viewModel.selectedCuisine == Cuisine.fastFood.rawValue {
                    fastFoodButton.backgroundColor = .ratingBackground
                    fastFoodButton.isSelected = false
                    viewModel.selectedCuisine = nil
                } else {
                    fastFoodButton.backgroundColor = .primaryColor
                    fastFoodButton.isSelected = true
                    viewModel.selectedCuisine = fastFoodButton.titleLabel?.text
                }
            })
            .disposed(by: rx.disposeBag)
    }
}

extension FilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.locations.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(LocationTableViewCell.self, for: indexPath)
        let location = viewModel.locations.value[indexPath.row]
        cell.set(location)
        return cell
    }
}

extension FilterViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location = viewModel.locations.value[indexPath.row]
        onSelectCuisineAndCoordinate?(viewModel.selectedCuisine, location.coordinate)
        navigationController?.popViewController(animated: true)
    }
}
