//
//  TopHeadlineCollectionViewCell+TestHelpers.swift
//  EasyNewsTests
//
//  Created by Ye Ma on 01/03/2023.
//

import EasyNews
import Foundation

extension TopHeadlineCollectionViewCell {
    
    var isShowImageView: Bool {
        return !imageView.isHidden
    }
    
    var isShowingAuthor: Bool {
        return !authorLabel.isHidden
    }
    
    var isShowingDescription: Bool {
        return !descriptionLabel.isHidden
    }
    
    var isShowingDate: Bool {
        return !dateLabel.isHidden
    }
    
    var authorText: String? {
        return authorLabel.text
    }
    
    var descriptionText: String? {
        return descriptionLabel.text
    }
    
    var dateText: String? {
        return dateLabel.text
    }
    
    var renderedImage: Data? {
        return imageView.image?.pngData()
    }
}
