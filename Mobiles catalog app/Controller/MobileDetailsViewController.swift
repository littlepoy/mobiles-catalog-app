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
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    //MARK: - configure
    private func configure() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
}

extension MobileDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView   .dequeueReusableCell(withReuseIdentifier: "MobileCollectionViewCell", for: indexPath) as! MobileCollectionViewCell
        return cell
    }
    
    
}
