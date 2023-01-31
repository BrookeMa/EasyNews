//
//  LocalArticlesLoader.swift
//  EasyNews
//
//  Created by Ye Ma on 31/01/2023.
//

import Foundation

public final class LocalArticlesLoader {
    private let store: ArticleStore
    private let currentDate: () -> Date
    
    public init(store: ArticleStore, currentDate: @escaping () -> Date) {
        self.store = store
        self.currentDate = currentDate
    }
}


extension LocalArticlesLoader {
    public typealias SaveResult = Result<Void, Error>
    
    public func save(_ articles: [Article], completion: @escaping (SaveResult) -> Void) {
        store.deleteCachedArticle { [weak self] deletionResult in
            guard let self = self else { return }
            
            switch deletionResult {
            case .success:
                self.cache(articles, with: completion)
                
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    private func cache(_ articles: [Article], with completion: @escaping (SaveResult) -> Void) {
        store.insert(articles.toLocal(), timestamp: currentDate()) { [weak self] InsertionResult in
            guard self != nil else { return }
            
            completion(InsertionResult)
        }
    }
}

private extension Array where Element == Article {
    func toLocal() -> [LocalArticle] {
        return map { LocalArticle(author: $0.author, title: $0.title, description: $0.description, url: $0.url, source: $0.source, image: $0.image, published: $0.published) }
    }
}
