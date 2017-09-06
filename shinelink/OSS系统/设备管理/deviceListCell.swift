//
//  deviceListCell.swift
//  ShinePhone
//
//  Created by sky on 17/5/20.
//  Copyright © 2017年 sky. All rights reserved.
//

import UIKit

class deviceListCell: UITableViewCell {

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
        TitleLabel3=UILabel()
        TitleLabel4=UILabel()
        TitleLabel0=UILabel()
        
        lableArray=[TitleLabel0,TitleLabel1,TitleLabel2,TitleLabel3,TitleLabel4]
        
        
        for (index,array) in lableArray.enumerated(){
            
            let lable0=array as!UILabel
            
            if index==0{
                lable0.textColor=MainColor
                lable0.textAlignment=NSTextAlignment.center
                lable0.font=UIFont.systemFont(ofSize: 10*HEIGHT_SIZE)
          lable0.frame=CGRect(x: 0*NOW_SIZE, y: 2*HEIGHT_SIZE, width:SCREEN_Width, height: 20*HEIGHT_SIZE)
            }else{
                lable0.textColor=COLOR(_R: 51, _G: 51, _B: 51, _A: 1)
                lable0.textAlignment=NSTextAlignment.left
                lable0.adjustsFontSizeToFitWidth=true
                lable0.font=UIFont.systemFont(ofSize: 10*HEIGHT_SIZE)
                if index==1||index==2{
                      let K=index-1
                 lable0.frame=CGRect(x: 10*NOW_SIZE+160*NOW_SIZE*CGFloat(Float(K)), y: 20*HEIGHT_SIZE, width: 150*NOW_SIZE, height: 20*HEIGHT_SIZE)
                }else{
                    let K=index-3
                 lable0.frame=CGRect(x: 10*NOW_SIZE+160*NOW_SIZE*CGFloat(Float(K)), y: 40*HEIGHT_SIZE, width: 150*NOW_SIZE, height: 20*HEIGHT_SIZE)
                }
                
             
            }
            
            
            
          
            self.contentView.addSubview(lable0)
            
  
            
        }
        
        view0=UIView()
        view0.frame=CGRect(x: 0*NOW_SIZE, y: 60*HEIGHT_SIZE, width: SCREEN_Width, height: 5*HEIGHT_SIZE)
        view0.backgroundColor=backgroundGrayColor
        
        self.contentView.addSubview(view0)
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
 
    
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
