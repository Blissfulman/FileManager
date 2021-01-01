//
//  MainViewController.swift
//  FileManager
//
//  Created by User on 01.01.2021.
//

import UIKit

final class MainViewController: UITableViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Documents"
    }
}

extension MainViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)

        var content = cell.defaultContentConfiguration()
//        content.directionalLayoutMargins = .init(top: 0, leading: 0, bottom: 1, trailing: 0)
        
        content.text = "Cell \(indexPath.row)"
        
        cell.contentConfiguration = content
        return cell
    }
}
