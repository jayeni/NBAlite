//
//  VideoSingleView.swift
//  NBAlite
//
//  Created by Jeremiah Ayeni on 6/22/18.
//  Copyright © 2018 Jeremiah Ayeni. All rights reserved.
//

import UIKit

class VideoSingleView:UICollectionViewController, UICollectionViewDelegateFlowLayout{
    var selectedVideo: Video?
    var cellID = "ID"
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let str = "https://www.youtube.com/embed/"+(selectedVideo?.vidID)!
        
        let url = URL(string: str)
        
        let webV:UIWebView = UIWebView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        
        
        self.view.addSubview(webV)
        webV.loadRequest(URLRequest(url: url!))
       
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width), height: 45)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(8,8,8,8)
    }
   
    
}


