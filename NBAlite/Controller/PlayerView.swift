//
//  PlayerView.swift
//  NBAlite
//
//  Created by Jeremiah Ayeni on 6/16/18.
//  Copyright © 2018 Jeremiah Ayeni. All rights reserved.
//

import UIKit
import Alamofire

class PlayerView:UICollectionViewController, UICollectionViewDelegateFlowLayout{
    var selectedTeam: Team?
    var selectedPlayer: Player?
    
    var cellID = "ID"
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = selectedTeam?.Scolor
        navigationController?.navigationBar.barTintColor = selectedTeam?.Pcolor
        let image = selectedTeam?.cachImage?.object(forKey: selectedTeam?.picloc as! NSString) as! UIImage
        let imageV = UIImageView(image: selectedTeam?.cachImage?.object(forKey: selectedTeam?.picloc as! NSString) as! UIImage)
        
        let Width = self.navigationController?.navigationBar.frame.size.width
        let Hieght  = self.navigationController?.navigationBar.frame.size.height
        let BarX = Width! / 2 - image.size.width / 2
        let BarY = Hieght! / 2 - image.size.height / 2
        
        imageV.frame = CGRect(x: BarX, y: BarY, width: Width!, height: Hieght!)
        imageV.contentMode = .scaleAspectFit
        navigationItem.titleView = imageV
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
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedPlayer = selectedTeam?.playerRoster![indexPath.row]
        
        // fetchvid()
        
        let layout = UICollectionViewFlowLayout()
        let vV = VideoView(collectionViewLayout: layout)
        vV.selectedPlayer = selectedPlayer
        vV.selectedTeam = selectedTeam
        navigationController?.pushViewController( vV , animated: true)
        
    }
    func fetchvid(){
        
        let str = (selectedPlayer?.firstName)! + " " + (selectedPlayer?.surName)! + " nba hilights"
        Alamofire.request("https://www.googleapis.com/youtube/v3/search", method: .get, parameters: ["part":"snippet","order":"viewCount","type":"video","q":str,"key":"AIzaSyA4RweMI9pQ0ZeyR1NJwTIBZkZB2e6h08k"], encoding: URLEncoding.default, headers: nil ).responseJSON(completionHandler: { (response) in
            var vidl: [Video] = []
            if let JSON = response.result.value{
                
                
                
                if let dictionary = JSON as? [String: Any] {
                    
                    if let dict = dictionary["items"] as? [Any]
                    {
                        for i in 0..<dict.count {
                            
                            let vid = Video()
                            if let video = dict[i] as? [String: Any] {
                                // print(dict)
                                let v = video["id"]  as? [String: Any]
                                vid.vidID = v?["videoId"] as! String
                                // print(vid.vidID)
                                
                                
                                
                                if let thumbnails = video["snippet"] as? [String: Any]{
                                    
                                    let vth = thumbnails["thumbnails"]  as? [String: Any]
                                    let vquality = vth!["high"]  as? [String: Any]
                                    vid.thumbNail = vquality?["url"] as! String
                                    print(vid.thumbNail ?? "NA")
                                    
                                }
                                vidl.append(vid)
                                self.selectedPlayer?.videos.append(vid)
                            }
                            self.selectedPlayer?.videos.append(vid)
                            print(vidl.count)
                            //end of for
                        }
                        self.selectedPlayer?.videos = vidl
                        
                    }
                }
                
            }
            
            
        })
    }
    
}
