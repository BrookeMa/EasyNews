//
//  TopHeadlineWithoutImageViewCellController.swift
//  EasyNews
//
//  Created by Ye Ma on 18/02/2023.
//

import UIKit

final class TopHeadlineWithoutImageViewCellController {
    private let viewModel: ArticleViewModel<UIImage>
    private var cell: TopHeadlineWithoutImageCollectionViewCell?
    public let section: () -> Void
    
    init(viewModel: ArticleViewModel<UIImage>, section: @escaping () -> Void) {
        self.viewModel = viewModel
        self.section = section
    }
    
    func view(in collectionView: UICollectionView, cellForRowAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = binded(collectionView.dequeueResuableCell(for: indexPath))
        return cell
    }
    
    private func binded(_ cell: TopHeadlineWithoutImageCollectionViewCell) -> UICollectionViewCell {
        self.cell = cell
        
        cell.authorLabel.text = viewModel.author
        cell.descriptionLabel.text = viewModel.description
        cell.dateLabel.text = viewModel.date
        
        return cell
    }
    
    private func releaseCellForReuse() {
        cell = nil
    }
}
