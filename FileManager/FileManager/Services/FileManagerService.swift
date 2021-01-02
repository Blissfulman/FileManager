//
//  FileManagerService.swift
//  FileManager
//
//  Created by User on 01.01.2021.
//

import Foundation

struct FileManagerService {
    
    // MARK: - Public methods
    func getRootURL() -> URL? {
        guard let url = FileManager.default.urls(for: .documentDirectory,
                                                 in: .userDomainMask).first else {
            return nil
        }
        return url
    }
    
    func getDirectoryContentURLs(in directory: URL) -> [URL]? {
        try? FileManager.default.contentsOfDirectory(
            at: directory,
            includingPropertiesForKeys: nil,
            options: []
        )
    }
    
    //    func writeFile(containing: String, withName name: String) {
    //        let filePath = (getURL()?.path)! + "/" + name
    //        let rawData: Data? = containing.data(using: .utf8)
    //        FileManager.default.createFile(atPath: filePath, contents: rawData, attributes: nil)
    //    }
    //
    //    func readFile(at path: String, withName name: String) {
    //        let filePath = (getURL()?.path)! + "/" + name
    //
    //        guard let fileContent = FileManager.default.contents(atPath: filePath),
    //              let fileContentEncoded = String(bytes: fileContent, encoding: .utf8) else {
    //            return
    //        }
    //
    //        print(fileContentEncoded)
    //    }
    //
    //    func deleteFile(withName name: String) {
    //        guard let filePath = getURL()?.appendingPathComponent(name) else {
    //            return
    //        }
    //        try? FileManager.default.removeItem(at: filePath)
    //    }
    //
    //    func renameFile(with oldName: String, to newName: String) {
    //        guard let oldPath = getURL()?.appendingPathComponent(oldName),
    //              let newPath = getURL()?.appendingPathComponent(newName) else {
    //            return
    //        }
    //        try? FileManager.default.moveItem(at: oldPath, to: newPath)
    //    }
}
