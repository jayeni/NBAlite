//
//  PlayerCell.swift
//  NBAlite
//
//  Created by Jeremiah Ayeni on 6/16/18.
//  Copyright © 2018 Jeremiah Ayeni. All rights reserved.
//

import UIKit
import Alamofire

class PlayerCell:  UICollectionViewCell{
    var player:Player?{
        didSet{
            Name.text = (player?.firstName)! + " " + (player?.surName)!
            setupImage()
            fetchvid()
            
        }
    }
    func fetchvid(){
        
        let str = Name.text! + " nba highlights"
        Alamofire.request("https://www.googleapis.com/youtube/v3/search", method: .get, parameters: ["part":"snippet","type":"video","q":str,"key":"AIzaSyA4RweMI9pQ0ZeyR1NJwTIBZkZB2e6h08k"], encoding: URLEncoding.default, headers: nil ).responseJSON(completionHandler: { (response) in
            var vidl: [Video] = []
            if let JSON = response.result.value{
                
                
                
                if let dictionary = JSON as? [String: Any] {
                    
                    if let dict = dictionary["items"] as? [Any]
                    {
                        for i in 0..<dict.count {
                            
                            let vid = Video()
                            if let video1 = dict[i] as? [String: Any] {
                                // print(dict)
                                let v = video1["id"]  as? [String: Any]
                                vid.vidID = v?["videoId"] as! String
                                // print(vid.vidID)
                                
                                
                                
                                if let thumbnails = video1["snippet"] as? [String: Any]{
                                    
                                    let vth = thumbnails["thumbnails"]  as? [String: Any]
                                    let vquality = vth!["high"]  as? [String: Any]
                                    vid.thumbNail = vquality?["url"] as! String
                                    print(vid.thumbNail ?? "NA")
                                    
                                }
                           
                                self.player?.videos.append(vid)

                            }
                            print(self.player?.videos.count)
                            //end of for
                            
                        }
                   
                        
                    }
                }
                
            }
            
            
        })
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupCell()
        
    }
    func setupImage(){
        if let imageurl = player?.picUrl{
            
            let url = URL(string: imageurl)
            
            URLSession.shared.dataTask(with: url!){ (data, response, error) in
                
                if error != nil {
                    return
                }
                DispatchQueue.main.async {
                    self.picURL.image = UIImage(data: data!)
                }
                
                
                }.resume()
            
            
        }
    }

    func setupCell(){
        self.backgroundColor=UIColor.darkGray
        addSubview(Name)
        addSubview(picURL)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat:"H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : Name]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat:"H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : picURL]))
    
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat:"V:|[v1(75)][v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" :  Name, "v1" : picURL]))
        
        
    }
    let Name: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text="TEXT"
        nameLabel.textColor = UIColor.white
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        nameLabel.translatesAutoresizingMaskIntoConstraints=false
        return nameLabel
        
    }()
    
    let picURL: UIImageView = {
        let iV = UIImageView()
        
        iV.contentMode = .scaleAspectFit
        iV.translatesAutoresizingMaskIntoConstraints=false;
        
        return iV
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

