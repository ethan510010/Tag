//
//  ViewController.swift
//  TagListViewByColllectionView
//
//  Created by EthanLin on 2018/5/23.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class TopicViewController: UIViewController {
    
    @IBAction func pushToChannelListVC(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: SegueManager.performChannelList, sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueManager.performChannelList{
            guard let channelListVC = segue.destination as? ChannelListViewController else {return}
            channelListVC.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension TopicViewController: PassSelectedChannelDelegate{
    func passSelectedChannel(channel: String) {
        self.navigationItem.title = channel
    }
    
    
}
