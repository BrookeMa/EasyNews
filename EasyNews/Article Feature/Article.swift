//
//  Article.swift
//  EasyNews
//
//  Created by Ye Ma on 08/01/2023.
//

import Foundation

public struct Article: Hashable {
    let author: String?
    let title: String
    let description: String
    let url: URL
    let source: String
    let image: URL?
    let published_at: Date
    
    init(author: String?, title: String, description: String, url: URL, source: String, image: URL?, published_at: Date) {
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.source = source
        self.image = image
        self.published_at = published_at
    }
}
