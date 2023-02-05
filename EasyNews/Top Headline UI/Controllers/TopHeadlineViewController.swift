//
//  TopHeadlineViewController.swift
//  EasyNews
//
//  Created by Ye Ma on 04/02/2023.
//

import UIKit

final class TopHeadlineViewController: UICollectionViewController {
    
    var viewModel: TopHeadlineViewModel? {
        didSet {
            bind()
        }
    }
    
    func bind() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refresh()
    }
    
    private func refresh() {
        viewModel?.loadArticles()
    }
}

 
