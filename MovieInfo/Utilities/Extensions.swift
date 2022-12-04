//
//  Extensions.swift
//  MovieInfo
//
//  Created by Kevin Harijanto on 03/12/22.
//

import Foundation

extension Double {
    var oneDigit: Double {
        return (self * 10).rounded(.toNearestOrEven) / 10
    }
}
