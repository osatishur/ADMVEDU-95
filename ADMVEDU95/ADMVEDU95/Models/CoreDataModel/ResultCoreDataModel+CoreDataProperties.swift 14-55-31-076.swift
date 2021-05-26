//
//  ResultCoreDataModel+CoreDataProperties.swift
//
//
//  Created by Satishur, Oleg on 13.05.2021.
//
//

import CoreData
import Foundation

public extension ResultCoreDataModel {
    @nonobjc
    class func fetchRequest() -> NSFetchRequest<ResultCoreDataModel> {
        NSFetchRequest<ResultCoreDataModel>(entityName: "ResultCoreDataModel")
    }

    @NSManaged var albumImageURL: String?
    @NSManaged var albumName: String?
    @NSManaged var artistName: String?
    @NSManaged var previewPath: String?
    @NSManaged var trackName: String?
    @NSManaged var kind: String?

    internal var model: ApiResult {
        ApiResult(kind: kind,
                  artistName: artistName,
                  trackName: trackName,
                  collectionName: albumName,
                  artworkUrl100: albumImageURL,
                  previewUrl: previewPath)
    }
}
