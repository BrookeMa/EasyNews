//
//  TopHeadlineViewController.swift
//  EasyNews
//
//  Created by Ye Ma on 04/02/2023.
//

import UIKit

public final class TopHeadlineViewController: UICollectionViewController {
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        
        return refreshControl
    } ()
    
    var viewModel: TopHeadlineViewModel? {
        didSet {
            bind()
        }
    }
    
    var collectionModel = [TopHeadlineCellController]() {
        didSet { collectionView.reloadData() }
    }
    
    func bind() {
        viewModel?.onLoadingStateChange = { [weak self] isLoading in
            if isLoading {
                self?.refreshControl.beginRefreshing()
            } else {
                self?.refreshControl.endRefreshing()
            }
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        refresh()
    }
    
    private func refresh() {
        viewModel?.loadArticles()
    }
    
    public override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionModel.count
    }
    
    public override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    
    private func cellController(forRowAt indexPath: IndexPath) -> TopHeadlineCellController {
        return collectionModel[indexPath.row]
    }
}

 
