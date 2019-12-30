//
//  MobileDetailsViewController.swift
//  Mobiles catalog app
//
//  Created by Little Poy on 30/12/2562 BE.
//  Copyright © 2562 littlepoy. All rights reserved.
//

import Foundation
import UIKit

class MobileDetailsViewController: UIViewController {
    
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    private let apiClient = ApiClient()
    private var mobileImages = [MobileImage]()
    
    var mobileDetail: MobileList? {
        didSet {
            guard let mobileDetail = mobileDetail else {
                return
            }
            
            requestData()
        }
    }
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    //MARK: - configure
    private func configure() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        if let mobileDetail = mobileDetail {
            self.ratingLabel.ratingFormat(rating: mobileDetail.rating)
            self.priceLabel.priceFormat(price: mobileDetail.price)
            self.descriptionLabel.text = mobileDetail.description
        }
    }
    
    //MARK: - request data
    private func requestData() {
        debugPrint("Fetching Image")
        apiClient.requestMobileImages (id: mobileDetail?.id, completion: { [weak self] (results, error) in
            guard let weakSelf = self else {
                return
            }
            guard let results = results else {
                debugPrint("Error : \(String(describing: error))")
                return
            }
            
            weakSelf.mobileImages = results
            
            weakSelf.collectionView.reloadData()
            debugPrint("Finished Fetch")
        })
    }
}

//MARK: - extension UICollectionViewDelegate UICollectionViewDataSource
extension MobileDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        mobileImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView   .dequeueReusableCell(withReuseIdentifier: "MobileCollectionViewCell", for: indexPath) as! MobileCollectionViewCell
        if (mobileImages.count > 0) {
            let mobileImage = mobileImages[indexPath.row]
            
            cell.imageMobile.getImageFromWeb(imageUrlString: mobileImage.imageURL)
        }
        return cell
    }
}
