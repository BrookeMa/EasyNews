//
//  TopHeadlineWithoutImageCollectionViewCell.swift
//  EasyNews
//
//  Created by Ye Ma on 18/02/2023.
//

import UIKit

public final class TopHeadlineWithoutImageCollectionViewCell: UICollectionViewCell {
    
    private(set) public lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        contentView.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 18),
            label.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            label.leftAnchor.constraint(equalTo: contentView.leftAnchor),
        ])
        
        return label
    } ()
    
    private(set) public lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkText
        contentView.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 18),
            label.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            label.leftAnchor.constraint(equalTo: contentView.leftAnchor),
        ])
        return label
    } ()

    private(set) public lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        contentView.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: 18),
            label.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            label.leftAnchor.constraint(equalTo: contentView.leftAnchor),
        ])
        return label
    } ()
}
