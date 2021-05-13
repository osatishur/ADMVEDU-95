//
//  CoreDataStack.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 13.05.2021.
//

import Foundation
import UIKit
import CoreData

class CoreDataStack {
    lazy var context: NSManagedObjectContext = {
        persistentContainer.viewContext
    }()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataITunes")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func fetchResults(completion: @escaping ([ApiResult]?) -> ()) {
        let request = NSFetchRequest<ResultCoreDataModel>(entityName: "ResultCoreDataModel")

        if let models = try? context.fetch(request) {
            var results: [ApiResult] = []
            for model in models {
                let result = model.model
                results.append(result)
            }
            completion(results)
        } else {
            completion(nil)
        }
    }

    func saveResult(apiResult: ApiResult) {
        let model = NSEntityDescription.insertNewObject(forEntityName: "ResultCoreDataModel", into: context) as! ResultCoreDataModel
        model.albumImageURL = apiResult.artworkUrl100
        model.albumName = apiResult.collectionName
        model.artistName = apiResult.artistName
        model.trackName = apiResult.trackName
        model.kind = apiResult.kind
        saveFile(url: apiResult.previewUrl ?? "") { fileUrl in
            print("CORE DATA SAVED FILE AT PATH", fileUrl)
            model.previewPath = fileUrl
            self.saveContext()
        }
        saveContext()
    }
    
    func saveFile(url: String, completion: @escaping ((_ filePath: String)->())) {
        if let url = URL(string: url) {
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
    
    func deleteAllResults(){
        let fileManager = FileManager.default
        let documentsDirectoryURL =  fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        
        let documentsPath = documentsDirectoryURL?.path
        do {
            if let documentPath = documentsPath
            {
                let fileNames = try fileManager.contentsOfDirectory(atPath: "\(documentPath)")
                print("all files in folder: \(fileNames)")
                for fileName in fileNames {
                    let filePathName = "\(documentPath)/\(fileName)"
                    try fileManager.removeItem(atPath: filePathName)
                }
                
                let files = try fileManager.contentsOfDirectory(atPath: "\(documentPath)")
                print("all files after deleting: \(files)")
            }
            
        } catch {
            print("Could not clear folder: \(error)")
        }
        
        let DelAllReqVar = NSBatchDeleteRequest(fetchRequest:  NSFetchRequest<NSFetchRequestResult>(entityName: "ResultCoreDataModel"))
        do {
            try context.execute(DelAllReqVar)
        }
        catch {
            print(error)
        }
    }
    
        func saveContext () {
            let context = persistentContainer.viewContext
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }
}
