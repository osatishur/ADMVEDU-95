//
//  FileManagerService.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 17.05.2021.
//

import Foundation

class FileManagerService {
    func saveFile(url: String, completion: @escaping ((_ filePath: String)->())) {
        guard let url = URL(string: url)  else {
            return
        }
        let fileManager = FileManager.default
        let documentsDirectoryURL =  fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let filePath = documentsDirectoryURL.appendingPathComponent(url.lastPathComponent)
        do {
            if try filePath.checkResourceIsReachable() {
                completion(filePath.absoluteString)
            } else {
                downloadFile(withUrl: url, andFilePath: filePath, completion: completion)
            }
        } catch {
            downloadFile(withUrl: url, andFilePath: filePath, completion: completion)
        }
    }
    
    func downloadFile(withUrl url: URL, andFilePath filePath: URL, completion: @escaping ((_ filePath: String)->())){
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try Data(contentsOf: url)
                try data.write(to: filePath, options: .atomic)
                print("saved at \(filePath.absoluteString)")
                DispatchQueue.main.async {
                    completion(filePath.absoluteString)
                }
            } catch {
                print("an error happened while downloading or saving the file")
            }
        }
    }
    
    func deleteDownloadedFiles() {
        let fileManager = FileManager.default
        let documentsDirectoryURL =  fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let documentsPath = documentsDirectoryURL?.path
        
        do {
            guard let documentPath = documentsPath else {
                return
            }
            let fileNames = try fileManager.contentsOfDirectory(atPath: "\(documentPath)")
            print("all files in folder: \(fileNames)")
            for fileName in fileNames {
                let filePathName = "\(documentPath)/\(fileName)"
                try fileManager.removeItem(atPath: filePathName)
            }
            
            let files = try fileManager.contentsOfDirectory(atPath: "\(documentPath)")
            print("all files after deleting: \(files)")
            
        } catch {
            print("Could not clear folder: \(error)")
        }
    }
}
