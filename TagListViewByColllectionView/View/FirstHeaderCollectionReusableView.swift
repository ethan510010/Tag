//
//  ChannelHeaderCollectionReusableView.swift
//  TagListViewByColllectionView
//
//  Created by EthanLin on 2018/5/23.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

protocol EditButtonDidTappedDelegate {
    func editButtonTapped(isEditing:Bool)
}

class FirstHeaderCollectionReusableView: UICollectionReusableView {
    
    var delegate:EditButtonDidTappedDelegate?
    var isEditing:Bool? = false
    
    @IBOutlet weak var editButton: UIButton!
    @IBAction func editButtonAction(_ sender: UIButton) {
        isEditing = !isEditing!
        delegate?.editButtonTapped(isEditing: isEditing!)
        if isEditing!{
            editButton.setTitle("完成", for: .normal)
        }else{
            editButton.setTitle("編輯", for: .normal)
        }
    }
    
    @IBOutlet weak var headerNameLabel: UILabel!
    
    func updateUI(header:String){
        editButton.layer.cornerRadius = 5
        editButton.layer.masksToBounds = true
        editButton.layer.borderColor = UIColor.black.cgColor
        editButton.layer.borderWidth = 2
        self.headerNameLabel.text = header
    }
}
