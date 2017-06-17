//
//  PlantList.swift
//  ShinePhone
//
//  Created by sky on 17/6/9.
//  Copyright © 2017年 sky. All rights reserved.
//

import UIKit

class PlantList: RootViewController,UITableViewDataSource,UITableViewDelegate {

      var userNameString:NSString!
      var pageNum:Int!
       var netDic:NSDictionary!
    var userListDic:NSDictionary!
      var cellNameArray:NSArray!
     var cellValue1Array:NSMutableArray!
      var cellValue2Array:NSMutableArray!
      var cellValue3Array:NSMutableArray!
      var cellValue4Array:NSMutableArray!
    var cellValueIDArray:NSMutableArray!
    var plantListArray:NSMutableArray!
    var tableView:UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageNum=0;

        let rightItem=UIBarButtonItem.init(title: "修改用户信息", style: .plain, target: self, action:#selector(changeUserInfo) )
        self.navigationItem.rightBarButtonItem=rightItem

        
    self.initNet0()
    }

    func changeUserInfo(){
        let goView=changUserInfo()
      goView.userListDic=self.userListDic
        self.navigationController?.pushViewController(goView, animated: true)
    }
    
    
    func initNet0(){
        cellValue1Array=[]
        cellValue2Array=[]
        cellValue3Array=[]
        cellValue4Array=[]
         cellValueIDArray=[]
        plantListArray=[]
        
    self.initNet()
    }
    
    func initTableView(){
        
        cellNameArray=["电站名:","时区:"]
        
        tableView=UITableView()
        let H1=30*HEIGHT_SIZE
        tableView.frame=CGRect(x: 0, y: 0, width: SCREEN_Width, height: SCREEN_Height-H1)
        tableView.delegate=self
        tableView.dataSource=self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.register(plantListCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
        
        let foot=MJRefreshAutoNormalFooter(refreshingBlock: {
            
            self.pageNum=self.pageNum+1
            self.initNet()
            
            //结束刷新
            self.tableView!.mj_footer.endRefreshing()
        })
        
        tableView.mj_footer=foot
        foot?.setTitle("", for: .idle)
        
        
    }
    
    func initNet(){
        

        netDic=["userName":userNameString,"page":pageNum]
        self.showProgressView()
        BaseRequest.request(withMethodResponseStringResult: OSS_HEAD_URL, paramars: netDic as! [AnyHashable : Any]!, paramarsSite: "/api/v1/search/user_plant_list", sucessBlock: {(successBlock)->() in
            self.hideProgressView()
            
            let data:Data=successBlock as! Data
            
            let jsonDate0=try? JSONSerialization.jsonObject(with: data, options:[])
            
            if (jsonDate0 != nil){
                let jsonDate=jsonDate0 as! Dictionary<String, Any>
                print("/api/v1/search/user_plant_list=",jsonDate)
                // let result:NSString=NSString(format:"%s",jsonDate["result"] )
                let result1=jsonDate["result"] as! Int
                
                if result1==1 {
                    let objArray=jsonDate["obj"] as! Dictionary<String, Any>
                  
                    var plantAll:NSArray=[]
                     plantAll=objArray["plantList"] as! NSArray
                      for i in 0..<plantAll.count{
                      self.cellValue1Array.add((plantAll[i] as! NSDictionary)["plantName"] as!NSString)
                          self.cellValue2Array.add((plantAll[i] as! NSDictionary)["timezoneText"] as!NSString)
                      
                          let idString=NSString(format: "%d", (plantAll[i] as! NSDictionary)["id"]  as! Int)
                        self.cellValueIDArray.add(idString)
                        self.plantListArray.add(plantAll[i])
                    }
                    
                    
//                    if self.plantListArray.count==1 {
//                        let goView=deviceListViewController()
//                        goView.plantIdString=self.cellValueIDArray.object(at: 0) as!NSString
//                        self.navigationController?.pushViewController(goView, animated: false)
//                        
//                    }
                    
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
        return plantListArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 42*HEIGHT_SIZE
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //  let  cell = UITableViewCell.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cell");
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as!plantListCell
        
        let lable1=NSString(format: "%@%@", cellNameArray[0]as!NSString,self.cellValue1Array.object(at: indexPath.row) as! CVarArg)
        let lable2=NSString(format: "%@%@", cellNameArray[1]as!NSString,self.cellValue2Array.object(at: indexPath.row) as! CVarArg)
        
        cell.TitleLabel1.text=lable1 as String
        cell.TitleLabel2.text=lable2 as String
        
        
        cell.accessoryType=UITableViewCellAccessoryType.disclosureIndicator
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

            let goView=deviceListViewController()
            
            goView.plantIdString=self.cellValueIDArray.object(at: indexPath.row) as!NSString
            
            
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
