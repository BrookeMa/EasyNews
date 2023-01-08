//
//  ArticleItemsMapper.swift
//  EsayNews
//
//  Created by Ye Ma on 08/01/2023.
//

import Foundation

final class ArticleItemsMapper {
    
    public enum Error: Swift.Error {
        case invalidData
    }
    
    private struct Root: Decodable {
        let items: [RemoteArticleItem]
    }
    
    private static var OK_200: Int { return 200 }
    
    static func map(_ data: Data, from response: HTTPURLResponse) throws -> [RemoteArticleItem] {
        guard response.statusCode == OK_200, let root = try? JSONDecoder().decode(Root.self, from: data) else {
            throw Error.invalidData
        }
        return root.items
    }
    
}
