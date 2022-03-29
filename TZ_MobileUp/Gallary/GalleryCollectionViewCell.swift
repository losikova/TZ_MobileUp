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
    let loadingView = LoadingView()
    
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
        
        contentView.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: contentView.topAnchor),
            loadingView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            loadingView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            loadingView.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
        loadingView.clipsToBounds = true
        loadingView.contentMode = .scaleAspectFill
        loadingView.backgroundColor = #colorLiteral(red: 0.9591494203, green: 0.9724681973, blue: 0.9908661246, alpha: 1)
        loadingView.animateLoading(.start)
    }
}
