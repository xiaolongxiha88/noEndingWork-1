//
//  intergratorDeviceCell.swift
//  ShinePhone
//
//  Created by sky on 2017/7/24.
//  Copyright © 2017年 sky. All rights reserved.
//

import UIKit

class intergratorDeviceCell: UITableViewCell {

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
                lable0.textColor=COLOR(_R: 51, _G: 51, _B: 51, _A: 1)
                lable0.textAlignment=NSTextAlignment.center
                lable0.font=UIFont.systemFont(ofSize: 12*HEIGHT_SIZE)
                lable0.frame=CGRect(x: 0*NOW_SIZE, y: 2*HEIGHT_SIZE, width:SCREEN_Width, height: 20*HEIGHT_SIZE)
            }else{
            let cellNameArray=["","所属用户","所属电站","所属代理商","状态"];
                
             let lable1=UILabel()
                lable1.textColor=MainColor
                lable1.textAlignment=NSTextAlignment.center
                lable1.adjustsFontSizeToFitWidth=true
                lable1.font=UIFont.systemFont(ofSize: 12*HEIGHT_SIZE)
                lable1.text=cellNameArray[index]
                if index==1||index==2{
                    let K=index-1
                    lable1.frame=CGRect(x: 0*NOW_SIZE+160*NOW_SIZE*CGFloat(Float(K)), y: 20*HEIGHT_SIZE, width: 160*NOW_SIZE, height: 20*HEIGHT_SIZE)
                }else{
                    let K=index-3
                    lable1.frame=CGRect(x: 0*NOW_SIZE+160*NOW_SIZE*CGFloat(Float(K)), y: 60*HEIGHT_SIZE, width: 160*NOW_SIZE, height: 20*HEIGHT_SIZE)
                }
                  self.contentView.addSubview(lable1)
                
                lable0.textColor=COLOR(_R: 51, _G: 51, _B: 51, _A: 1)
                lable0.textAlignment=NSTextAlignment.center
                lable0.adjustsFontSizeToFitWidth=true
                lable0.font=UIFont.systemFont(ofSize: 12*HEIGHT_SIZE)
                if index==1||index==2{
                    let K=index-1
                    lable0.frame=CGRect(x: 0*NOW_SIZE+160*NOW_SIZE*CGFloat(Float(K)), y: 36*HEIGHT_SIZE, width: 160*NOW_SIZE, height: 20*HEIGHT_SIZE)
                }else{
                    let K=index-3
                    lable0.frame=CGRect(x: 0*NOW_SIZE+160*NOW_SIZE*CGFloat(Float(K)), y: 76*HEIGHT_SIZE, width: 160*NOW_SIZE, height: 20*HEIGHT_SIZE)
                }
             
        }
            self.contentView.addSubview(lable0)
            
    }
        
        view0=UIView()
        view0.frame=CGRect(x: 0*NOW_SIZE, y: 100*HEIGHT_SIZE, width: SCREEN_Width, height: 8*HEIGHT_SIZE)
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
