//
//  TopHeadlineUIComposer.swift
//  EasyNews
//
//  Created by Ye Ma on 04/02/2023.
//

import UIKit
import EasyNewsFeature

public final class TopHeadlineUIComposer {
    private init() {}
    
    public static func topHeadlineComposedWith(articleLoader: ArticleLoader, imageLoader: ImageDataLoader) -> TopHeadlineViewController {
        let topHeadlineViewModel = TopHeadlineViewModel(articleLoader: MainQueueDispatchDecorator(decoratee: articleLoader))
        
        let topHeadlineController = TopHeadlineViewController.makeWith(viewModel: topHeadlineViewModel)
        
        topHeadlineViewModel.onArticlesLoad = adaptArticleToCellControllers(forwardingTo: topHeadlineController, imageLoader: imageLoader)
        
        return topHeadlineController
    }
    
    private static func adaptArticleToCellControllers(forwardingTo controller: TopHeadlineViewController, imageLoader: ImageDataLoader) -> ([Article]) -> Void {
        return { [weak controller] article in
            controller?.collectionModel = article.map { model in
                TopHeadlineCellController(viewModel: ArticleViewModel(model: model, imageTransformer: UIImage.init, imageLoader: imageLoader))
            }
        }
    }
}

private extension TopHeadlineViewController {
    static func makeWith(viewModel: TopHeadlineViewModel) -> TopHeadlineViewController {
        let bundle = Bundle(for: TopHeadlineViewController.self)
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        let viewController = storyboard.instantiateInitialViewController() as! TopHeadlineViewController
        viewController.viewModel = viewModel
        return viewController
    }
}

