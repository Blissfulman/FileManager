//
//  UIViewController+Extension.swift
//  FileManager
//
//  Created by User on 03.01.2021.
//

import UIKit

enum AlertType {
    case addDirectory
    case addFile
}

extension UIViewController {
    
    func showAlert(type: AlertType, completion: @escaping (String) -> Void) {
        let alertTitle = type == .addDirectory ? "Directory name" : "File name"
        
        let alertController = UIAlertController(title: alertTitle, message: nil, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let createAction = UIAlertAction(title: "Create", style: .default) { _ in
            let alertTextField = alertController.textFields?.first
            guard let name = alertTextField?.text else { return }
            completion(name)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(createAction)
        alertController.addTextField { _ in }
        
        present(alertController, animated: true)
    }
}
