//
//  RatingView.swift
//  Yelpie
//
//  Created by KhuongPham on 11/05/2022.
//

import Foundation
import UIKit
import TinyConstraints

final class RatingView: UIView {
    private let stackView = UIStackView().axis(.horizontal).spacing(4).distribution(.fillEqually)
    private let starViews: [StarView] = []

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        addSubview(stackView)

        stackView.edgesToSuperview()

        for i in 1...5 {
            let starView = StarView().tag(i)
            stackView.addArrangedSubview(starView)
        }
    }

    func setRating(_ rating: Double) {

    }
}

extension RatingView {
    final class StarView: UIView {
        private let starImageView = UIImageView(image: UIImage(named: "ic-star")).tintColor(.white)

        override init(frame: CGRect) {
            super.init(frame: .zero)
            setupLayout()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private func setupLayout() {
            backgroundColor = .systemOrange
            round(by: 4)

            addSubview(starImageView)

            width(24)
            height(24)

            starImageView.edgesToSuperview(insets: .uniform(4))
        }
    }
}
