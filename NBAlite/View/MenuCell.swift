//
//  MenuCell.swift
//  NBAlite
//
//  Created by Jeremiah Ayeni on 6/18/18.
//  Copyright © 2018 Jeremiah Ayeni. All rights reserved.
//

import UIKit

class MenuCell : UICollectionViewCell{
    var menu:Menu?{
        didSet{
            cellName.text = menu?.name
            cellImage.image = UIImage(named: (menu?.image)!)
       
            
        }
    }
  
    override init(frame: CGRect){
        super.init(frame: frame)
        setup()
        
        
    }
    func setup(){
        
            self.backgroundColor = UIColor.init(white: 1, alpha: 0.5)
            addSubview(cellName)
            addSubview(cellImage)
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat:"H:|-100-[v0(200)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : cellImage]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat:"H:|-40-[v0(300)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : cellName]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat:"V:|[v0]-10-[v1]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : cellName,"v1" : cellImage]))
            
            //self.addSubview(teamImage)
            
        
       
    }
    let cellName: UILabel = {
        let name = UILabel()
        name.text="TEXT"
        name.textColor = UIColor.black
        name.textAlignment = .center
        name.font = UIFont.boldSystemFont(ofSize: 20)
        name.translatesAutoresizingMaskIntoConstraints=false
        return name
        
    }()
    
    let cellImage: UIImageView = {
        let imageV = UIImageView()
        
        imageV.contentMode = .scaleAspectFit
        imageV.translatesAutoresizingMaskIntoConstraints=false;
        
        return imageV
    }()

    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    

}
