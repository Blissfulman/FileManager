//
//  DirectoryViewController.swift
//  FileManager
//
//  Created by User on 01.01.2021.
//

import UIKit

final class DirectoryViewController: UITableViewController {
    
    // MARK: - Properties
    private var directory: Directory?
    
    private let fileManagerService = FileManagerService()
    
    // MARK: - Initializers
    init(_ directory: Directory? = nil) {
        self.directory = directory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateDirectory()
        setupUI()
    }
    
    // MARK: - Actions
    @objc private func addDirectoryButtonTapped() {
        showAlert(type: .directory) { [weak self] directoryName in
            
            guard let url = self?.directory?.url else { return }
            
            self?.fileManagerService.createDirectory(in: url, withName: directoryName)
            self?.updateDirectory()
            self?.tableView.reloadData()
        }
    }
    
    @objc private func addFileButtonTapped() {
        showAlert(type: .file) { [weak self] fileName in
            guard let url = self?.directory?.url else { return }
            
            self?.fileManagerService.writeFile(in: url, withName: fileName)
            self?.updateDirectory()
            self?.tableView.reloadData()
        }
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        title = directory?.name
        
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
    
    // MARK: - Private methods
    private func updateDirectory() {
        directory = Directory.getDirectory(for: directory?.url)
        directory = directory?.sortedObjects().filteredHiddenFiles()
    }
}

// MARK: - TableViewDataSource
extension DirectoryViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        directory?.objectCount ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        var content = cell.defaultContentConfiguration()
        
        guard let directory = directory else { return UITableViewCell() }
        
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
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard let directory = directory else { return }
        
        guard let url = directory.url else { return }

        let object = directory.objects[indexPath.row]
        
        if editingStyle == .delete {
            fileManagerService.deleteObject(in: url, withName: object.name)
            updateDirectory()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let directory = directory else { return }
        
        let selectedObject = directory.objects[indexPath.row]
        
        // MARK: - Navigation
        if selectedObject.isDirectory {
            let openingDirectory = Directory.getDirectory(for: selectedObject.url)
            
            let selectedDirectoryVC = DirectoryViewController(openingDirectory)
            
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
