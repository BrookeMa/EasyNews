//
//  TopHeadlineViewController.swift
//  EasyNews
//
//  Created by Ye Ma on 04/02/2023.
//

import UIKit

final class TopHeadlineViewController: UICollectionViewController {
    
    var viewModel: TopHeadlineViewMode? {
        didSet {
            bind()
        }
    }
    
    func bind() {
        
    }
}

 
