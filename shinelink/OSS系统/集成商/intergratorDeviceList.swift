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

    }

    
    override func viewWillAppear(_ animated: Bool) {

        self.pageNum=1
        self.initNet1()
    }
    
    func initTableView(){
        
        tableView=UITableView()
        let H1=30*HEIGHT_SIZE
        tableView.frame=CGRect(x: 0, y: 0, width: SCREEN_Width, height: SCREEN_Height-H1)
        tableView.delegate=self
        tableView.dataSource=self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.register(intergratorDeviceCell.classForCoder(), forCellReuseIdentifier: "cell")
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
        
        let accessStatusNum=self.netAllDic["accessStatus"] as! Int
        
        
        self.showProgressView()
        BaseRequest.request(withMethodResponseStringResult: OSS_HEAD_URL, paramars:DicAll, paramarsSite: "/api/v2/customer/device_list", sucessBlock: {(successBlock)->() in
            self.hideProgressView()
            
            let data:Data=successBlock as! Data
            
            let jsonDate0=try? JSONSerialization.jsonObject(with: data, options:[])
            
            if (jsonDate0 != nil){
                let jsonDate=jsonDate0 as! Dictionary<String, Any>
                print("/api/v2/customer/device_list=",jsonDate)
     
                let result1=jsonDate["result"] as! Int
               var plantAll:NSArray=[]
                if result1==1 {
                         let objArray=jsonDate["obj"] as! Dictionary<String, Any>
                    
                    if self.deviceType==0{
                     plantAll=objArray["invList"] as! NSArray
                    } else if self.deviceType==1{
                        plantAll=objArray["storageList"] as! NSArray
                    }
                    if accessStatusNum==1{
                        for i in 0..<plantAll.count{
                            self.cellValue0Array.add((plantAll[i] as! NSDictionary)["alias"] as? NSString ??  "")
                            self.cellValue1Array.add((plantAll[i] as! NSDictionary)["userName"] as? NSString ??  "")
                            self.cellValue2Array.add((plantAll[i] as! NSDictionary)["plantName"] as? NSString ??  "")
                            self.cellValue3Array.add((plantAll[i] as! NSDictionary)["datalog_sn"] as? NSString ??  "")
                            if ((plantAll[i] as! NSDictionary)["status"] ) is NSString{
                                let A=(plantAll[i] as! NSDictionary)["status"] as! NSString
                                if A=="" {
                                    self.cellValue4Array.add(10)
                                }else{
                                    self.cellValue4Array.add(A.integerValue)
                                }
                                
                            }else{
                                self.cellValue4Array.add((plantAll[i] as! NSDictionary)["status"] as? Int ?? 10)
                            }
                            
                            self.cellValue5Array.add((plantAll[i] as! NSDictionary)["seriaNum"] as!NSString)
                            self.plantListArray.add(plantAll[i])
                            
                        }
                    
                    }
                    

                    if accessStatusNum==2{
                        for i in 0..<plantAll.count{
                            self.cellValue0Array.add((plantAll[i] as! NSDictionary)["deviceSn"] as!NSString)
                            self.cellValue1Array.add(root_zanwu_shuju as NSString)
                            self.cellValue2Array.add(root_zanwu_shuju as NSString)
                            self.cellValue3Array.add(root_zanwu_shuju as NSString)
                            self.cellValue4Array.add(10)
                               self.cellValue5Array.add((plantAll[i] as! NSDictionary)["deviceSn"] as!NSString)
                           self.plantListArray.add(plantAll[i])
                        }
                    }
                    
                    if self.plantListArray.count>0{
                        if(plantAll.count==0){
                                  self.showToastView(withTitle: "暂无数据")
                        }else{
                            if (self.tableView == nil){
                                self.initTableView()
                            }else{
                                self.tableView.reloadData()
                            }
  
                        }
                        
                    }
                    
                    if self.plantListArray.count==0{
                        if self.pageNum==1{
                            if (self.tableView != nil){
                                self.tableView.removeFromSuperview()
                                self.tableView=nil
                            }
                                  self.getNoDataView()
                        }
                     
                    }
                
                    
                }else{
                    
                    if self.pageNum==1{
                        if (self.tableView != nil){
                            self.tableView.removeFromSuperview()
                            self.tableView=nil
                        }
                           self.getNoDataView()
                    }
                    
                    self.showToastView(withTitle: jsonDate["msg"] as! String!)
                    
                    
                }
                
            }
            
        }, failure: {(error) in
            self.hideProgressView()
            self.showToastView(withTitle: root_Networking)
        })
        
    }
    
    
    func getNoDataView(){
        let view0=UIView()
        view0.frame=CGRect(x: 0*NOW_SIZE, y: 120*HEIGHT_SIZE, width: SCREEN_Width, height: 120*HEIGHT_SIZE)
        view0.backgroundColor=UIColor.clear
        self.view.addSubview(view0)
        
        let H=50*HEIGHT_SIZE
        let image0=UIImageView()
        image0.frame=CGRect(x: (SCREEN_Width-H)/2, y: 10*HEIGHT_SIZE, width: H, height: H)
        image0.image=UIImage.init(named: "data_icon.png")
        view0.addSubview(image0)
        
        let lable0=UILabel()
        lable0.frame=CGRect(x: 0*NOW_SIZE, y: 10*HEIGHT_SIZE+H+10*HEIGHT_SIZE, width: SCREEN_Width, height: 30*HEIGHT_SIZE)
        lable0.textColor=COLOR(_R: 187, _G: 187, _B: 187, _A: 1)
        lable0.textAlignment=NSTextAlignment.center
        lable0.text="暂无数据"
        lable0.font=UIFont.systemFont(ofSize: 16*HEIGHT_SIZE)
        view0.addSubview(lable0)
        
        
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellValue1Array.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 108*HEIGHT_SIZE
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
     
        //    cellNameArray=["所属用户:","所属电站:","所属代理商:","状态:"];

        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as!intergratorDeviceCell
        
        let lable1=NSString(format: "%@", cellValue1Array[indexPath.row]as!NSString)
      
        

        
        var lable22:NSString
        if self.deviceType==0{
            if (cellValue4Array[indexPath.row]as! Int == 0) {
                lable22 = "等待"
                cell.TitleLabel4.textColor=COLOR(_R: 17, _G: 183, _B: 243, _A: 1)
            }else if (cellValue4Array[indexPath.row]as! Int == 1){
                lable22 = "正常"
                cell.TitleLabel4.textColor=COLOR(_R: 119, _G: 213, _B: 59, _A: 1)
            }else if (cellValue4Array[indexPath.row]as!Int == 3){
                lable22 = "故障"
                cell.TitleLabel4.textColor=COLOR(_R: 209, _G: 56, _B: 56, _A: 1)
            }else{
                lable22 = "离线"
                cell.TitleLabel4.textColor=COLOR(_R: 153, _G: 153, _B: 153, _A: 1)
            }
            let lable2=NSString(format: "%@", lable22)
            cell.TitleLabel4.text=lable2 as String

        }
        
        if self.deviceType==1{
            if (cellValue4Array[indexPath.row]as! Int == 0) {
                lable22 = "闲置"
                cell.TitleLabel4.textColor=COLOR(_R: 45, _G: 226, _B: 233, _A: 1)
            }else if (cellValue4Array[indexPath.row]as! Int == 1){
                lable22 = "充电"
                cell.TitleLabel4.textColor=COLOR(_R: 121, _G: 230, _B: 129, _A: 1)
            }else if (cellValue4Array[indexPath.row]as! Int == 2){
                lable22 = "放电"
                cell.TitleLabel4.textColor=COLOR(_R: 222, _G: 211, _B: 91, _A: 1)
            }else if (cellValue4Array[indexPath.row]as! Int == 3){
                lable22 = "故障"
                cell.TitleLabel4.textColor=COLOR(_R: 241, _G: 86, _B: 82, _A: 1)
            }else if (cellValue4Array[indexPath.row]as! Int == 4){
                lable22 = "等待"
                cell.TitleLabel4.textColor=COLOR(_R: 17, _G: 183, _B: 243, _A: 1)
            }else{
                lable22 = "离线"
                cell.TitleLabel4.textColor=COLOR(_R: 153, _G: 153, _B: 153, _A: 1)
            }
            let lable2=NSString(format: "%@", lable22)
            cell.TitleLabel4.text=lable2 as String
            
        }
        
        let  lable2=NSString(format: "%@",cellValue2Array[indexPath.row]as!NSString)
        let  lable3=NSString(format: "%@",cellValue3Array[indexPath.row]as!NSString)
        
        
        
        cell.TitleLabel0.text=cellValue0Array[indexPath.row] as? String
        
        if lable1=="" {
            cell.TitleLabel1.text="--暂无--"
        }else{
         cell.TitleLabel1.text=lable1 as String
        }
        if lable2=="" {
            cell.TitleLabel2.text="--暂无--"
        }else{
         cell.TitleLabel2.text=lable2 as String
        }
        if lable3=="" {
            cell.TitleLabel3.text="--暂无--"
        }else{
               cell.TitleLabel3.text=lable3 as String?
        }
    

        
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
          let accessStatusNum=self.netAllDic["accessStatus"] as! Int
        
        if accessStatusNum==1{
            let CELL=cellValue5Array[indexPath.row] as! NSString
            
            let goView=deviceControlView()
            goView.netType=1
            goView.deviceTypeString=NSString(format: "%d", deviceType+1)
            goView.deviceSnString=CELL
            
            self.navigationController?.pushViewController(goView, animated: true)
        }

        if accessStatusNum==2{
        self.showToastView(withTitle: "暂无设备详情数据")
        }
        
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
