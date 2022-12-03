//
//  Extensions.swift
//  MovieInfo
//
//  Created by Kevin Harijanto on 03/12/22.
//

import Foundation

extension Double {
    var threeDigits: Double {
        return (self * 1000).rounded(.toNearestOrEven) / 1000
    }
    
    var twoDigits: Double {
        return (self * 100).rounded(.toNearestOrEven) / 100
    }
    
    var oneDigit: Double {
        return (self * 10).rounded(.toNearestOrEven) / 10
    }
}
