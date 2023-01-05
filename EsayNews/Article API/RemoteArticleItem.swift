//
//  RemoteArticleItem.swift
//  EsayNews
//
//  Created by Ye Ma on 05/01/2023.
//

import Foundation

struct RemoteArticleItem: Decodable {
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
