//
//  TopHeadlineViewController+TestHelpers.swift
//  EasyNewsTests
//
//  Created by Ye Ma on 12/02/2023.
//

import UIKit
import EasyNews

extension TopHeadlineViewController {
    
    @discardableResult
    func simulateArticleImageViewVisible(at index: Int) -> TopHeadlineCollectionViewCell? {
        return articleView(at: index) as? TopHeadlineCollectionViewCell
    }
    
    @discardableResult
    func simulateArticleWithouImageVIewVisiblbe(at index: Int) -> TopHeadlineWithoutImageCollectionViewCell? {
        return articleView(at: index) as? TopHeadlineWithoutImageCollectionViewCell
    }
    
    @discardableResult
    func simulateArticleImageViewNotVisble(at row: Int) -> TopHeadlineCollectionViewCell? {
        let view = simulateArticleImageViewVisible(at: row)
        
        let delegate = collectionView.delegate
        let index = IndexPath(row: row, section: articlesSection)
        delegate?.collectionView?(collectionView, didEndDisplaying: view!, forItemAt: index)
        
        return view
    }
    
    func simulateUserInitiatedArticlesReload() {
        refreshControl.simulatePullToRefresh()
    }
    
    var isShowingLoadingIndicator: Bool  {
        return refreshControl.isRefreshing == true
    }
    
    func numberOfRenderedArticleViews() -> Int {
        return collectionView.numberOfItems(inSection: articlesSection)
    }
    
    func articleView(at row: Int) -> UICollectionViewCell? {
        let ds = collectionView.dataSource
        let index = IndexPath(row: row, section: articlesSection)
        return ds?.collectionView(collectionView, cellForItemAt: index)
    }
    
    var articlesSection: Int {
        return 0
    }
}

