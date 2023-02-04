//
//  ArticleItemsMapper.swift
//  EasyNews
//
//  Created by Ye Ma on 08/01/2023.
//

import Foundation

final class ArticleItemsMapper {
    
    public enum Error: Swift.Error {
        case invalidData
    }
    
    private struct Root: Decodable {
        private let items: [RemoteArticleItem]
        
        private struct RemoteArticleItem: Decodable {
            let author: String?
            let title: String
            let description: String
            let url: URL
            let source: String
            let image: URL?
            let category: String
            let language: String
            let country: String
            let published_at: Date
        }
        
        var articles: [Article] {
            items.map {
                Article.init(author: $0.author,
                             title: $0.title,
                             description: $0.description,
                             url: $0.url,
                             source: $0.source,
                             image: $0.image,
                             published: $0.published_at) }
        }
    }
    
    private static var OK_200: Int { return 200 }
    
    static func map(_ data: Data, from response: HTTPURLResponse) throws -> [Article] {
        guard response.isOK, let root = try? JSONDecoder().decode(Root.self, from: data) else {
            throw Error.invalidData
        }
        return root.articles
    }
    
}
