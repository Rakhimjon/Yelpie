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

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchBusinesses()
            .subscribe { businesses in
                print(businesses)
            } onError: { error in
                print(error)
            }
            .disposed(by: rx.disposeBag)
    }
}
