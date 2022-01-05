//
//  UIView+Gradient.swift
//  Mobile2YouChallenge
//
//  Created by Gabriel Souza de Araujo on 04/01/22.
//

import UIKit

extension UIView {
    func applyGradient(isVertical: Bool, colors: [UIColor]) {
        layer.sublayers?.filter({ $0 is CAGradientLayer }).forEach({ $0.removeFromSuperlayer() })
         
        let gradient = CAGradientLayer()
        gradient.colors = colors.map({ $0.cgColor })
        
        if isVertical {
            gradient.locations = [0.0, 1.0]
        } else {
            gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        }
        
        backgroundColor = .clear
        gradient.frame = bounds
        layer.insertSublayer(gradient, at: 0)
    }
}
