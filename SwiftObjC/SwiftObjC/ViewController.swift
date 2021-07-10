//
//  ViewController.swift
//  SwiftObjC
//
//  Created by Иван Казанцев on 05.07.2021.
//

import UIKit
import ObjcLibraryModule
import SwiftStaticLibrary


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //objc
        let objc = ObjcLibrary()
        let anotherLib = objc.anotherLib
        //swift
        let swiftLib = SwiftStaticLibrary()
        let anotherSwiftLib = swiftLib.createAnotherLibrary()
        
    }


}

