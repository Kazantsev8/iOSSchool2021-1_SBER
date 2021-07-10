//
//  MOAnimal+CoreDataProperties.swift
//  Lession27
//
//  Created by Иван Казанцев on 23.06.2021.
//
//

import Foundation
import CoreData


extension MOAnimal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MOAnimal> {
        return NSFetchRequest<MOAnimal>(entityName: "MOAnimal")
    }

    @NSManaged public var age: Int16
    @NSManaged public var legs: Int16
    @NSManaged public var name: String?

}

extension MOAnimal : Identifiable {

}
