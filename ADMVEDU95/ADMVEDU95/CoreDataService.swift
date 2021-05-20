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

    private var fileManagerService = FileManagerService()

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

        guard let models = try? context.fetch(request) else {
            completion(nil)
            return
        }
        var results: [ApiResult] = []
        for model in models {
            let result = model.model
            results.append(result)
        }
        completion(results)
    }

    func saveResult(apiResult: ApiResult) {
        guard let model = NSEntityDescription.insertNewObject(forEntityName: Constants.entityName, into: context) as? ResultCoreDataModel else {
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

    func deleteAllResults(){
        fileManagerService.deleteDownloadedFiles()
        deleteEntityObjects()
    }

    private func deleteEntityObjects() {
        let delAllReqVar = NSBatchDeleteRequest(fetchRequest:  NSFetchRequest<NSFetchRequestResult>(entityName: "ResultCoreDataModel"))
        do {
            try context.execute(delAllReqVar)
        }
        catch {
        }
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
