//
//  ViewController.swift
//  NBAlite
//
//  Created by Jeremiah Ayeni on 6/13/18.
//  Copyright © 2018 Jeremiah Ayeni. All rights reserved.
//

import UIKit

class TeamVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
   
    var  selectedteam: Team?
    var Teams: [Team]?
    

    
    let cellID = "ID"
    func fetchTeams(){
        
        let path = Bundle.main.path(forResource: "Nba_logo", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        
        do{
            
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            
            self.Teams = [Team]()
            
            //print(json)
            for dict in json as! [[String: AnyObject]] {
                
                let teaml = Team()
                teaml.teamName = dict["name"] as? String
                teaml.teamLoc = dict["region"] as? String
                teaml.picloc = dict["imgURL"] as? String
                self.Teams?.append(teaml)
            }
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
            
            
            
            
            
        }catch{}
    
   
}
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
         fetchTeams()
        collectionView?.backgroundColor = UIColor.lightGray
        collectionView?.register(TeamCell.self, forCellWithReuseIdentifier: cellID)
        navigationItem.title = "Teams"
      
        
        
    }
 

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedteam = Teams![indexPath.row]
        let layout = UICollectionViewFlowLayout()
        let tM = TeamMenu(collectionViewLayout: layout)
        tM.selectedTeam = Teams![indexPath.row]
        navigationController?.pushViewController( tM , animated: true)
        
    }

    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let ccell=collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as!TeamCell
        ccell.team = Teams?[indexPath.item]
        return ccell
     }
   
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Teams?.count ?? 0;
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width/3)-16, height: 105)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(8,8,8,8)
    }
    

}

