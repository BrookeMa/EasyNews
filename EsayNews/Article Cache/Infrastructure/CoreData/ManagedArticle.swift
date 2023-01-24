//
//  ManagedArticle.swift
//  EsayNews
//
//  Created by Ye Ma on 24/01/2023.
//

import CoreData

@objc(ManagedArticle)
class ManagedArticle: NSManagedObject {
    @NSManaged var author: String?
    @NSManaged var title: String
    @NSManaged var desc: String
    @NSManaged var url: URL
    @NSManaged var source: String
    @NSManaged var image: URL?
    @NSManaged var published_at: Date
}


