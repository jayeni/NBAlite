//
//  VideoView.swift
//  NBAlite
//
//  Created by Jeremiah Ayeni on 6/22/18.
//  Copyright © 2018 Jeremiah Ayeni. All rights reserved.
//

import UIKit
import AVKit


class VideoView:UICollectionViewController, UICollectionViewDelegateFlowLayout{
    var selectedPlayer: Player?
    var selectedVideo: Video?
    var cellID = "ID"
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.brown
        navigationItem.title = ((selectedPlayer?.firstName)!+" "+(selectedPlayer?.surName)!)
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: cellID)
        
       
        
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as!VideoCell
        cell.video = selectedPlayer?.videos[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print( selectedPlayer?.videos.count)
        return selectedPlayer?.videos.count ?? 0;
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width/2)-16, height: 190)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(8,8,8,8)
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let layout = UICollectionViewFlowLayout()
        let vsV = VideoSingleView(collectionViewLayout: layout)
        selectedVideo = selectedPlayer?.videos[indexPath.row]
        vsV.selectedVideo = selectedVideo
        navigationController?.pushViewController( vsV , animated: true)
 
    
   
}

}
