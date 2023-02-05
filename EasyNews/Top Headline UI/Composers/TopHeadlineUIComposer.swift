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
    
    public static func topHeadlineComposedWith(articleLoader: ArticleLoader) {
        
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

