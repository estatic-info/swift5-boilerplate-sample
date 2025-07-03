//
//  HomeViewController.swift
//  IOSNamingConvention
//
//  Created by theonetech on 30/07/20.
//  Copyright © 2020 theonetech. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var lblEmptyMessage: UILabel!
    @IBOutlet weak var collectionHomeMenu: UICollectionView!
    var arrHomeMenuItem = [HomeMenuItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
    }
    
    func initialize() {
        self.title = Navigation.home
        self.lblEmptyMessage.text = "Data not available!"
        let data = AppManager.readJSONFromFile(fileName: JSONFile.homeMenuItems)
        guard let homeMenuItem = data else { return }
        do {
            let homeMenuItems = try JSONDecoder().decode(HomeMenuItems.self, from: homeMenuItem)
            arrHomeMenuItem = homeMenuItems.homeMenuItems ?? [HomeMenuItem]()
        } catch let err {
            print("Err", err)
        }
        self.configureCollectionCell()
    }
    
    func configureCollectionCell() {
        self.collectionHomeMenu.register(UINib(nibName: Cell.HomeViewCell, bundle: nil), forCellWithReuseIdentifier: Cell.HomeViewCell)
        self.reloadCollectionView()
    }
    
    @IBAction func actionLogout(_ sender: UIButton) {
       AppManager.shared.logout()
    }
}

extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Collection view delegate & data source methods
    func reloadCollectionView() {
        DispatchQueue.main.async {
            self.lblEmptyMessage.isHidden = !self.arrHomeMenuItem.isEmpty
            self.collectionHomeMenu.reloadData()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrHomeMenuItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.HomeViewCell, for: indexPath) as? HomeViewCell {
            if self.arrHomeMenuItem.count > indexPath.row {
                let item = self.arrHomeMenuItem[indexPath.row]
                cell.homeMenuItem = item
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = 3
        let flowLayout : UICollectionViewFlowLayout = collectionViewLayout as? UICollectionViewFlowLayout ?? UICollectionViewFlowLayout()
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        let width = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       /// Add code after selection the cell in collectionview
        if indexPath.row == 0 {
            getAlbumList()
        } else {
            getHomeWorkList()
        }
    }
}
// MARK: Api Call
extension HomeViewController {
    /// Get Home Work List Api
    
    func getHomeWorkList() {
        let request : APIManager = .homeworks(pageNumber: -1, pageSize: 10)
        APIClient.requestObject(request, completion: { (response: HomeWorks) in
            print("Albums count",response.homeWorks?.count as Any)
            print(response.homeWorks?.first?.description ?? "")
           ProgressHUDManager.showKRProgressHUD(false)
        }) { (error) in
            AppManager.shared.showAlert(Title: MessageText.Text.error, Message: error ?? MessageText.Message.something_went_wrong, ButtonTitle: "Ok", ViewController: self)
        }
    }
    /// Get Album List Api
    func getAlbumList() {
        let request : APIManager = .albums(pageNumber: 1, pageSize: 10)
        APIClient.requestObject(request, completion: { (response: Albums) in
            print("Albums count",response.albums?.count as Any)
            print(response.albums?.first?.photoUrl ?? "")
           ProgressHUDManager.showKRProgressHUD(false)
        }) { (error) in
            AppManager.shared.showAlert(Title: MessageText.Text.error, Message: error ?? MessageText.Message.something_went_wrong, ButtonTitle: "Ok", ViewController: self)
        }
    }
}
