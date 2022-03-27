//
//  GalleryViewController.swift
//  TZ_MobileUp
//
//  Created by Анастасия Лосикова on 3/26/22.
//

import UIKit
import SwiftKeychainWrapper
import WebKit

class GalleryViewController: UIViewController {
    
    /// - parameter photos: Array of photos in gallry
    var photos = [String: UIImage]()
    var photosArray = [Photo]()
    
    let service = Service()
    
    /// - parameter galleryCollectionView: Main view in gallery
    let galleryCollectionView: UICollectionView = {
        let size = (UIScreen.main.bounds.width - 2) / 2
        let layout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 5, left: 3, bottom: 5, right: 3)
        layout.itemSize = CGSize(width: size, height: size)
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.service.getPhotos { [weak self] getPhotos in
            for photo in getPhotos {
                self?.photosArray.append(photo)
//                for photoSize in photo.sizes where photoSize.type == "r" {
//                    let url = URL(string: photoSize.url)!
//                    let imageData = try? Data(contentsOf: url)
//                    let onePhoto = UIImage(data: imageData!)
//
//                    self?.photos.append(onePhoto!)
                    
//                }
            }
            self?.galleryCollectionView.reloadData()
        }
        
        galleryCollectionView.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.galleryCellIdentifier)
        
        galleryCollectionView.delegate = self
        galleryCollectionView.dataSource = self
        
//        var photo = UIImage(named: "meryl")
//        photos.append(photo!)
//        photo = UIImage(named: "lana")
//        photos.append(photo!)
        
//        DispatchQueue.main.async {
        setupUI()
    }
    
    private func setupUI() {
        /// Main Gallery View setup
        view.addSubview(galleryCollectionView)
        galleryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            galleryCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            galleryCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            galleryCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            galleryCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        galleryCollectionView.clipsToBounds = true
        
        /// Title in navigation
        let titleView = UILabel()
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.text = "Mobile Up Gallery"
        titleView.font = UIFont(name: "SFProDisplay-Semibold", size: 18)
        navigationItem.titleView = titleView
        navigationItem.titleView?.heightAnchor.constraint(equalToConstant: 21).isActive = true
        
        let buttonLabel = UILabel()
        buttonLabel.text = "Выход"
        buttonLabel.font = UIFont(name: "SFProDisplay-Medium", size: 18)
        buttonLabel.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(exitButtonTapped))
        buttonLabel.addGestureRecognizer(tap)
        
        let exitButton = UIBarButtonItem()
        exitButton.customView = buttonLabel
        navigationItem.rightBarButtonItem = exitButton
        
        
    }
    
    @objc private func exitButtonTapped() {
        let alert = UIAlertController(title: "", message: "Вы уверены, что хотите выйти из аккаунта?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Да", style: .default) {[weak self] _ in
            KeychainWrapper.standard.removeObject(forKey: StringKeys.accessToken.rawValue)
            UserDefaults.standard.set(false, forKey: StringKeys.isAuthorized.rawValue)
            
            self?.dismiss(animated: true)
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            appDelegate?.isAithorized = false

        })
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .destructive))
        self.present(alert, animated: true)
    }
}

extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = galleryCollectionView.dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.galleryCellIdentifier, for: indexPath) as! GalleryCollectionViewCell
        
        for photoSize in photosArray[indexPath.item].sizes where photoSize.type == "q" {
            if photos[photoSize.url] == nil {
                guard let url = URL(string: photoSize.url),
                      let imageData = try? Data(contentsOf: url),
                      let image = UIImage(data: imageData) else {
                    //error
                    continue
                }
                
                photos[photoSize.url] = image
            }
            cell.photoImageView.image = photos[photoSize.url]
        }
        return cell
    }
    
}
