//
//  TeamMenu.swift
//  NBAlite
//
//  Created by Jeremiah Ayeni on 6/18/18.
//  Copyright © 2018 Jeremiah Ayeni. All rights reserved.
//

import UIKit

class TeamMenu : UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var cellID = "cellId"
    var selectedTeam: Team?
    var menu = [Menu(name: "Scedule",image: "schedule"),Menu(name: "Roster",image: "clipboard")]
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.brown
        navigationItem.title = selectedTeam?.teamName
        collectionView?.register(MenuCell.self, forCellWithReuseIdentifier: cellID)
   
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as!MenuCell
        cell.menu = menu[indexPath.item]
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2;
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width/2)-16, height: 300)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(8,8,8,8)
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if menu[indexPath.row].name == "Roster"{
              let layout = UICollectionViewFlowLayout()
            let pW = PlayerView(collectionViewLayout: layout)
            navigationController?.pushViewController( pW , animated: true)
            
        }
        
    }
}
