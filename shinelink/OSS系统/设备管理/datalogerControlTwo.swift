//
//  datalogerControlTwo.swift
//  ShinePhone
//
//  Created by sky on 17/5/24.
//  Copyright © 2017年 sky. All rights reserved.
//

import UIKit

class datalogerControlTwo: RootViewController {

    var  lableName:NSString!
    var  typeNum:NSString!
    var  textValue1:UITextField!
        var  textValue2:UITextField!
        var  textValue3:UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 self.view.backgroundColor=MainColor
        
        if typeNum=="4" {
            self.initUItwo()
        }else{
         self.initUI()
        }
       
        let button2=UIButton(type: .custom)
        button2.frame=CGRect(x:60*NOW_SIZE, y: 180*HEIGHT_SIZE, width:200*NOW_SIZE, height: 40*HEIGHT_SIZE)
        button2.setBackgroundImage(UIImage(named:"按钮2.png" ), for:.normal)
        button2.setTitle(root_finish, for:.normal)
        button2.titleLabel?.textColor=UIColor.white
        button2.tintColor=UIColor.white
        button2.titleLabel?.font=UIFont.systemFont(ofSize: 16*HEIGHT_SIZE)
        button2.addTarget(self, action:#selector(finishSet), for: .touchUpInside)
        self.view.addSubview(button2)
    }

    func initUI(){
        let lable0=UILabel()
        lable0.textColor=UIColor.white
        lable0.textAlignment=NSTextAlignment.center
        lable0.font=UIFont.systemFont(ofSize: 16*HEIGHT_SIZE)
        lable0.frame=CGRect(x: 10*NOW_SIZE, y: 40*HEIGHT_SIZE, width: 300*NOW_SIZE, height: 30*HEIGHT_SIZE)
        lable0.text=lableName as String?
        self.view.addSubview(lable0)
        
        let W=200*NOW_SIZE
        textValue1=UITextField()
        textValue1.textColor=UIColor.white
        textValue1.textAlignment=NSTextAlignment.center
        textValue1.font=UIFont.systemFont(ofSize: 16*HEIGHT_SIZE)
        textValue1.frame=CGRect(x: (SCREEN_Width-W)/2, y: 90*HEIGHT_SIZE, width: W, height: 30*HEIGHT_SIZE)
        textValue1.layer.borderWidth=1
         textValue1.layer.cornerRadius=6
         textValue1.layer.borderColor=UIColor.white.cgColor
        self.view.addSubview(textValue1)
        
    
        
    }
    
    func initUItwo(){
       let nameArray=["寄存器:","值:"]
        for (i,name) in nameArray.enumerated() {
            
            let lable0=UILabel()
            lable0.textColor=UIColor.white
            lable0.textAlignment=NSTextAlignment.right
            lable0.font=UIFont.systemFont(ofSize: 16*HEIGHT_SIZE)
            lable0.frame=CGRect(x: 5*NOW_SIZE, y: 40*HEIGHT_SIZE+50*HEIGHT_SIZE*CGFloat(i), width: 100*NOW_SIZE, height: 30*HEIGHT_SIZE)
            lable0.text=name as String?
            self.view.addSubview(lable0)
            
        }
        
        let W=150*NOW_SIZE
        textValue2=UITextField()
        textValue2.textColor=UIColor.white
        textValue2.textAlignment=NSTextAlignment.left
        textValue2.font=UIFont.systemFont(ofSize: 16*HEIGHT_SIZE)
        textValue2.frame=CGRect(x: 112*NOW_SIZE, y: 40*HEIGHT_SIZE, width: W, height: 30*HEIGHT_SIZE)
        textValue2.layer.borderWidth=1
        textValue2.layer.cornerRadius=6
        textValue2.layer.borderColor=UIColor.white.cgColor
        self.view.addSubview(textValue2)
        
        textValue3=UITextField()
        textValue3.textColor=UIColor.white
        textValue3.textAlignment=NSTextAlignment.left
        textValue3.font=UIFont.systemFont(ofSize: 16*HEIGHT_SIZE)
        textValue3.frame=CGRect(x: 112*NOW_SIZE, y: 90*HEIGHT_SIZE, width: W, height: 30*HEIGHT_SIZE)
        textValue3.layer.borderWidth=1
        textValue3.layer.cornerRadius=6
        textValue3.layer.borderColor=UIColor.white.cgColor
        self.view.addSubview(textValue3)
        
    }
    
    
    
    
    
    func finishSet(){
    
    
    
    }
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
