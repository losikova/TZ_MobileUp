//
//  PhotoViewController.swift
//  TZ_MobileUp
//
//  Created by Анастасия Лосикова on 3/27/22.
//

import UIKit

class PhotoViewController: UIViewController {

    @IBOutlet weak var mainPhotoCollectionView: UICollectionView!
    @IBOutlet weak var bottomPhotoCollectionView: UICollectionView!
    
    var photos = [Photo]()
    var selectedIndex = IndexPath()
    
    let titleView = UILabel()
    
    var photoImages = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainPhotoCollectionView.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.galleryCellIdentifier)
//        bottomPhotoCollectionView.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.galleryCellIdentifier)
        
        mainPhotoCollectionView.delegate = self
        mainPhotoCollectionView.dataSource = self
//        bottomPhotoCollectionView.delegate = self
//        bottomPhotoCollectionView.dataSource = self
        
        mainPhotoCollectionView.scrollToItem(at: selectedIndex, at: .centeredHorizontally, animated: false)
//        bottomPhotoCollectionView.scrollToItem(at: selectedIndex, at: .centeredHorizontally, animated: false)
        
        setupUI()
    }
    
    private func setupUI() {
        /// Title in navigation
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.font = UIFont(name: "SFProDisplay-Semibold", size: 18)
        navigationItem.titleView = titleView
        navigationItem.titleView?.heightAnchor.constraint(equalToConstant: 21).isActive = true
        
        /// Share Button
        let share = UIBarButtonItem(image: UIImage(named: "Vector"),
                                    style: .plain,
                                    target: self,
                                    action: #selector(shareTapped))
        share.width = 15.5
        navigationItem.rightBarButtonItem = share
        
        
//        /// Gesture Recognizer
//        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(swipe(_:)))
//        mainPhotoCollectionView.addGestureRecognizer(swipeGesture)
    }
    
    @objc func shareTapped() {
        var image = UIImage()
        DispatchQueue.main.async {[weak self] in
            guard let self = self else { return }
            image = self.getImage(at: self.selectedIndex, size: "w")
        }
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        activityViewController.excludedActivityTypes = [
            UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.airDrop,
            UIActivity.ActivityType.print,
            UIActivity.ActivityType.postToFacebook
        ]
        
        activityViewController.isModalInPresentation = true
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @objc func swipe(_ sender: UIPanGestureRecognizer) {
        
//        if sender.state == .ended {
//            mainPhotoCollectionView.scrollToItem(at: selectedIndex, at: .centeredHorizontally, animated: false)
        //        }
        //
        //        if sender.state == .began {
        //            mainPhotoCollectionView.isUserInteractionEnabled = true
        //        }
    }
    
    func getImage(at index: IndexPath, size: String) -> UIImage {
        var returnImage = UIImage()
        for photoSize in photos[index.item].sizes where photoSize.type == "w" {
            
            guard let url = URL(string: photoSize.url),
                  let imageData = try? Data(contentsOf: url),
                  let image = UIImage(data: imageData) else {
                //error
                continue
            }
            returnImage = image
        }
        return returnImage
    }
}

extension PhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mainPhotoCollectionView.dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.galleryCellIdentifier, for: indexPath) as! GalleryCollectionViewCell
        
        DispatchQueue.main.async {[weak self] in
            cell.photoImageView.image = self?.getImage(at: indexPath, size: "w")
        }
        
        let timeInterval = TimeInterval(photos[indexPath.item].date)
        let date = Date(timeIntervalSince1970: timeInterval)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM yyyy"
        titleView.text = dateFormatter.string(from: date)
        selectedIndex = indexPath
        return cell
    }
}

extension PhotoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = mainPhotoCollectionView.bounds.width
        return CGSize(width: width, height: width)
    }
}
