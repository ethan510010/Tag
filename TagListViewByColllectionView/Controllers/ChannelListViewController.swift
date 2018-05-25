//
//  ChannelListViewController.swift
//  TagListViewByColllectionView
//
//  Created by EthanLin on 2018/5/23.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

enum SectionName:Int{
    case 我的頻道
    case 更多頻道
}

protocol PassSelectedChannelDelegate {
    func passSelectedChannel(channel:String)
}

class ChannelListViewController: UIViewController {

    var delegate:PassSelectedChannelDelegate?
    
    var myChannels = ["推薦","餐廳","運動","任何你想新增的東西","攝影","影音","語言","其他","程式","廚藝"]
    var morechannels = ["電影","科技","美食","叫車"]
    let collectionViewHeaderTitle = [["我的頻道","更多頻道"],["拖動更改頻道順序","點擊添加頻道"]]
    
    var widthDataForMyChannels: [CGFloat] = []
    var widthDataForMoreChannels: [CGFloat] = []
    
    var isEditingMode:Bool = false{
        didSet{
            channelCollectionView.reloadData()
        }
    }
    
    @IBOutlet weak var channelCollectionView: UICollectionView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewDidLoad")
        self.navigationItem.title = "頻道管理"
        channelCollectionView.delegate = self
        channelCollectionView.dataSource = self
        let secondHeaderNib = UINib(nibName: "SecondSectionCollectionReusableView", bundle: nil)
        channelCollectionView.register(secondHeaderNib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: CollectionIDManager.moreChannelHeader)
       
        channelCollectionView.collectionViewLayout = ChannelViewLayout()
        
        
    }
    
  
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("ViewDidLayoutSubView")
        
        self.channelCollectionView.collectionViewLayout = ChannelViewLayout()
//        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
//
//        collectionViewFlowLayout.minimumInteritemSpacing = 5
//        collectionViewFlowLayout.minimumLineSpacing = 5
//        collectionViewFlowLayout.estimatedItemSize = CGSize(width: 10, height: 10)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
extension ChannelListViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case SectionName.我的頻道.rawValue:
            if isEditingMode{
                let selectedMyChannelItem = myChannels[indexPath.item]
                myChannels.remove(at: indexPath.item)
                morechannels.append(selectedMyChannelItem)
                collectionView.moveItem(at: indexPath, to: IndexPath(item: morechannels.count-1, section: SectionName.更多頻道.rawValue))
                UserDefaults.standard.setValue(myChannels, forKeyPath: "myChannels")
            }else{
                delegate?.passSelectedChannel(channel: myChannels[indexPath.item])
                self.navigationController?.popViewController(animated: true)
            }
        case SectionName.更多頻道.rawValue:
            if isEditingMode{
                let selectedMoreChannelItem = morechannels[indexPath.item]
                morechannels.remove(at: indexPath.item)
                myChannels.append(selectedMoreChannelItem)
                collectionView.moveItem(at: indexPath, to: IndexPath(item: myChannels.count-1, section: SectionName.我的頻道.rawValue))
                UserDefaults.standard.setValue(morechannels, forKeyPath: "moreChannels")
            }
        default:
            break
        }
    }
    
    
}
extension ChannelListViewController: UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case SectionName.我的頻道.rawValue:
            return myChannels.count
        case SectionName.更多頻道.rawValue:
            return morechannels.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("Cell開始出現")
        switch indexPath.section {
        case SectionName.我的頻道.rawValue:
            let myChannelCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionIDManager.channelCell, for: indexPath) as! ChannelCollectionViewCell
            myChannelCell.updateUI(channel: myChannels[indexPath.item])
            return myChannelCell
        case SectionName.更多頻道.rawValue:
            let moreChannelCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionIDManager.channelCell, for: indexPath) as! ChannelCollectionViewCell
            moreChannelCell.updateUI(channel: morechannels[indexPath.item])
            return moreChannelCell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        print("Header出現")
        switch indexPath.section {
        case SectionName.我的頻道.rawValue:
            let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: CollectionIDManager.channelHeader, for: indexPath) as! FirstHeaderCollectionReusableView
            reusableView.delegate = self
            if self.isEditingMode{
                reusableView.updateUI(header: collectionViewHeaderTitle[1][indexPath.section])
            }else{
                reusableView.updateUI(header: collectionViewHeaderTitle[0][indexPath.section])
            }
            return reusableView
        case SectionName.更多頻道.rawValue:
            
            let secondReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: CollectionIDManager.moreChannelHeader, for: indexPath) as! SecondSectionCollectionReusableView
            if self.isEditingMode{
                secondReusableView.updateUI(secondHeader: collectionViewHeaderTitle[1][indexPath.section])
            }else{
                secondReusableView.updateUI(secondHeader: collectionViewHeaderTitle[0][indexPath.section])
            }
            return secondReusableView
        default:
            return UICollectionReusableView()
        }
    }
    
    
}
extension ChannelListViewController: EditButtonDidTappedDelegate{
    func editButtonTapped(isEditing: Bool) {
        self.isEditingMode = isEditing
    } 
}

class ChannelViewLayout:UICollectionViewFlowLayout{
    override func prepare() {
        super.prepare()
        print("FlowLayout出現")
//        estimatedItemSize = CGSize(width: 10, height: 10)
        headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 50)
        sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        minimumLineSpacing = 5
        minimumInteritemSpacing = 5

    }
}

