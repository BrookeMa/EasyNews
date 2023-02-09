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
        private let data: [RemoteArticleItem]
        
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
            data.map {
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
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        guard response.isOK, let root = try? decoder.decode(Root.self, from: data) else {
            throw Error.invalidData
        }
        return root.articles
    }    
}
