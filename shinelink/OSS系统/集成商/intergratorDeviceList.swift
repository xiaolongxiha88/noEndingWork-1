//
//  intergratorDeviceList.swift
//  ShinePhone
//
//  Created by sky on 17/6/16.
//  Copyright © 2017年 sky. All rights reserved.
//

import UIKit

class intergratorDeviceList: RootViewController,UITableViewDataSource,UITableViewDelegate {

      var tableView:UITableView!
    var cellNameArray:NSMutableArray!
    var cellValue0Array:NSMutableArray!
    var cellValue1Array:NSMutableArray!
    var cellValue2Array:NSMutableArray!
    var cellValue3Array:NSMutableArray!
    var plantListArray:NSMutableArray!
    var cellValue4Array:NSMutableArray!
    var cellValue5Array:NSMutableArray!
    var pageNum:Int!
    var netDic:NSDictionary!
    var netAllDic:NSMutableDictionary!
    var deviceStatusType:Int!
    var deviceType:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
  self.pageNum=0
    self.initNet1()
    }

    
    func initTableView(){
        
        tableView=UITableView()
        let H1=30*HEIGHT_SIZE
        tableView.frame=CGRect(x: 0, y: 0, width: SCREEN_Width, height: SCREEN_Height-H1)
        tableView.delegate=self
        tableView.dataSource=self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.register(deviceListCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
        
        let foot=MJRefreshAutoNormalFooter(refreshingBlock: {
            
            self.pageNum=self.pageNum+1
            self.initNet0()
            
            //结束刷新
            self.tableView!.mj_footer.endRefreshing()
        })
        
        tableView.mj_footer=foot
        foot?.setTitle("", for: .idle)
        
        
    }
    
    
    func initNet1(){
        
        self.cellValue1Array=[]
        self.cellValue2Array=[]
        self.cellValue3Array=[]
        self.cellValue4Array=[]
         self.cellValue5Array=[]
        self.plantListArray=[]
        cellValue0Array=[]
        cellNameArray=[]
        
        self.initNet0()
    }

    
    func initNet0(){
        
          self.netAllDic=NSMutableDictionary.init(dictionary: netDic)
        netAllDic.setValue( self.pageNum, forKey: "page")
        netAllDic.setValue( self.deviceStatusType, forKey: "deviceStatus")
          let DicAll=self.netAllDic as Dictionary
        
        self.showProgressView()
        BaseRequest.request(withMethodResponseStringResult: OSS_HEAD_URL, paramars:DicAll, paramarsSite: "/api/v1/customer/device_list", sucessBlock: {(successBlock)->() in
            self.hideProgressView()
            
            let data:Data=successBlock as! Data
            
            let jsonDate0=try? JSONSerialization.jsonObject(with: data, options:[])
            
            if (jsonDate0 != nil){
                let jsonDate=jsonDate0 as! Dictionary<String, Any>
                print("//api/v1/customer/device_list=",jsonDate)
     
                let result1=jsonDate["result"] as! Int
               var plantAll:NSArray=[]
                if result1==1 {
                         let objArray=jsonDate["obj"] as! Dictionary<String, Any>
                    
                    if self.deviceType==0{
                     plantAll=objArray["invList"] as! NSArray
                    } else if self.deviceType==1{
                        plantAll=objArray["storageList"] as! NSArray
                    }
                        for i in 0..<plantAll.count{
                            self.cellValue0Array.add((plantAll[i] as! NSDictionary)["alias"] as!NSString)
                            self.cellValue1Array.add((plantAll[i] as! NSDictionary)["userName"] as!NSString)
                            self.cellValue2Array.add((plantAll[i] as! NSDictionary)["plantName"] as!NSString)
                            self.cellValue3Array.add((plantAll[i] as! NSDictionary)["agentName"] as!NSString)
                            self.cellValue4Array.add((plantAll[i] as! NSDictionary)["lost"] as! NSString)
                            self.cellValue4Array.add((plantAll[i] as! NSDictionary)["seriaNum"] as!NSString)
                            self.plantListArray.add(plantAll[i])
                            
                        }

                    if self.plantListArray.count>0{
                        
                        if (self.tableView == nil){
                            self.initTableView()
                        }else{
                            self.tableView.reloadData()
                        }
                        
                    }
                    
                    
                }else{
                    self.showToastView(withTitle: jsonDate["msg"] as! String!)
                }
                
            }
            
        }, failure: {(error) in
            self.showToastView(withTitle: root_Networking)
        })
        
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellValue1Array.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 65*HEIGHT_SIZE
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
     
            cellNameArray=["所属用户:","所属电站:","所属代理商:","状态:"];

        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as!deviceListCell
        
        let lable1=NSString(format: "%@%@", cellNameArray[0]as!NSString,cellValue1Array[indexPath.row]as!NSString)
      
        let lable41 = cellValue4Array[indexPath.row]as!NSString
        var lable42:NSString
        if lable41=="1" {
            lable42="掉线"
        }else{
            lable42="在线"
        }
        
          let lable4=NSString(format: "%@%@", cellNameArray[3]as!NSString,lable42)
        let  lable2=NSString(format: "%@%@", cellNameArray[1]as!NSString,cellValue2Array[indexPath.row]as!NSString)
        let  lable3=NSString(format: "%@%@", cellNameArray[2]as!NSString,cellValue3Array[indexPath.row]as!NSString)
        
        
        
        cell.TitleLabel0.text=cellValue0Array[indexPath.row] as? String
        
        cell.TitleLabel1.text=lable1 as String
        cell.TitleLabel2.text=lable2 as String
        cell.TitleLabel3.text=lable3 as String?
        cell.TitleLabel4.text=lable4 as String?
        
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let CELL=cellValue5Array[indexPath.row] as! NSString
        
        let goView=deviceControlView()
        
        goView.deviceTypeString=NSString(format: "%d", deviceType)
        goView.deviceSnString=CELL
        
        self.navigationController?.pushViewController(goView, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
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
