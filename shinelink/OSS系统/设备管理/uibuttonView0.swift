//
//  uibuttonView0.swift
//  ShinePhone
//
//  Created by sky on 17/5/20.
//  Copyright © 2017年 sky. All rights reserved.
//

import UIKit

class uibuttonView0: UIView{

    var buttonArray:NSArray!
    var view1:UIView!
     var buttonNum:Int!
    var typeNum:Int!
    
    
    
    func initUI(){

        buttonNum=buttonArray.count
        
        for (i,buttonName) in buttonArray.enumerated(){
            let button2=UIButton()
            let W1=((320-buttonArray.count*70)/(buttonArray.count+1))
            let W=CGFloat(W1)*NOW_SIZE
            
            
            button2.frame=CGRect(x: W+(70*NOW_SIZE+W)*CGFloat(i), y: 5*HEIGHT_SIZE, width: 70*NOW_SIZE, height:20*HEIGHT_SIZE)
            if typeNum==1 {
                button2.frame=CGRect(x: 45*NOW_SIZE+160*NOW_SIZE*CGFloat(i), y: 5*HEIGHT_SIZE, width: 70*NOW_SIZE, height:20*HEIGHT_SIZE)
            }
            
            button2.setTitle(buttonName as? String, for: .normal)
            button2.setTitleColor(MainColor, for: .normal)
            button2.setTitleColor(backgroundGrayColor, for: .highlighted)
            button2.tag=i+2000
            button2.layer.borderWidth=0.8*HEIGHT_SIZE;
            button2.layer.cornerRadius=10*HEIGHT_SIZE;
            button2.titleLabel?.font=UIFont.systemFont(ofSize: 13*HEIGHT_SIZE)
            button2.titleLabel?.adjustsFontSizeToFitWidth=true
            button2.layer.borderColor=MainColor.cgColor;
            button2.isSelected=false
            button2.backgroundColor=UIColor.clear
            button2.addTarget(self, action:#selector(butttonChange(uibutton:)), for: .touchUpInside)
            self.addSubview(button2)
            
        }
        
        
    }

    
    
    func butttonChange(uibutton: UIButton)  {
        
        self.changeStateT(Tag: uibutton.tag)
        
        
        if uibutton.isSelected {
            uibutton.backgroundColor=backgroundGrayColor
            uibutton.setTitleColor(MainColor, for: .normal)
            uibutton.isSelected=false
            
            
            
        }else{
            let dic :[String : NSObject]  = ["tag":uibutton.tag as NSObject]
            let NotifyChatMsgRecv = NSNotification.Name(rawValue:"ReLoadTableView")
         NotificationCenter.default.post(name:NotifyChatMsgRecv, object: nil, userInfo: dic)
         
            
            uibutton.backgroundColor=MainColor
            uibutton.setTitleColor(backgroundGrayColor, for: .normal)
            uibutton.isSelected=true
            
        }
        
    }
    
    
    func changeStateT(Tag:Int)  {
        let A=Tag-2000
      
            for i in 0...(buttonNum-1){
                if i==A {
                    
                }else{
                    self.changeState(Tag: i)
                }
            }
       
        
   
        
    }
    
    func changeState( Tag:Int)  {
        
        let A=2000+Tag
        
        
        let B1 = self.viewWithTag(A) as! UIButton
        B1.isSelected=false
        B1.backgroundColor=backgroundGrayColor
        B1.setTitleColor(MainColor, for: .normal)
        
        
    }
    

    
    
    
    
    
    
    
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
