//
//  plantListCell.swift
//  ShinePhone
//
//  Created by sky on 17/6/10.
//  Copyright © 2017年 sky. All rights reserved.
//

import UIKit

class plantListCell: UITableViewCell {
    
var TitleLabel0:UILabel!
    var TitleLabel1:UILabel!
    var TitleLabel2:UILabel!
    var TitleLabel3:UILabel!
    var TitleLabel4:UILabel!
    
    var lableArray:NSArray!
    var view0:UIView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        TitleLabel1=UILabel()
        TitleLabel2=UILabel()
        
//        TitleLabel0=UILabel()
//        TitleLabel0.textColor=COLOR(_R: 102, _G: 102, _B: 102, _A: 1)
//        TitleLabel0.textAlignment=NSTextAlignment.center
//        TitleLabel0.font=UIFont.systemFont(ofSize: 12*HEIGHT_SIZE)
//        TitleLabel0.adjustsFontSizeToFitWidth=true
//        TitleLabel0.frame=CGRect(x: 30*NOW_SIZE, y: 7*HEIGHT_SIZE, width: 260*NOW_SIZE, height: 30*HEIGHT_SIZE)
//        self.contentView.addSubview(TitleLabel0)
        
        lableArray=[TitleLabel1,TitleLabel2]
        
        
        let lableW=140*NOW_SIZE
        for (index,array) in lableArray.enumerated(){
            
            let lable0=array as!UILabel
            lable0.textColor=COLOR(_R: 51, _G: 51, _B: 51, _A: 1)
            lable0.textAlignment=NSTextAlignment.left
            lable0.font=UIFont.systemFont(ofSize: 11*HEIGHT_SIZE)
           // lable0.adjustsFontSizeToFitWidth=true
            lable0.frame=CGRect(x: 10*NOW_SIZE+lableW*CGFloat(Float(index)), y: 7*HEIGHT_SIZE, width: lableW, height: 30*HEIGHT_SIZE)
            self.contentView.addSubview(lable0)
            
  
        }
        
        view0=UIView()
        view0.frame=CGRect(x: 0*NOW_SIZE, y: 37*HEIGHT_SIZE, width: SCREEN_Width, height: 5*HEIGHT_SIZE)
        view0.backgroundColor=backgroundGrayColor
        
        self.contentView.addSubview(view0)
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
