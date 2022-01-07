//
//  UIView+Gradient.swift
//  Mobile2YouChallenge
//
//  Created by Gabriel Souza de Araujo on 04/01/22.
//

import UIKit

extension UIView {
    func applyGradient(colors: [UIColor]) {
        layer.sublayers?.remove(at: 0)
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = colors.map({ $0.cgColor })

        layer.addSublayer(gradient)
    }
}
