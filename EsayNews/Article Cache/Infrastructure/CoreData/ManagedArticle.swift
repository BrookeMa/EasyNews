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
    
    @NSManaged var cache: NSOrderedSet
}

extension ManagedArticle {
    static func items(from localArticle: [LocalArticle], in context: NSManagedObjectContext) -> NSOrderedSet {
        return NSOrderedSet(array: localArticle.map({ local in
            let managed = ManagedArticle(context: context)
            managed.author = local.author
            managed.title = local.title
            managed.desc = local.description
            managed.url = local.url
            managed.source = local.source
            managed.image = local.image
            managed.published_at = local.published_at
            return
        }))
    }
    
    var local: LocalArticle {
        return LocalArticle(author: author,
                            title: title,
                            description: description,
                            url: url,
                            source: source,
                            image: image,
                            published_at: published_at)
    }
}
