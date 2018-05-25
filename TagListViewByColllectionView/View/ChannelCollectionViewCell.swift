//
//  ChannelCollectionViewCell.swift
//  TagListViewByColllectionView
//
//  Created by EthanLin on 2018/5/23.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class ChannelCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var channelNameLabel: UILabel!
    
    func updateUI(channel:String){
        self.channelNameLabel.text = channel
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
    }
    
    //讓Cell裡面隨著label的字多寡自適應
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        print("Cell自適應")
        let attributes = super.preferredLayoutAttributesFitting(layoutAttributes)
        attributes.frame = CGRect(x: 0, y: 0, width: NSString(string: channelNameLabel.text!).size(withAttributes: [kCTFontAttributeName as NSAttributedStringKey:channelNameLabel.font]).width+10, height: 40)
        return attributes
    }

    
    @IBAction func longPressGesture(_ sender: UILongPressGestureRecognizer) {
    }
    
}
