//
//  DataStorageService.swift
//  Lession26
//
//  Created by Иван Казанцев on 21.06.2021.
//

import Foundation

final class DataStorageService {
    
    let defaults: UserDefaults

    
    init(userDefaults: UserDefaults) {
        self.defaults = userDefaults
    }
    
    convenience init() {
        self.init(userDefaults: UserDefaults())
    }

    func save(object: Something, for key: String) {
        guard let data = try? NSKeyedArchiver.archivedData(withRootObject: object, requiringSecureCoding: true)
        else { return }
        defaults.setValue(data, forKey: key)
    }
    
    func getObject(for key: String) -> Something? {
        guard let data = defaults.data(forKey: key) else { return nil }
        return try? NSKeyedUnarchiver.unarchivedObject(ofClass: Something.self, from: data)
    }
    
    func delete(for key: String) {
        defaults.setValue(nil, forKey: key)
    }
}


