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
         fetchPlayers()
   
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
    func fetchPlayers(){
        
       
        let jsonurl = selectedTeam?.rosterURL
       
        guard let url = URL(string: jsonurl!) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {return}
           // let dstr = String(data: data, encoding: .utf8 )
            do{
                
                let data = try Data(contentsOf: url)
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)

                self.selectedTeam?.playerRoster = [Player]()
                //print(json)
                for dict in json as! [[String: AnyObject]] {
                    
                    let playerl = Player()
                    let fullName = dict["name"] as? String ?? "N/A"
                    let fullNameArr = fullName.components(separatedBy: " ")
                    playerl.firstName = fullNameArr[0]
                    playerl.surName = ""
                    var count = 1
                    while count != fullNameArr.count {
                        playerl.surName?.append(fullNameArr[count])
                        count = count + 1
                        if count != fullNameArr.count {
                            playerl.surName?.append(" ")
                        }
                        self.selectedTeam?.playerRoster?.append(playerl)
                    }

                    playerl.picUrl = "https://nba-players.herokuapp.com/players/"
                    
                    let surname = playerl.surName?.replacingOccurrences(of: " ", with: "_")
                    playerl.picUrl?.append(surname ?? "N/A")
                    playerl.picUrl?.append("/")
                    playerl.picUrl?.append(playerl.firstName ?? "N/A")
                
            }       
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
                }catch{}
            
       
            
        }.resume()
        
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if menu[indexPath.row].name == "Roster"{
           
            let layout = UICollectionViewFlowLayout()
            let pV = PlayerView(collectionViewLayout: layout)
            pV.selectedTeam = selectedTeam
            navigationController?.pushViewController( pV , animated: true)
            
        }
        
    }


}
