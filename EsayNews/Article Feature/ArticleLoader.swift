//
//  ArticleLoader.swift
//  EsayNews
//
//  Created by Ye Ma on 08/01/2023.
//

import Foundation
public protocol ArticleLoader {
    typealias Result = Swift.Result<[Article], Error>
    
    func load(completion: @escaping (Result) -> Void)
}
