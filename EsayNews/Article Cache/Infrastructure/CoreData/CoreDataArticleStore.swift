//
//  CoreDataArticleStore.swift
//  EsayNews
//
//  Created by Ye Ma on 24/01/2023.
//

import CoreData

public final class CoreDataArticleStore {
    private let container: NSPersistentContainer
    private let context: NSManagedObjectContext
    
    public init(storeURL: URL, bundle: Bundle = .main) throws {
        self.container = try NSPersistentContainer.load(modelName: "ArticleStore", url: storeURL, in: bundle)
        self.context = container.newBackgroundContext()
    }
}
