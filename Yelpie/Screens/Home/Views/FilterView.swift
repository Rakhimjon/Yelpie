//
//  FilterView.swift
//  Yelpie
//
//  Created by KhuongPham on 11/05/2022.
//

import Foundation
import UIKit
import RxCocoa
import TinyConstraints

final class FilterView: UIView {
    private let textField = TextField()
        .font(.medium(14))
        .placeholder("Search by name")
        .bgColor(.white).color(.darkText)

    private let filterButton = UIButton()
        .image(UIImage(named: "ic-filter"))
        .tintColor(.darkText)
        .imageEdgeInsets(.init(top: 6, left: 6, bottom: 6, right: 6))

    var onTextChange: ((String?) -> Void)?
    var onTapFilter: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupLayout()
        setupEvents()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        backgroundColor = .primaryColor
        textField.round(by: 4)

        if UIDevice.current.hasTopNotch {
            height(100)
        } else {
            height(80)
        }

        addSubviews(textField, filterButton)

        textField.edgesToSuperview(excluding: .top, insets: .bottom(10) + .horizontal(10))

        filterButton.centerY(to: textField)
        filterButton.trailing(to: textField, offset: -8)
        filterButton.width(36)
        filterButton.height(36)
    }

    private func setupEvents() {
        textField.rx.controlEvent(.editingChanged)
            .subscribe(onNext: { [unowned self] in
                onTextChange?(textField.text)
            })
            .disposed(by: rx.disposeBag)

        filterButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                onTapFilter?()
            })
            .disposed(by: rx.disposeBag)
    }
}
