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
     var backNum:Int?
       var goToNetNum:Int?
    
     var firstNum:Int!
     var secondNum:Int!
    
    func initUI(){

        buttonNum=buttonArray.count
        
        for (i,buttonName) in buttonArray.enumerated(){
            let button2=UIButton()
            var buttonW:CGFloat
            if typeNum==2 || typeNum==3{
            buttonW=50
            }else{
             buttonW=70
            }
            let W1=((320-buttonArray.count*Int(buttonW))/(buttonArray.count+1))
            let W=CGFloat(W1)*NOW_SIZE
            
            
            button2.frame=CGRect(x: W+(buttonW*NOW_SIZE+W)*CGFloat(i), y: 5*HEIGHT_SIZE, width: buttonW*NOW_SIZE, height:20*HEIGHT_SIZE)
         
            
            button2.setTitle(buttonName as? String, for: .normal)
            button2.setTitleColor(MainColor, for: .normal)
            button2.setTitleColor(backgroundGrayColor, for: .highlighted)
            button2.tag=i+2000
            button2.layer.borderWidth=0.8*HEIGHT_SIZE;
            button2.layer.cornerRadius=10*HEIGHT_SIZE;
            button2.titleLabel?.font=UIFont.systemFont(ofSize: 12*HEIGHT_SIZE)
            if typeNum==2 || typeNum==3{
             button2.titleLabel?.font=UIFont.systemFont(ofSize: 10*HEIGHT_SIZE)
            }
            if typeNum==3{
                button2.tag=i+4000
            }
            button2.titleLabel?.adjustsFontSizeToFitWidth=true
            button2.layer.borderColor=MainColor.cgColor;
            button2.isSelected=false
            button2.backgroundColor=UIColor.clear
            if typeNum==0 {
                if i==1 {
                    button2.backgroundColor=MainColor
                    button2.setTitleColor(backgroundGrayColor, for: .normal)
                    button2.isSelected=true
                }
            }
            if typeNum==1 {
                button2.frame=CGRect(x: 45*NOW_SIZE+160*NOW_SIZE*CGFloat(i), y: 5*HEIGHT_SIZE, width: 70*NOW_SIZE, height:20*HEIGHT_SIZE)
                if i==firstNum {
                    button2.backgroundColor=MainColor
                    button2.setTitleColor(backgroundGrayColor, for: .normal)
                    button2.isSelected=true
                }
            }
            
            if typeNum==3 {
               
                if i==secondNum {
                    button2.backgroundColor=MainColor
                    button2.setTitleColor(backgroundGrayColor, for: .normal)
                    button2.isSelected=true
                }
            }
           
            
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
            
            if goToNetNum==1 {
                let NotifyChatMsgRecv = NSNotification.Name(rawValue:"ReLoadTableView1")
                NotificationCenter.default.post(name:NotifyChatMsgRecv, object: nil, userInfo: dic)
            }
            
            if goToNetNum==2 {
                let NotifyChatMsgRecv = NSNotification.Name(rawValue:"ReLoadTableView2")
                NotificationCenter.default.post(name:NotifyChatMsgRecv, object: nil, userInfo: dic)
            }
            
            if goToNetNum==3 {
                let NotifyChatMsgRecv = NSNotification.Name(rawValue:"ReLoadTableView3")
                NotificationCenter.default.post(name:NotifyChatMsgRecv, object: nil, userInfo: dic)
            }
            
     
         
            
            uibutton.backgroundColor=MainColor
            uibutton.setTitleColor(backgroundGrayColor, for: .normal)
            uibutton.isSelected=true
            
        }
        
    }
    
    
    func changeStateT(Tag:Int)  {
        var A=Tag-2000
        if typeNum==3{
            A=Tag-4000
        }
            for i in 0...(buttonNum-1){
                if i==A {
                    
                }else{
                    self.changeState(Tag: i)
                }
            }
       
        
   
        
    }
    
    func changeState( Tag:Int)  {
        
        var A=2000+Tag
        if typeNum==3{
            A=Tag+4000
        }
        
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
