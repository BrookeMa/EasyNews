//
//  TopHeadlineCollectionViewCell.swift
//  EasyNews
//
//  Created by Ye Ma on 04/02/2023.
//

import UIKit

final class TopHeadlineCollectionViewCell: UICollectionViewCell {
    private(set) public lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        contentView.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 90)
        ])
        
        return imageView
    } ()
    
    private(set) public lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        contentView.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 18),
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
