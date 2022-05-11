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
    private var starViews: [StarView] = []

    enum StarFilling {
        case empty
        case half
        case full
    }

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
            starViews.append(starView)
            stackView.addArrangedSubview(starView)
        }
    }

    func setRating(_ rating: Double) {
        for starView in starViews {
            var starFilling: StarFilling = .empty
            let value = Double(starView.tag)
            if rating - value == 0.5 {
                starFilling = .half
            } else if rating - value > 0.5 {
                starFilling = .full
            }
            starView.set(starFilling)
        }
    }
}

extension RatingView {
    final class StarView: UIView {
        private let colorView = UIView().bgColor(.primaryColor)
        private let starImageView = UIImageView(image: UIImage(named: "ic-star")).tintColor(.white)
        private var zeroColorViewWidthConstraint: Constraint!
        private var halfColorViewWidthConstraint: Constraint!
        private var fullColorViewWidthConstraint: Constraint!
        private let width: CGFloat = 20

        override init(frame: CGRect) {
            super.init(frame: .zero)
            setupLayout()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private func setupLayout() {
            backgroundColor = .ratingBackground
            round(by: 4)
            clip()

            addSubviews(colorView, starImageView)

            width(width)
            height(width)

            colorView.edgesToSuperview(excluding: .right)
            zeroColorViewWidthConstraint = colorView.width(0, isActive: true)
            halfColorViewWidthConstraint = colorView.width(width / 2, isActive: false)
            fullColorViewWidthConstraint = colorView.width(width, isActive: false)

            starImageView.edgesToSuperview(insets: .uniform(4))
        }

        func set(_ starFilling: StarFilling) {
            zeroColorViewWidthConstraint.isActive = false
            halfColorViewWidthConstraint.isActive = false
            fullColorViewWidthConstraint.isActive = false

            switch starFilling {
            case .empty:
                zeroColorViewWidthConstraint.isActive = true
            case .half:
                halfColorViewWidthConstraint.isActive = true
            case .full:
                fullColorViewWidthConstraint.isActive = true
            }
        }
    }
}
