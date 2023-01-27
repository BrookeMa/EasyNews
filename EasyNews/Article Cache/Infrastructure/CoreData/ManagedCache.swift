//
//  ManagedCache.swift
//  EsayNews
//
//  Created by Ye Ma on 24/01/2023.
//

import CoreData

@objc(ManagedCache)
class ManagedCache: NSManagedObject {
    @NSManaged var timestamp: Date
    @NSManaged var article: NSOrderedSet
}
