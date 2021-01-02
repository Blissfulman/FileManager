//
//  FileEditorViewController.swift
//  FileManager
//
//  Created by User on 02.01.2021.
//

import UIKit

final class FileEditorViewController: UIViewController {

    // MARK: - IB Outlets
    @IBOutlet var textView: UITextView!
    
    // MARK: - Properties
    var file: File!
    
    private let fileManagerService = FileManagerService()
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        textView.text = file.content
    }
}
