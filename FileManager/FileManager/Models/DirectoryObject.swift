//
//  DirectoryObject.swift
//  FileManager
//
//  Created by User on 02.01.2021.
//

import Foundation

struct DirectoryObject {
    let name: String
    let url: URL
    
    var isDirectory: Bool {
        url.hasDirectoryPath
    }
}
