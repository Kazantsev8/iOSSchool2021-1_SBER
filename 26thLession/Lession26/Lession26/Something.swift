//
//  DataStorageService.swift
//  Lession26
//
//  Created by Иван Казанцев on 21.06.2021.
//

import Foundation

final class Something: NSObject, NSSecureCoding {
    
    var string: String

    static var supportsSecureCoding: Bool = true
    
    func encode(with coder: NSCoder) {
        coder.encode(string, forKey: "string")
    }
    
    init?(coder: NSCoder) {
        guard let string = coder.decodeObject(of: NSString.self, forKey: "string") as String?
        else { return nil }
        self.string = string
    }
    
    init(string: String) {
        self.string = string
    }
    
}
