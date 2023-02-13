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
}

