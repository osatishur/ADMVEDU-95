//
//  FileManagerService.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 17.05.2021.
//

import Foundation

class FileManagerService {
    
    private var fileManager = FileManager.default
    
    func saveFile(url: String, completion: @escaping ((_ filePath: String) -> Void)) {
        guard let url = URL(string: url),
              let documentsDirectoryURL =  fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        let documentsPath = documentsDirectoryURL.appendingPathComponent(url.lastPathComponent)
        do {
            if try documentsPath.checkResourceIsReachable() {
                completion(documentsPath.absoluteString)
            } else {
                downloadFile(withUrl: url, andFilePath: documentsPath, completion: completion)
            }
        } catch {
            downloadFile(withUrl: url, andFilePath: documentsPath, completion: completion)
        }
    }
    
    func downloadFile(withUrl url: URL, andFilePath filePath: URL, completion: @escaping ((_ filePath: String) -> Void)){
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
        guard let documentsDirectoryURL =  fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        let documentsPath = documentsDirectoryURL.path
        do {
            let fileNames = try fileManager.contentsOfDirectory(atPath: "\(documentsPath)")
            print("all files in folder: \(fileNames)")
            for fileName in fileNames {
                let filePathName = "\(documentsPath)/\(fileName)"
                try fileManager.removeItem(atPath: filePathName)
            }
            
            let files = try fileManager.contentsOfDirectory(atPath: "\(documentsPath)")
            print("all files after deleting: \(files)")
            
        } catch {
            print("Could not clear folder: \(error)")
        }
    }
}
