//
//  Extensions.swift
//  MovieInfo
//
//  Created by Kevin Harijanto on 03/12/22.
//

import Foundation
import UIKit

extension Double {
    var oneDigit: Double {
        return (self * 10).rounded(.toNearestOrEven) / 10
    }
}

extension UIView {
    func addGradientWithColor() {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [UIColor.clear.withAlphaComponent(0.0).cgColor,
                           UIColor.movieBlue.cgColor]
//        gradient.colors = [UIColor.red.cgColor,
//                           UIColor.red.cgColor]
        
        self.layer.insertSublayer(gradient, at: 0)
    }
}
