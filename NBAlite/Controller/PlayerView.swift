//
//  PlayerView.swift
//  NBAlite
//
//  Created by Jeremiah Ayeni on 6/16/18.
//  Copyright © 2018 Jeremiah Ayeni. All rights reserved.
//

import UIKit

class PlayerView:UICollectionViewController, UICollectionViewDelegateFlowLayout{
    var selectedTeam: Team?
    var cellID = "ID"
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.brown
        navigationItem.title = (selectedTeam?.teamName)!
         collectionView?.register(PlayerCell.self, forCellWithReuseIdentifier: cellID)
        
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as!PlayerCell
        cell.player = selectedTeam?.playerRoster![indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedTeam?.playerRoster?.count ?? 0;
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width/2)-16, height: 100)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(8,8,8,8)
    }
  
}
