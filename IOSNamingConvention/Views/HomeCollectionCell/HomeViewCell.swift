//
//  HomeViewCell.swift
//  IOSNamingConvention
//
//  Created by Vivek Goswami on 8/12/20.
//  Copyright © 2020 theonetech. All rights reserved.
//

import UIKit

class HomeViewCell: UICollectionViewCell {

    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var viewMain: UIView!
    
    var no = ""
    
    var homeMenuItem : HomeMenuItem? {
        didSet {
            self.setup()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.updateThemeUI()
    }
    
    func updateThemeUI() {
        self.viewMain.cornerRadius = 20
    }
    
    func setup() {
        self.imgIcon.image = UIImage(named: self.homeMenuItem?.image ?? "ic_logo")
        self.labelTitle.text = self.homeMenuItem?.title
    }

}
