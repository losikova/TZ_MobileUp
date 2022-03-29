//
//  PhotoViewController.swift
//  TZ_MobileUp
//
//  Created by Анастасия Лосикова on 3/27/22.
//

import UIKit

class PhotoViewController: UIViewController {
    
    @IBOutlet weak var mainPhotoView: UIImageView!
    @IBOutlet weak var bottomPhotoCollectionView: UICollectionView!
    
    var photos = [Photo]()
    var selectedIndex = IndexPath()
    
    let titleView = UILabel()
    let loadingView = LoadingView()
    
    var photoImages = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        bottomPhotoCollectionView.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.galleryCellIdentifier)
        
//        bottomPhotoCollectionView.delegate = self
//        bottomPhotoCollectionView.dataSource = self
        
//        bottomPhotoCollectionView.scrollToItem(at: selectedIndex, at: .centeredHorizontally, animated: false)
        
        setupUI()
    }
    
    private func setupUI() {
        mainPhotoView.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: mainPhotoView.topAnchor),
            loadingView.leftAnchor.constraint(equalTo: mainPhotoView.leftAnchor),
            loadingView.bottomAnchor.constraint(equalTo: mainPhotoView.bottomAnchor),
            loadingView.rightAnchor.constraint(equalTo: mainPhotoView.rightAnchor)
        ])
        loadingView.clipsToBounds = true
        loadingView.contentMode = .scaleAspectFill
        loadingView.backgroundColor = #colorLiteral(red: 0.9591494203, green: 0.9724681973, blue: 0.9908661246, alpha: 1)
        loadingView.animateLoading(.start)
        
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
        
        mainPhotoView.image = getImage(at: selectedIndex, size: "w")
        
        let timeInterval = TimeInterval(photos[selectedIndex.item].date)
        let date = Date(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM yyyy"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        titleView.text = dateFormatter.string(from: date)
    }
    
    @objc func shareTapped() {
        let image = self.getImage(at: self.selectedIndex, size: "w")
        
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        activityViewController.completionWithItemsHandler =  { activity, bool, _, error in
            if let _ = error {
                self.errorAlert(type: ApplicationErrors.photoSaveError)
            }
            
            if activity == .saveToCameraRoll {
                let alert = UIAlertController(title: "", message: "Фотография успешно сохранена", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ок", style: .default))
                self.present(alert, animated: true)
            }
        }
        
        activityViewController.isModalInPresentation = true
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func getImage(at index: IndexPath, size: String) -> UIImage {
        var returnImage = UIImage()
        for photoSize in photos[index.item].sizes where photoSize.type == size {
            
            guard let url = URL(string: photoSize.url),
                  let imageData = try? Data(contentsOf: url),
                  let image = UIImage(data: imageData) else {
                errorAlert(type: ApplicationErrors.dataError)
                continue
            }
            returnImage = image
        }
        loadingView.animateLoading(.stop)
        return returnImage
    }
}

//extension PhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        photos.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = mainPhotoCollectionView.dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.galleryCellIdentifier, for: indexPath) as! GalleryCollectionViewCell
//
//        DispatchQueue.main.async {[weak self] in
//            cell.photoImageView.image = self?.getImage(at: indexPath, size: "w")
//        }
//
//        let timeInterval = TimeInterval(photos[indexPath.item].date)
//        let date = Date(timeIntervalSince1970: timeInterval)
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "d MMMM yyyy"
//        titleView.text = dateFormatter.string(from: date)
//        selectedIndex = indexPath
//        return cell
//    }
//}
//
//extension PhotoViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = mainPhotoView.bounds.width
//        return CGSize(width: width, height: width)
//    }
//}
