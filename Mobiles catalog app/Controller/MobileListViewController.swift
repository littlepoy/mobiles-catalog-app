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
    private var favoriteList = [MobileList]()
    
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
            
            weakSelf.mobileList = results
            
            weakSelf.tableView.reloadData()
            debugPrint("Finished Fetch")
        })
    }
    
    //MARK: - sort button TouchUp
    @IBAction func sortButtonTouchUp(_ sender: UIBarButtonItem) {
        showSortAlert()
    }
    
    //MARK: - show sort alert
    private func showSortAlert() {
        let alert = UIAlertController(title: Constants.String.sort, message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: Constants.String.priceLowToHigh, style: .default, handler: { (action: UIAlertAction!) in
            self.sortData(by: Constants.String.priceLowToHigh)
        }))
        alert.addAction(UIAlertAction(title: Constants.String.priceHighToLow, style: .default, handler: { (action: UIAlertAction!) in
            self.sortData(by: Constants.String.priceHighToLow)
        }))
        alert.addAction(UIAlertAction(title: Constants.String.rating, style: .default, handler: { (action: UIAlertAction!) in
            self.sortData(by: Constants.String.rating)
        }))
        alert.addAction(UIAlertAction(title: Constants.String.cancel, style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    //MARK: - sort data
    private func sortData(by: String) {
        switch by {
        case Constants.String.priceLowToHigh:
            self.mobileList = mobileList.sorted() { $0.price < $1.price }
            self.favoriteList = favoriteList.sorted() { $0.price < $1.price }
        case Constants.String.priceHighToLow:
            self.mobileList = mobileList.sorted() { $0.price > $1.price }
            self.favoriteList = favoriteList.sorted() { $0.price > $1.price }
        case Constants.String.rating:
            self.mobileList = mobileList.sorted() { $0.rating > $1.rating }
            self.favoriteList = favoriteList.sorted() { $0.rating > $1.rating }
        default:
            break
        }
        
        tableView.reloadData();
    }
    
    //MARK: - segment Value Changed
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }
}

//MARK: - extension UITableViewDelegate UITableViewDataSource
extension MobileListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segment.selectedSegmentIndex {
        case 0: return mobileList.count
        case 1: return favoriteList.count
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MobileListViewCell") as! MobileListViewCell
        
        if segment.selectedSegmentIndex == 0 {
            if (mobileList.count > 0) {
                let mobile = mobileList[indexPath.row]
                cell.favoriteButton.isHidden = false
                cell.favoriteButton.isSelected = favoriteList.contains(where: { $0.id == mobile.id })
                cell.titleLabel.text = mobile.name
                cell.descriptionLabel.text = mobile.description
                cell.mobileImage.getImageFromWeb(imageUrlString: mobile.thumbImageURL)
                cell.priceLabel.priceFormat(price: mobile.price)
                cell.ratingLabel.ratingFormat(rating: mobile.rating)
                cell.delegate = self
                cell.index = indexPath.row
            }
        } else if segment.selectedSegmentIndex == 1 {
            if (favoriteList.count > 0) {
                
                let favorite = favoriteList[indexPath.row]
                cell.favoriteButton.isHidden = true
                cell.titleLabel.text = favorite.name
                cell.descriptionLabel.text = favorite.description
                cell.mobileImage.getImageFromWeb(imageUrlString: favorite.thumbImageURL)
                cell.priceLabel.priceFormat(price: favorite.price)
                cell.ratingLabel.ratingFormat(rating: favorite.rating)
                cell.delegate = self
                cell.index = indexPath.row
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "mobileDetailsView") as! MobileDetailsViewController
        vc.mobileDetail = mobileList[indexPath.row]
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if segment.selectedSegmentIndex == 1 {
            return true
        } else {
            return false
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            favoriteList.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}

extension MobileListViewController : MobileListViewDelegate {
    func touchUpFavButton(index: Int) {
        if let indexElement = favoriteList.firstIndex(where: { $0.id == mobileList[index].id }) {
            favoriteList.remove(at: indexElement)
        } else {
            favoriteList.append(mobileList[index])
        }
    }
}
