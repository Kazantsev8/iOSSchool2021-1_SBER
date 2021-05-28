//
//  ViewController.swift
//  14thLessionOnLession
//
//  Created by Иван Казанцев on 24.05.2021.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        let customCell = UINib(nibName: "CustomCell", bundle: nil)
        tableView.register(CustomCell.self, forCellReuseIdentifier: "CustomCell")
        tableViewConstraints()
        
    }
    
    func tableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return CustomCell()
    }
    
}


