//
//  HomeTableViewCell.swift
//  Yelpie
//
//  Created by KhuongPham on 11/05/2022.
//

import Foundation
import UIKit
import Kingfisher
import TinyConstraints

final class HomeTableViewCell: UITableViewCell {
    private let wrapperView = UIView()
    private let businessImageView = UIImageView().contentMode(.scaleAspectFill)
    private let businessNameLabel = UILabel().font(.bold(16)).color(.darkText).lines()
    private let ratingView = RatingView()
    private let ratingCountLabel = UILabel().font(.regular(12)).color(.gray).align(.right)
    private let categoryLabel = UILabel().font(.regular(14)).color(.darkText).lines()
    private let addressLabel = UILabel().font(.regular(14)).color(.gray).lines()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        contentView.backgroundColor = .seperateLine
        wrapperView.backgroundColor = .white
        businessImageView.round(by: 4)

        contentView.addSubview(wrapperView)
        wrapperView.addSubviews(businessImageView, businessNameLabel, ratingView, ratingCountLabel, categoryLabel, addressLabel)

        wrapperView.edgesToSuperview(insets: .bottom(4))

        businessImageView.edgesToSuperview(excluding: [.right, .bottom], insets: .left(8) + .top(8))
        businessImageView.width(100)
        businessImageView.height(100)

        businessNameLabel.top(to: businessImageView)
        businessNameLabel.leadingToTrailing(of: businessImageView, offset: 8)
        businessNameLabel.trailingToSuperview(offset: 8)

        ratingView.topToBottom(of: businessNameLabel, offset: 4)
        ratingView.leading(to: businessNameLabel)

        ratingCountLabel.centerY(to: ratingView)
        ratingCountLabel.trailing(to: businessNameLabel)

        categoryLabel.topToBottom(of: ratingView, offset: 4)
        categoryLabel.leading(to: businessNameLabel)
        categoryLabel.trailing(to: businessNameLabel)

        addressLabel.topToBottom(of: categoryLabel, offset: 4)
        addressLabel.leading(to: businessNameLabel)
        addressLabel.trailing(to: businessNameLabel)
        addressLabel.bottomToSuperview(offset: -8)
    }

    func set(_ business: Business) {
        let url = URL(string: business.imageURLString)
        businessImageView.kf.setImage(with: url)
        businessNameLabel.text = business.name
        ratingView.setRating(business.rating)
        ratingCountLabel.text = "\(business.reviewCount) reviews"
        categoryLabel.text = "\(business.price) ● \(business.categories.map { $0.title }.joined(separator: ", "))"
        addressLabel.text = business.location?.displayAddress.joined(separator: ", ")
    }
}
