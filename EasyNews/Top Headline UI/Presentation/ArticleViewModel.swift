//
//  ArticleViewModel.swift
//  EasyNews
//
//  Created by Ye Ma on 04/02/2023.
//

import Foundation
import EasyNewsFeature

final class ArticleViewModel<Image> {
    typealias Observer<T> = (T) -> Void
    
    private var task: ImageDataLoaderTask?
    private let model: Article
    private let imageTransformer: (Data) -> Image?
    private let imageLoader: ImageDataLoader
    
    init(model: Article, imageTransformer: @escaping (Data) -> Image?, imageLoader: ImageDataLoader) {
        self.model = model
        self.imageTransformer = imageTransformer
        self.imageLoader = imageLoader
    }
    
    var title: String {
        return Localized.TopHeadline.title
    }
    
    var author: String? {
        return model.author
    }
    
    var description: String? {
        return model.description
    }
    
    var onImageLoad: Observer<Image>?
    var onImageLoadingStateChange: Observer<Bool>?
    
    func loadImageData() {
        guard let url = model.image else { return }
        onImageLoadingStateChange?(true)
        
        task = imageLoader.loadImageData(from: url) { [weak self] result in
            self?.handle(result)
        }
    }
    
    private func handle(_ result: ImageDataLoader.Result) {
        if let image = (try? result.get()).flatMap(imageTransformer) {
            onImageLoad?(image)
        }
        onImageLoadingStateChange?(false)
    }
    
    func cancelImageDataLoad() {
        task?.cancel()
        task = nil
    }
}
