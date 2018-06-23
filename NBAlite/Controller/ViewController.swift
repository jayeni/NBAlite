//
//  ViewController.swift
//  NBAlite
//
//  Created by Jeremiah Ayeni on 6/13/18.
//  Copyright © 2018 Jeremiah Ayeni. All rights reserved.
//

import UIKit
import Alamofire

class TeamVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
   
    var  selectedteam: Team?
    var Teams: [Team]?
    
    func fetchvid(){
        print("here")
        Alamofire.request("https://www.googleapis.com/youtube/v3/search", method: .get, parameters: ["part":"snippet","order":"viewCount","videoDefinition":"high","type":"video","q":"lebron","key":"AIzaSyA4RweMI9pQ0ZeyR1NJwTIBZkZB2e6h08k"], encoding: URLEncoding.default, headers: nil ).responseJSON(completionHandler: { (response) in
            
            if let JSON = response.result.value{
                
               
         
                if let dictionary = JSON as? [String: Any] {
                    
                    if let playlist = dictionary["items"] as? [Any]
                    {
                        for i in 0..<playlist.count {
                            print(playlist[i])
                        }
                    }
                }
                
            }
            
            
        })
    }
    
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
                teaml.rosterURL = dict["rosterURL"] as? String
                
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
      
        //fetchvid()
        
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

