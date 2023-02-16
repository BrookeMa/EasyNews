//
//  TopHeadlineViewController+TestHelpers.swift
//  EasyNewsTests
//
//  Created by Ye Ma on 12/02/2023.
//

import UIKit
import EasyNews

extension TopHeadlineViewController {
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

