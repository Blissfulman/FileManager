//
//  DirectoryViewController.swift
//  FileManager
//
//  Created by User on 01.01.2021.
//

import UIKit

final class DirectoryViewController: UITableViewController {
    
    // MARK: - Properties
    var directory: Directory!
    
    private let fileManagerService = FileManagerService()
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if directory == nil {
            directory = Directory.getDirectory()
        }
        directory = directory.sortedObjects().filteredHiddenFiles()
        
        setupUI()
    }
    
    // MARK: - Actions
    @objc private func addDirectoryButtonTapped() {
        showAlert(type: .directory) { directoryName in
            print(directoryName)
        }
    }
    
    @objc private func addFileButtonTapped() {
        showAlert(type: .file) { fileName in
            print(fileName)
        }
    }
    
    // MARK: - Private methods
    private func setupUI() {
        title = directory.name
        
        let addDirectoryBarButton = UIBarButtonItem(
            image: UIImage(named: "addDirectory"),
            style: .plain,
            target: self,
            action: #selector(addDirectoryButtonTapped)
        )
        
        let addFileBarButton = UIBarButtonItem(
            image: UIImage(named: "addFile"),
            style: .plain,
            target: self,
            action: #selector(addFileButtonTapped)
        )
        
        navigationItem.rightBarButtonItems = [addFileBarButton, addDirectoryBarButton]
    }
}

// MARK: - TableViewDataSource
extension DirectoryViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        directory.objectCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        var content = cell.defaultContentConfiguration()
        
        let object = directory.objects[indexPath.row]
        
        content.image = object.isDirectory
            ? UIImage(named: "directory")
            : UIImage(named: "file")
        
        content.text = object.name
        
        cell.contentConfiguration = content
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}

// MARK: - TableViewDelegate
extension DirectoryViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedObject = directory.objects[indexPath.row]
        
        // MARK: - Navigation
        if selectedObject.isDirectory {
            let openingDirectory = Directory.getDirectory(for: selectedObject.url)
            
            let selectedDirectoryVC = DirectoryViewController()
            selectedDirectoryVC.directory = openingDirectory
            
            navigationController?.pushViewController(selectedDirectoryVC, animated: true)
        } else {
            let openingFile = File(name: selectedObject.name,
                                   content: fileManagerService.readFile(url: selectedObject.url))
            
            let selectedFileVC = FileEditorViewController()
            selectedFileVC.file = openingFile
            
            navigationController?.pushViewController(selectedFileVC, animated: true)
        }
    }
}