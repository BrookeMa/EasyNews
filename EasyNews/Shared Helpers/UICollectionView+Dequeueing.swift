//
//  UICollectionView+Dequeueing.swift
//  EasyNews
//
//  Created by Ye Ma on 05/02/2023.
//

import UIKit

extension UICollectionView {
    func dequeueResuableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        let identifier = String(describing: T.self)
        return dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! T
    }
}
