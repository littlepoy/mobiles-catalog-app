//
//  ViewController.swift
//  Mobiles catalog app
//
//  Created by Little Poy on 29/12/2562 BE.
//  Copyright © 2562 littlepoy. All rights reserved.
//

import UIKit

class MobileListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var mobileList = [MobileList]()
    private let apiClient = ApiClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        requestData()
    }
    
    private func configure() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MobileListViewCell", bundle: nil), forCellReuseIdentifier: "MobileListViewCell")
    }
    
    private func requestData() {
        debugPrint("Fetching")
        apiClient.requestMobileList (completion: { [weak self] (results, error) in
            guard let weakSelf = self else {
                return
            }
            guard let results = results else {
                debugPrint("Error : \(String(describing: error))")
                return
            }
            
            print(type(of: results))
            print(results)
            
            weakSelf.mobileList = results
            
            
            weakSelf.tableView.reloadData()
            debugPrint("Finished Fetch")
        })
    }
}

extension MobileListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mobileList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MobileListViewCell") as! MobileListViewCell
        if (mobileList.count > 0) {
            let mobile = mobileList[indexPath.row]
            
            cell.titleLabel.text = mobile.name
            cell.descriptionLabel.text = mobile.description
            cell.mobileImage.getImageFromWeb(imageUrlString: mobile.thumbImageURL)
            cell.priceLabel.priceFormat(price: mobile.price)
            cell.ratingLabel.ratingFormat(rating: mobile.rating)
        }
        return cell
    }
    
    
}

