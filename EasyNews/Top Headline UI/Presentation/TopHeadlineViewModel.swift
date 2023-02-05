//
//  TopHeadlineViewModel.swift
//  EasyNews
//
//  Created by Ye Ma on 04/02/2023.
//

import Foundation
import EasyNewsFeature

final class TopHeadlineViewModel {
    typealias Observer<T> = (T) -> Void
    
    private let articleLoader: ArticleLoader
    
    init(articleLoader: ArticleLoader) {
        self.articleLoader = articleLoader
    }
    
    var onLoadingStateChange: Observer<Bool>?
    var onArticlesLoad: Observer<[Article]>?
    var onLoadError: Observer<String>?
    
    func loadArticles() {
        onLoadingStateChange?(true)
        articleLoader.load { [weak self] result in
            switch result {
            case let .success(articles):
                self?.onArticlesLoad?(articles)
            case .failure:
                self?.onLoadError?(Localized.TopHeadline.loadError)
            }
            self?.onLoadingStateChange?(false)
        }
    }
}
