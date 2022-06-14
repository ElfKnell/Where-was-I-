//
//  DataStore.swift
//  Where was I?
//
//  Created by Andrii Kyrychenko on 14/06/2022.
//

import Foundation

struct StorageKeys {
    static let storeLat = "storeLat"
    static let storeLong = "storeLong"
}

class DataStore {
    
    func getDefaults() -> UserDefaults {
        return UserDefaults.standard
    }
    
    func storeDatePoin (lanitude: String, longitude: String) {
        let def = getDefaults()
        
        def.setValue(lanitude, forKey: StorageKeys.storeLat)
        def.setValue(longitude, forKey: StorageKeys.storeLong)
        def.synchronize()
        
        print(lanitude + " : " + longitude)
    }
    
    func getLastLocation() -> VisitedPoint? {
        let defaults = getDefaults()
        
        guard let lat = defaults.string(forKey: StorageKeys.storeLat) else { return nil }
        guard let long = defaults.string(forKey: StorageKeys.storeLong) else { return nil }
        
        return VisitedPoint(lat: lat, long: long)
    }
}
