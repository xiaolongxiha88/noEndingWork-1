//
//  IntegratorFirst.swift
//  ShinePhone
//
//  Created by sky on 17/6/2.
//  Copyright © 2017年 sky. All rights reserved.
//

import UIKit

class IntegratorFirst: RootViewController {

     var deviceString:NSString!
    var manString:NSString!
    var view0:UIView!
    var buttonThree:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
  self.navigationController?.navigationBar.barTintColor=MainColor
    self.navigationController?.setNavigationBarHidden(false, animated: false)
        
      self.initUI()
    }

    func initUI() {
        let buttonView=uibuttonView0()
        buttonView.frame=CGRect(x: 0*NOW_SIZE, y: 0*HEIGHT_SIZE, width: SCREEN_Width, height: 30*HEIGHT_SIZE)
        buttonView.typeNum=1
        buttonView.isUserInteractionEnabled=true
        buttonView.backgroundColor=backgroundGrayColor
        buttonView.buttonArray=["逆变器","储能机"]
        buttonView.initUI()
        self.view .addSubview(buttonView)
        
        for i in 0...1{
            let view3=UIView()
            view3.frame=CGRect(x: 0*NOW_SIZE+160*NOW_SIZE*CGFloat(i), y: 30*HEIGHT_SIZE, width: 160*NOW_SIZE, height: 40*HEIGHT_SIZE)
            view3.backgroundColor=UIColor.clear
            view3.isUserInteractionEnabled=true
            view3.tag=3000+i
            let tap=UITapGestureRecognizer(target: self, action: #selector(getDevice(tap:)))
            
            view3.addGestureRecognizer(tap)
            self.view.addSubview(view3)
            
            let Lable1=UILabel()
            Lable1.frame=CGRect(x: 20*NOW_SIZE, y: 0*HEIGHT_SIZE, width: 120*NOW_SIZE, height: 40*HEIGHT_SIZE)
            if i==0 {
                Lable1.text="已接入设备"
            }else if i==1{
               Lable1.text="所有代理商"
            }
            Lable1.tag=4000+i
            Lable1.textColor=COLOR(_R: 102, _G: 102, _B: 102, _A: 1)
            Lable1.textAlignment=NSTextAlignment.center
            Lable1.font=UIFont.systemFont(ofSize: 14*HEIGHT_SIZE)
            view3.addSubview(Lable1)
            
            let image1=UIImageView()
            image1.frame=CGRect(x: 142*NOW_SIZE, y: 18*HEIGHT_SIZE, width: 8*HEIGHT_SIZE, height: 6*HEIGHT_SIZE)
            image1.image=UIImage.init(named:"upOSS.png")
            view3.addSubview(image1)
            
            let view0=UIView()
            view0.frame=CGRect(x: 15*NOW_SIZE, y: 40*HEIGHT_SIZE, width: 140*NOW_SIZE, height: 1*HEIGHT_SIZE)
            view0.backgroundColor=COLOR(_R: 222, _G: 222, _B: 222, _A: 1)
            view3.addSubview(view0)

        
        }
        
        self.initUITwo()
    }
    
    
    func initUITwo() {
        view0=UIView()
        view0.frame=CGRect(x: 0*NOW_SIZE, y: 71*HEIGHT_SIZE, width: SCREEN_Width, height: 125*HEIGHT_SIZE)
        view0.backgroundColor=UIColor.clear
        view0.isUserInteractionEnabled=true
        self.view.addSubview(view0)
        
          let nameArray=["电站名","用户名","采集器序列号","设备序列号"]
        for i in 0...1 {
            for K in 0...1{
              let field0=UITextField()
                field0.frame=CGRect(x: 0*NOW_SIZE+160*NOW_SIZE*CGFloat(i), y: 0*HEIGHT_SIZE+40*HEIGHT_SIZE*CGFloat(K), width: 160*NOW_SIZE, height: 40*HEIGHT_SIZE)
                field0.placeholder=nameArray[i+2*K]
                field0.textAlignment=NSTextAlignment.center
                field0.tag=5000+K*2+i
                field0.textColor=COLOR(_R: 102, _G: 102, _B: 102, _A: 1)
                field0.tintColor=COLOR(_R: 102, _G: 102, _B: 102, _A: 1)
                field0.setValue(COLOR(_R: 154, _G: 154, _B: 154, _A: 1), forKeyPath: "_placeholderLabel.textColor")
                  field0.setValue(UIFont.systemFont(ofSize: 13*HEIGHT_SIZE), forKeyPath: "_placeholderLabel.font")
                field0.font=UIFont.systemFont(ofSize: 14*HEIGHT_SIZE)
                view0.addSubview(field0)

                let view1=UIView()
                view1.frame=CGRect(x: 15*NOW_SIZE+160*NOW_SIZE*CGFloat(i), y: 40*HEIGHT_SIZE+40*HEIGHT_SIZE*CGFloat(K), width: 140*NOW_SIZE, height: 1*HEIGHT_SIZE)
                view1.backgroundColor=COLOR(_R: 222, _G: 222, _B: 222, _A: 1)
                view0.addSubview(view1)
            
            }
        }
        
        
        buttonThree=UIButton()
        buttonThree.frame=CGRect(x: 60*NOW_SIZE, y:95*HEIGHT_SIZE, width: 200*NOW_SIZE, height:30*HEIGHT_SIZE)
        buttonThree.backgroundColor=COLOR(_R: 242, _G: 242, _B: 242, _A: 1)
        buttonThree.setTitle("搜索", for: .normal)
        buttonThree.layer.borderWidth=0.8*HEIGHT_SIZE;
        buttonThree.layer.cornerRadius=16*HEIGHT_SIZE;
        buttonThree.titleLabel?.adjustsFontSizeToFitWidth=true
        buttonThree.layer.borderColor=COLOR(_R: 222, _G: 222, _B: 222, _A: 1).cgColor;
        buttonThree.titleLabel?.font=UIFont.systemFont(ofSize: 16*HEIGHT_SIZE)
        buttonThree.setTitleColor(COLOR(_R: 102, _G: 102, _B: 102, _A: 1), for: .normal)
        buttonThree.setTitleColor(UIColor.black, for: .highlighted)
        buttonThree.addTarget(self, action:#selector(searchForDevice), for: .touchUpInside)
        view0.addSubview(buttonThree)

        
        let LableView=UIView()
        LableView.frame=CGRect(x: 0*NOW_SIZE, y: 210*HEIGHT_SIZE, width: SCREEN_Width, height: 30*HEIGHT_SIZE)
        LableView.backgroundColor=backgroundGrayColor
        self.view.addSubview(LableView)
        
        let Lable3=UILabel()
        Lable3.frame=CGRect(x: 120*NOW_SIZE, y: 0*HEIGHT_SIZE, width: 80*NOW_SIZE, height: 30*HEIGHT_SIZE)
            Lable3.text="查询结果"
        Lable3.textColor=COLOR(_R: 154, _G: 154, _B: 154, _A: 1)
        Lable3.adjustsFontSizeToFitWidth=true
        Lable3.textAlignment=NSTextAlignment.center
        Lable3.font=UIFont.systemFont(ofSize: 14*HEIGHT_SIZE)
        LableView.addSubview(Lable3)
        
        let view3=UIView()
        view3.frame=CGRect(x: 65*NOW_SIZE, y: 14*HEIGHT_SIZE, width: 50*NOW_SIZE, height: 1*HEIGHT_SIZE)
        view3.backgroundColor=COLOR(_R: 222, _G: 222, _B: 222, _A: 1)
        LableView.addSubview(view3)
        
        let view4=UIView()
        view4.frame=CGRect(x: 205*NOW_SIZE, y: 14*HEIGHT_SIZE, width: 50*NOW_SIZE, height: 1*HEIGHT_SIZE)
        view4.backgroundColor=COLOR(_R: 222, _G: 222, _B: 222, _A: 1)
        LableView.addSubview(view4)
        
    }
    
    
    func searchForDevice(){
    
    
    }
    
    
    func getDevice(tap:UITapGestureRecognizer){
   let View1=tap.view!
     let A=View1.tag-3000+4000
          let B1 = view.viewWithTag(A) as! UILabel
       
        
        if A==4000 {
             let nameArray=["已接入设备","未接入设备"]
            ZJBLStoreShopTypeAlert.show(withTitle: "选择设备类型", titles: nameArray as NSArray as! [NSString], selectIndex: {
                (selectIndex)in
                self.deviceString=nameArray[selectIndex] as NSString
                print("选择11了"+String(describing: selectIndex))
            }, selectValue: {
                (selectValue)in
                print("选择了"+String(describing: selectValue))
                B1.text=selectValue
            }, showCloseButton: true)
        }
        
        if A==4001 {
            let nameArray=["我是代理商一","我是代理商2","我是代理商3","我是代理商4","我是代理商5"]
            ZJBLStoreShopTypeAlert.show(withTitle: "选择设备类型", titles: nameArray as NSArray as! [NSString], selectIndex: {
                (selectIndex)in
                self.manString=nameArray[selectIndex] as NSString
                print("选择11了"+String(describing: selectIndex))
            }, selectValue: {
                (selectValue)in
                print("选择了"+String(describing: selectValue))
                B1.text=selectValue
            }, showCloseButton: true)
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
