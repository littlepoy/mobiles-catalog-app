//
//  ViewController.swift
//  Mobiles catalog app
//
//  Created by Little Poy on 29/12/2562 BE.
//  Copyright © 2562 littlepoy. All rights reserved.
//

import UIKit

class MobileListViewController: UIViewController {
    
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var sortButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    private var mobileList = [MobileList]()
    private let apiClient = ApiClient()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        requestData()
    }
    
    //MARK: - configure
    private func configure() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MobileListViewCell", bundle: nil), forCellReuseIdentifier: "MobileListViewCell")
    }
    
    //MARK: - request data
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
    
    //MARK: - sort button TouchUp
    @IBAction func sortButtonTouchUp(_ sender: UIBarButtonItem) {
        print("touch sort")
        showSortAlert()
    }
    
    //MARK: - show sort alert
    private func showSortAlert() {
        let alert = UIAlertController(title: "Sort", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Price low to high", style: .default, handler: { (action: UIAlertAction!) in
            print("low to high")
        }))
        alert.addAction(UIAlertAction(title: "Price high to low", style: .default, handler: { (action: UIAlertAction!) in
            print("high to low")
        }))
        alert.addAction(UIAlertAction(title: "Rating", style: .default, handler: { (action: UIAlertAction!) in
            print("rating")
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    //MARK: - segment Value Changed
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        if segment.selectedSegmentIndex == 0 {
            print("seg 1")
        } else if segment.selectedSegmentIndex == 1 {
            print("seg 2")
        }
    }
}

//MARK: - extension UITableViewDelegate UITableViewDataSource
extension MobileListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mobileList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MobileListViewCell") as! MobileListViewCell
        if (mobileList.count > 0) {
            let mobile = mobileList[indexPath.row]
            //
            cell.titleLabel.text = mobile.name
            cell.descriptionLabel.text = mobile.description
            cell.mobileImage.getImageFromWeb(imageUrlString: mobile.thumbImageURL)
            cell.priceLabel.priceFormat(price: mobile.price)
            cell.ratingLabel.ratingFormat(rating: mobile.rating)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("row", indexPath.row)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "mobileDetailsView")
        self.navigationController!.pushViewController(vc, animated: true)
    }
}

