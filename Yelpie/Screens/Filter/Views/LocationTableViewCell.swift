//
//  LocationTableViewCell.swift
//  Yelpie
//
//  Created by KhuongPham on 13/05/2022.
//

import Foundation
import UIKit
import Kingfisher
import TinyConstraints
import CoreLocation

final class LocationTableViewCell: UITableViewCell {
    private let nameLabel = UILabel()
        .font(.medium(14))
        .color(.darkText)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        contentView.addSubview(nameLabel)

        nameLabel.edgesToSuperview(insets: .horizontal(10) + .vertical(4))
    }

    func set(_ location: Location) {
        nameLabel.text = location.name
    }
}
