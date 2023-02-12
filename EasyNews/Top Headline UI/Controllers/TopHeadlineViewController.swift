//
//  TopHeadlineViewController.swift
//  EasyNews
//
//  Created by Ye Ma on 04/02/2023.
//

import UIKit

public final class TopHeadlineViewController: UICollectionViewController, UICollectionViewDataSourcePrefetching {
    
    private(set) public lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
       
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.collectionView.addSubview(refreshControl)
        
        return refreshControl
    } ()
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.width / 2)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        return layout
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
        collectionView.collectionViewLayout = layout
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
        cancelCellControllerLoad(forRowAt: indexPath)
    }
    
    public override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cellController(forRowAt: indexPath).selection()
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
    
    // MARK: - UICollectionViewDataSourcePrefetching
    
    public func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { indexPath in
            cellController(forRowAt: indexPath).preload()
        }
    }
}
