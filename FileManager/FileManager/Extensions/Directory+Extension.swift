//
//  Directory+Extension.swift
//  FileManager
//
//  Created by User on 02.01.2021.
//

import Foundation

extension Directory {
    
    mutating func sortedObjects() -> Directory {
        var sortedObjects = [DirectoryObject]()
        
        sortedObjects.append(
            contentsOf: self.objects
                .filter { $0.isDirectory }
                .sorted { $0.name < $1.name }
        )
        sortedObjects.append(
            contentsOf: self.objects
                .filter { !$0.isDirectory }
                .sorted { $0.name < $1.name }
        )
        
        return Directory(name: self.name,
                         url: self.url,
                         objects: sortedObjects)
    }
    
    mutating func filteredHiddenFiles() -> Directory {
        let filteredObjects = self.objects.filter { $0.url.lastPathComponent.first != "." }

        return Directory(name: self.name,
                         url: self.url,
                         objects: filteredObjects)
        
    }
}
