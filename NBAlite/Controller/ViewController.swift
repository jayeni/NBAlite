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
       
        Alamofire.request("https://www.googleapis.com/youtube/v3/search", method: .get, parameters: ["part":"snippet","order":"viewCount","videoDefinition":"high","type":"video","q":"lebron","key":"AIzaSyAVPp2_0J4hTPWSYxuoSu7IYLPNpgo0oWo"], encoding: URLEncoding.default, headers: nil ).responseJSON(completionHandler: { (response) in
            
            if let JSON = response.result.value{
                
               
         
                if let dictionary = JSON as? [String: Any] {
                    
                    if (dictionary["items"] as? [Any]) != nil
                    {
                      //  for i in 0..<playlist.count {
                            //print(playlist[i])
                       // }
                    }
                }
                
            }
            
            
        })
    }
    
    let cellID = "ID"
    
    

    func HextoColor(hex: String) -> UIColor? {
    
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    
                    }
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
                teaml.Pcolor =  HextoColor(hex: (dict["color1"] as? String)!)
                teaml.Scolor = HextoColor(hex: (dict["color2"] as? String)!)
                
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
        navigationController?.navigationBar.barTintColor = UIColor(red:0.00, green:0.42, blue:0.71, alpha:1.0)
        collectionView?.backgroundColor = UIColor(red:0.75, green:0.75, blue:0.76, alpha:1.0)
        collectionView?.register(TeamCell.self, forCellWithReuseIdentifier: cellID)
        let image = UIImage(named: "nbalogo")
        let imageV = UIImageView(image: image)
        
        let Width = self.navigationController?.navigationBar.frame.size.width
        let Hieght  = self.navigationController?.navigationBar.frame.size.height
        let BarX = Width! / 2 - (image?.size.width)! / 2
        let BarY = Hieght! / 2 - (image?.size.height)! / 2
        
        imageV.frame = CGRect(x: BarX, y: BarY, width: Width!, height: Hieght!)
        imageV.contentMode = .scaleAspectFit
        navigationItem.titleView = imageV
        navigationItem.titleView = imageV
    
      
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
        ccell.layer.cornerRadius = 10.0
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

