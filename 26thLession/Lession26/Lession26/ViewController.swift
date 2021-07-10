//
//  ViewController.swift
//  Lession26
//
//  Created by Иван Казанцев on 21.06.2021.
//

import UIKit

class ViewController: UIViewController {
    
    let dataService = DataStorageService()
    let something = Something(string: "blabla")
    let fileManager = FileManager.default
    let testString = "teststringteststringteststringteststringteststringteststringteststringteststringteststringteststringteststringteststringteststringteststringteststringteststringteststringteststringteststringteststringteststringteststringteststringteststringteststringteststringteststringteststringteststringteststringteststring"

    override func viewDidLoad() {
        super.viewDidLoad()
        dataService.save(object: something, for: "something")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let a = dataService.getObject(for: "something")
        print(a?.string)
        dataService.delete(for: "something")
        let b = dataService.getObject(for: "something")
        print(b?.string)
        
        guard let documentsUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        guard let applicationsUrl = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else { return }

        try! fileManager.createDirectory(at: applicationsUrl, withIntermediateDirectories: true, attributes: nil)
        
        let fileUrl = documentsUrl.appendingPathComponent("someText").appendingPathExtension("txt")
        let copiedFileUrl = applicationsUrl.appendingPathComponent("copiedSomeText").appendingPathExtension("txt")
        
        let result = fileManager.createFile(atPath: fileUrl.path,
                               contents: testString.data(using: .utf8),
                               attributes: nil)
        print(result)
        
        do {
            try fileManager.copyItem(at: fileUrl, to: copiedFileUrl)
        } catch {
            print(error.localizedDescription)
        }
    }


}

