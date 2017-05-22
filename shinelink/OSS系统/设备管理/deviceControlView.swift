//
//  deviceControlView.swift
//  ShinePhone
//
//  Created by sky on 17/5/22.
//  Copyright © 2017年 sky. All rights reserved.
//

import UIKit

class deviceControlView: RootViewController {

      var lableNameArray:NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      self.initData()
      self.initUI()
        
    }

    func initData(){
    lableNameArray=["序列号","用户名","设备类型","IP及端口号","连接状态","更新间隔","更新时间","固件版本"]
    }
    
    func initUI(){
    let Num=lableNameArray.count/2
        
        for i in 0...Num {
            for k in 0...1 {
                let lable0=UILabel()
                lable0.textColor=COLOR(_R: 102, _G: 102, _B: 102, _A: 1)
                lable0.textAlignment=NSTextAlignment.center
                lable0.font=UIFont.systemFont(ofSize: 12*HEIGHT_SIZE)
                lable0.frame=CGRect(x: 0*NOW_SIZE+160*NOW_SIZE*CGFloat(Float(k)), y: 10*HEIGHT_SIZE+20*HEIGHT_SIZE*CGFloat(Float(i)), width: 160*NOW_SIZE, height: 20*HEIGHT_SIZE)
                let T=(k+2*i)
                lable0.text=lableNameArray[T] as? String
                self.view.addSubview(lable0)
            }
            
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
