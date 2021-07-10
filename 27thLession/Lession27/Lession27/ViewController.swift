//
//  ViewController.swift
//  Lession27
//
//  Created by Иван Казанцев on 23.06.2021.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    private let stack = CoreDataStack.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        let context = stack.container.viewContext
        context.performAndWait {
            for index in 1...10 {
                let animal = MOAnimal(context: context)
                animal.name = "animal \(index)"
                animal.age = Int16(index * 2 / 3)
                animal.legs = Int16(index)
            }
            try? context.save()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let context = stack.container.viewContext
        context.performAndWait {
            let request = NSFetchRequest<MOAnimal>(entityName: "MOAnimal")
            let result = try? request.execute()
            result?.forEach {
                print($0.name)
                print($0.age)
                print($0.legs)
            }
        }
    }


}

