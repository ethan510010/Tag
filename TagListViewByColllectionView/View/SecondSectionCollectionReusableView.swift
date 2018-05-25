//
//  SecondSectionCollectionReusableView.swift
//  TagListViewByColllectionView
//
//  Created by EthanLin on 2018/5/23.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class SecondSectionCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet weak var headerNameLabel: UILabel!
    
    func updateUI(secondHeader:String){
        self.headerNameLabel.text = secondHeader
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
