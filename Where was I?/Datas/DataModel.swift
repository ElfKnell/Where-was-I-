//
//  DataModel.swift
//  Where was I?
//
//  Created by Andrii Kyrychenko on 14/06/2022.
//

import Foundation

class VisitedPoint {
    
    var latitude: String
    var longitude: String
    
    init(lat: String, long: String) {
        self.latitude = lat
        self.longitude = long
    }
}
