//
//  TopHeadlineCellController.swift
//  EasyNews
//
//  Created by Ye Ma on 18/02/2023.
//

import UIKit

public protocol TopHeadlineCellController {
    var selection: () -> Void { get }
    func view(in collectionView: UICollectionView, cellForRowAt indexPath: IndexPath) -> UICollectionViewCell
    func preload()
    func cancelLoad()
}
