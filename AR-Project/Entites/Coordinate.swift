//
//  Coordinate.swift
//  AR-Project
//
//  Created by Yegor on 17.03.2022.
//

import Foundation

struct Coordinate: Hashable {
    
    var latitude: Double
    var longitude: Double
    
    static var placeholder: Self {
        return .init(latitude: 0.0, longitude: 0.0)
    }
}
