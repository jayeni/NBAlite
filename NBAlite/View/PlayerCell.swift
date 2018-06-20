//
//  PlayerCell.swift
//  NBAlite
//
//  Created by Jeremiah Ayeni on 6/16/18.
//  Copyright © 2018 Jeremiah Ayeni. All rights reserved.
//

import UIKit

class PlayerCell:  UICollectionViewCell{
    var player:Player?{
        didSet{
            Name.text = (player?.firstName)! + " " + (player?.surName)!
            setupImage()
            
        }
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

