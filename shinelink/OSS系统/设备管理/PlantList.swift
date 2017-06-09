//
//  PlantList.swift
//  ShinePhone
//
//  Created by sky on 17/6/9.
//  Copyright © 2017年 sky. All rights reserved.
//

import UIKit

class PlantList: RootViewController {

      var userNameString:NSString!
      var pageNum:Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageNum=0;
       self.initNet
        
    }

    func initNet(){
        

        netDic=["userName":userNameString,"page":pageNum]
        
        BaseRequest.request(withMethodResponseStringResult: OSS_HEAD_URL, paramars: netDic as! [AnyHashable : Any]!, paramarsSite: "/api/v1/search/user_plant_list", sucessBlock: {(successBlock)->() in
            
            
            let data:Data=successBlock as! Data
            
            let jsonDate0=try? JSONSerialization.jsonObject(with: data, options:[])
            
            if (jsonDate0 != nil){
                let jsonDate=jsonDate0 as! Dictionary<String, Any>
                print("/api/v1/search/user_plant_list=",jsonDate)
                // let result:NSString=NSString(format:"%s",jsonDate["result"] )
                let result1=jsonDate["result"] as! Int
                
                if result1==1 {
                    let objArray=jsonDate["obj"] as! Dictionary<String, Any>
                    let deviceType=objArray["deviceType"] as! Int
                    var allDic:NSDictionary!=[:]
                    
                    if deviceType==0 {
                        allDic=objArray["datalogBean"] as!  NSDictionary!
                    }else if deviceType==1 {
                        allDic=objArray["invBean"] as!  NSDictionary!
                    }else if deviceType==2 {
                        allDic=objArray["storageBean"] as!  NSDictionary!
                    }
                    if allDic.count>1 {
                        let vc=deviceControlView()
                        vc.typeNum=deviceType
                        vc.valueDic=allDic
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    
                    
                    
                    
                }else{
                    self.showToastView(withTitle: jsonDate["msg"] as! String!)
                }
                
            }
            
        }, failure: {(error) in
            self.showToastView(withTitle: root_Networking)
        })
        
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
