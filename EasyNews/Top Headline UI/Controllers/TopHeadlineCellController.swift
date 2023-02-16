//
//  TopHeadlineCellController.swift
//  EasyNews
//
//  Created by Ye Ma on 05/02/2023.
//

import UIKit

final class TopHeadlineCellController {
    private let viewModel: ArticleViewModel<UIImage>
    private var cell: TopHeadlineCollectionViewCell?
    public let selection: () -> Void
    
    init(viewModel: ArticleViewModel<UIImage>, selection: @escaping () -> Void) {
        self.viewModel = viewModel
        self.selection = selection
    }
    
    func view(in collectionView: UICollectionView, cellForRowAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = binded(collectionView.dequeueResuableCell(for: indexPath))
        viewModel.loadImageData()
        return cell
    }
    
    func preload() {
        viewModel.loadImageData()
    }
    
    func cancelLoad() {
        releaseCellForReuse()
        viewModel.cancelImageDataLoad()
    }
    
    private func binded(_ cell: TopHeadlineCollectionViewCell) -> UICollectionViewCell {
        self.cell = cell
        
        cell.authorLabel.text = viewModel.author
        cell.descriptionLabel.text = viewModel.description
        cell.dateLabel.text = viewModel.date
        viewModel.onImageLoad = { [weak self] image in
            self?.cell?.imageView.image = image
        }
        
        return cell
    }
    
    private func releaseCellForReuse() {
        cell = nil
    }
}
