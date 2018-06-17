//
//  TeamCell.swift
//  NBAlite
//
//  Created by Jeremiah Ayeni on 6/14/18.
//  Copyright © 2018 Jeremiah Ayeni. All rights reserved.
//

import UIKit

class TeamCell: UICollectionViewCell{
    var team:Team?{
        didSet{
            teamName.text = team?.teamName
            teamLoc.text = team?.teamLoc
            setupImage()
            
        }
    }
    override init(frame: CGRect){
        super.init(frame: frame)
        setupCell()
    
    }
    override var isSelected: Bool{
        didSet{
           
            self.backgroundColor = isSelected ? UIColor.black : UIColor.darkGray
            backgroundView?.backgroundColor = UIColor.black
            
        }
    }
    
    func setupCell(){
        self.backgroundColor=UIColor.darkGray
        addSubview(teamName)
        addSubview(teamLoc)
        addSubview(teamImage)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat:"H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : teamImage]))
         addConstraints(NSLayoutConstraint.constraints(withVisualFormat:"H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : teamLoc]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat:"H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : teamName]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat:"V:|[v1(75)][v2][v0]-1-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : teamName,"v1" : teamImage,"v2" : teamLoc]))
        
        //self.addSubview(teamImage)
        
    }
    func setupImage(){
        if let imageurl = team?.picloc{
            
            let url = URL(string: imageurl)
            
            URLSession.shared.dataTask(with: url!){ (data, response, error) in
                
                if error != nil {
                    return
                }
                DispatchQueue.main.async {
                    self.teamImage.image = UIImage(data: data!)
                }
                
            
            }.resume()
 
            
        }
    }
    let teamName: UILabel = {
        let nameL = UILabel()
        nameL.text="TEXT"
        nameL.textColor = UIColor.white
        nameL.textAlignment = .center
        nameL.font = UIFont.boldSystemFont(ofSize: 14)
        nameL.translatesAutoresizingMaskIntoConstraints=false
        return nameL
        
    }()
    let teamLoc: UILabel = {
        let namer = UILabel()
        namer.text="TEXT"
        namer.textColor = UIColor.white
        namer.textAlignment = .center
        namer.font = UIFont.boldSystemFont(ofSize: 14)
        namer.translatesAutoresizingMaskIntoConstraints=false
        return namer
        
    }()

    let teamImage: UIImageView = {
        let iV = UIImageView()
        
        iV.contentMode = .scaleAspectFit
        iV.translatesAutoresizingMaskIntoConstraints=false;
        
        return iV
    }()
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


