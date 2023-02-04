//
//  LocalArticle.swift
//  EasyNews
//
//  Created by Ye Ma on 25/01/2023.
//

import Foundation

public struct LocalArticle: Equatable {
    public let author: String?
    public let title: String
    public let description: String
    public let url: URL
    public let source: String
    public let image: URL?
    public let published: Date
    
    public init(author: String?, title: String, description: String, url: URL, source: String, image: URL?, published: Date) {
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.source = source
        self.image = image
        self.published = published
    }
}
