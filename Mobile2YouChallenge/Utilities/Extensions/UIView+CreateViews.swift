//
//  UIView+CreateViews.swift
//  Mobile2YouChallenge
//
//  Created by Gabriel Souza de Araujo on 05/01/22.
//

import UIKit

extension UIView {
    func createStackView(with views: [UIView], axis: NSLayoutConstraint.Axis) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.distribution = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 5
        views.forEach({stackView.addArrangedSubview($0)})
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }
}
