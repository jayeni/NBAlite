//
//  VideoCell.swift
//  NBAlite
//
//  Created by Jeremiah Ayeni on 6/25/18.
//  Copyright © 2018 Jeremiah Ayeni. All rights reserved.
//

import UIKit


class VideoCell: UICollectionViewCell{
    var video:Video?{
        didSet{
            setupImage()
        }
    }
    override init(frame: CGRect){
        super.init(frame: frame)
        setupCell()
        
    }
    override var isSelected: Bool{
        didSet{
            
            //self.backgroundColor = isSelected ? UIColor.black : UIColor.init(white: 1, alpha: 0.5)
          
            
        }
    }
    
    func setupCell(){
        addSubview(thumbnail)
        self.backgroundColor = UIColor.clear
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat:"H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : thumbnail]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat:"V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : thumbnail]))


        //self.addSubview(teamImage)
        
    }
    func setupImage(){
        if let imageurl = video?.thumbNail{
            
            let url = URL(string: imageurl)
            
            URLSession.shared.dataTask(with: url!){ (data, response, error) in
                
                if error != nil {
                    return
                }
                DispatchQueue.main.async {
                    self.thumbnail.image = UIImage(data: data!)
                }
                
                
                }.resume()
            
            
            
    }
    }

    let thumbnail: UIImageView = {
        
        let iV = UIImageView()
        iV.contentMode = .scaleAspectFit
        iV.translatesAutoresizingMaskIntoConstraints=false;
        
        return iV
    }()
        
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
