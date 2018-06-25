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
    var menu = [Menu(name: "Scedule",image: "schedule"),Menu(name: "Roster",image: "roster")]
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = selectedTeam?.Scolor
        navigationController?.navigationBar.barTintColor = selectedTeam?.Pcolor
       
        collectionView?.register(MenuCell.self, forCellWithReuseIdentifier: cellID)
         fetchPlayers()
       // navigationItem.titleView
            let image = selectedTeam?.cachImage?.object(forKey: selectedTeam?.picloc as! NSString) as! UIImage
            let imageV = UIImageView(image: selectedTeam?.cachImage?.object(forKey: selectedTeam?.picloc as! NSString) as! UIImage)
        
        let Width = self.navigationController?.navigationBar.frame.size.width
        let Hieght  = self.navigationController?.navigationBar.frame.size.height
        let BarX = Width! / 2 - image.size.width / 2
        let BarY = Hieght! / 2 - image.size.height / 2
        
        imageV.frame = CGRect(x: BarX, y: BarY, width: Width!, height: Hieght!)
        imageV.contentMode = .scaleAspectFit
        navigationItem.titleView = imageV
        
        
   
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
        return CGSize(width: (view.frame.width)-20, height: 250-16)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10,10,10,10)
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
                        
                    }
                    self.selectedTeam?.playerRoster?.append(playerl)
                    playerl.picUrl = "https://nba-players.herokuapp.com/players/"
                    
                    var surname = playerl.surName?.replacingOccurrences(of: " ", with: "_")
                    surname = surname?.replacingOccurrences(of: ".", with: "")
                    surname = surname?.replacingOccurrences(of: "'", with: "")
                    var firstname = playerl.firstName?.replacingOccurrences(of: " ", with: "_")
                    firstname = firstname?.replacingOccurrences(of: ".", with: "")
                    firstname = firstname?.replacingOccurrences(of: "'", with: "")
                    
                    playerl.picUrl?.append(surname ?? "N/A")
                    playerl.picUrl?.append("/")
                    playerl.picUrl?.append(firstname ?? "N/A")
                
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
