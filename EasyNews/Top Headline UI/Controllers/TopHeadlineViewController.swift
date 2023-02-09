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
       
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.collectionView.addSubview(refreshControl)
        
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
    
    @objc private func refresh() {
        viewModel?.loadArticles()
    }
    
    public override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            return TopHeadlineHeaderView()
        }
        return UICollectionReusableView()
    }
    
    public override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionModel.count
    }
    
    public override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    
    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return cellController(forRowAt: indexPath).view(in: collectionView, cellForRowAt: indexPath)
    }
    
    private func cellController(forRowAt indexPath: IndexPath) -> TopHeadlineCellController {
        return collectionModel[indexPath.row]
    }
    
    private func cancelCellControllerLoad(forRowAt indexPath: IndexPath) {
        cellController(forRowAt: indexPath).cancelLoad()
    }
}

 
