//
//  ossTool.swift
//  ShinePhone
//
//  Created by sky on 2017/8/21.
//  Copyright © 2017年 sky. All rights reserved.
//

import UIKit

class ossTool: RootViewController  {
   var tableView:UITableView!
     var field0:UITextField!
        var view1:UIView!
    var Lable3:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title="工具";
        self.view.backgroundColor=MainColor;
        self.initUI()
    }

    
    func initUI() {
        
         view1=UIView()
        view1.frame=CGRect(x: 0, y: 10*HEIGHT_SIZE, width: SCREEN_Width, height: 230*HEIGHT_SIZE)
        view1.backgroundColor=COLOR(_R: 4, _G: 55, _B: 85, _A: 0.1)
              self.view.addSubview(view1)
        
        let view2=UIView()
        view2.frame=CGRect(x: 0, y: 0*HEIGHT_SIZE, width: SCREEN_Width, height: 30*HEIGHT_SIZE)
        view2.backgroundColor=COLOR(_R: 4, _G: 55, _B: 85, _A: 0.1)
        view1.addSubview(view2)
        
        let Lable3=UILabel()
        Lable3.frame=CGRect(x: 0*NOW_SIZE, y: 0*HEIGHT_SIZE, width: 320*NOW_SIZE, height: 30*HEIGHT_SIZE)
        Lable3.text="查询采集器校验码"
        Lable3.textColor=UIColor.white
        Lable3.font=UIFont.systemFont(ofSize: 14*HEIGHT_SIZE)
        Lable3.adjustsFontSizeToFitWidth=true
        Lable3.textAlignment=NSTextAlignment.center
        view2.addSubview(Lable3)
        
        let image1=UIImageView()
        image1.frame=CGRect(x:40*NOW_SIZE, y: 40*HEIGHT_SIZE, width: SCREEN_Width - 80*NOW_SIZE, height: 40*HEIGHT_SIZE)
        image1.image=UIImage.init(named:"圆角矩形空心.png")
        image1.isUserInteractionEnabled=true
        view1.addSubview(image1)


        
         field0=UITextField()
        field0.frame=CGRect(x: 0*NOW_SIZE, y: 0*HEIGHT_SIZE, width: 240*NOW_SIZE, height: 40*HEIGHT_SIZE)
        field0.placeholder = "输入采集器序列号";
        field0.textColor = UIColor.white
        field0.tintColor = UIColor.white
        field0.textAlignment = NSTextAlignment.center;
        field0.setValue(UIColor.lightText, forKeyPath: "_placeholderLabel.textColor")
          field0.setValue(UIFont.systemFont(ofSize: 12*HEIGHT_SIZE), forKeyPath: "_placeholderLabel.font")
        field0.font = UIFont.systemFont(ofSize: 14*HEIGHT_SIZE)
       image1.addSubview(field0)
        
        
    let buttonThree=UIButton()
        buttonThree.frame=CGRect(x: 40*NOW_SIZE, y:160*HEIGHT_SIZE, width: 240*NOW_SIZE, height:40*HEIGHT_SIZE)
      // buttonThree.setImage(UIImage.init(named:"按钮2.png"), for: .normal)
        buttonThree.setBackgroundImage(UIImage.init(named:"按钮2.png"), for: .normal)
        buttonThree.setTitle("查询", for: .normal)
        buttonThree.titleLabel?.font=UIFont.systemFont(ofSize: 16*HEIGHT_SIZE)
        buttonThree.setTitleColor(UIColor.white, for: .normal)
      
        buttonThree.addTarget(self, action:#selector(checkCode), for: .touchUpInside)
        view1.addSubview(buttonThree)

        
      
        
        
    }
    
    
    func checkCode() {
        let sn=field0.text
        if sn==nil || sn==""{
        self.showToastView(withTitle: "请输入采集器序列号")
            return
        }
         let snCode=self.getValidCode(field0.text)
        
        if (Lable3 == nil) {
            Lable3=UILabel()
            Lable3.frame=CGRect(x: 0*NOW_SIZE, y: 100*HEIGHT_SIZE, width: 320*NOW_SIZE, height: 40*HEIGHT_SIZE)
            let codeString="采集器校验码为"
            Lable3.text=String(format: "%@:%@", codeString,snCode!)
            Lable3.textColor=UIColor.white
            Lable3.font=UIFont.systemFont(ofSize: 14*HEIGHT_SIZE)
            Lable3.adjustsFontSizeToFitWidth=true
            Lable3.textAlignment=NSTextAlignment.center
            view1.addSubview(Lable3)
        }else{
            let codeString="采集器校验码为"
            Lable3.text=String(format: "%@:%@", codeString,snCode!)
        }
     
        
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
