//
//  CoreDataStack.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 13.05.2021.
//

import CoreData
import Foundation

class CoreDataService {
    enum Constants {
        static let coreDataModelName = "CoreDataITunes"
        static let entityName = "ResultCoreDataModel"
    }

    let fileManagerService = FileManagerService()

    lazy var context: NSManagedObjectContext = {
        persistentContainer.viewContext
    }()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: Constants.coreDataModelName)
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func fetchResults(completion: @escaping ([ApiResult]?) -> Void) {
        let request = NSFetchRequest<ResultCoreDataModel>(entityName: Constants.entityName)

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
        guard let model = NSEntityDescription.insertNewObject(forEntityName: Constants.entityName,
                                                              into: context) as? ResultCoreDataModel else {
            return
        }
        convertApiResultToModel(apiResult: apiResult, model: model)
        saveContext()
    }

    private func convertApiResultToModel(apiResult: ApiResult, model: ResultCoreDataModel) {
        model.albumImageURL = apiResult.artworkUrl100
        model.albumName = apiResult.collectionName
        model.artistName = apiResult.artistName
        model.trackName = apiResult.trackName
        model.kind = apiResult.kind
        fileManagerService.saveFile(url: apiResult.previewUrl ?? "") { fileUrl in
            print("CORE DATA SAVED FILE AT PATH", fileUrl)
            model.previewPath = fileUrl
            self.saveContext()
        }
    }

    func saveFile(url: String, completion: @escaping ((_ filePath: String) -> Void)) {
        guard let url = URL(string: url) else {
            return
        }
        let fileManager = FileManager.default
        guard let documentsDirectoryURL = fileManager.urls(for: .documentDirectory,
                                                           in: .userDomainMask).first
        else {
            return
        }
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

    private func downloadFile(withUrl url: URL, andFilePath filePath: URL, completion: @escaping ((_ filePath: String) -> Void)) {
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

    func deleteAllResults() {
        fileManagerService.deleteDownloadedFiles()
        deleteEntityObjects()
    }

    private func deleteDownloadedFiles() {
        let fileManager = FileManager.default
        let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
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

    private func deleteEntityObjects() {
        let delAllReqVar = NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: Constants.entityName))
        do {
            try context.execute(delAllReqVar)
        } catch {}
        saveContext()
    }

    private func saveContext() {
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
