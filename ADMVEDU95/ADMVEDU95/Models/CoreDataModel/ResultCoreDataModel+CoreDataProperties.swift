//
//  ResultCoreDataModel+CoreDataProperties.swift
//  
//
//  Created by Satishur, Oleg on 13.05.2021.
//
//

import Foundation
import CoreData


extension ResultCoreDataModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ResultCoreDataModel> {
        return NSFetchRequest<ResultCoreDataModel>(entityName: "ResultCoreDataModel")
    }

    @NSManaged public var albumImageURL: String?
    @NSManaged public var albumName: String?
    @NSManaged public var artistName: String?
    @NSManaged public var previewPath: String?
    @NSManaged public var trackName: String?
    @NSManaged public var kind: String?

    var model: ApiResult {
       get {
        return ApiResult(kind: self.kind, artistName: self.artistName, trackName: self.trackName, collectionName: self.albumName, artworkUrl100: self.albumImageURL, previewUrl: self.previewPath)
        }
     }
}
