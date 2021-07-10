//
//  CoreDataStack.swift
//  Lession27
//
//  Created by Иван Казанцев on 23.06.2021.
//

import Foundation
import CoreData

final class CoreDataStack {
    
    static let shared = CoreDataStack()
    
    let container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Lession27")
        container.loadPersistentStores { desc, error in
            if let error = error {
                fatalError(error.localizedDescription)
            }
        }
        return container
    }()
    
    private init() {}
    
}
