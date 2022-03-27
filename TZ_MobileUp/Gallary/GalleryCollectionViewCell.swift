//
//  GalleryCollectionViewCell.swift
//  TZ_MobileUp
//
//  Created by Анастасия Лосикова on 3/27/22.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    
    /// - parameter photoImageView: Image View for photo in gallery
    let photoImageView = UIImageView()
    
    static let galleryCellIdentifier = "galleryCellIdentifier"
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        contentView.addSubview(photoImageView)
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            photoImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
        photoImageView.clipsToBounds = true
        photoImageView.contentMode = .scaleAspectFill
    }
}
