//
//  changUserInfo.swift
//  ShinePhone
//
//  Created by sky on 17/6/17.
//  Copyright © 2017年 sky. All rights reserved.
//

import UIKit

class changUserInfo: RootViewController,UITableViewDataSource,UITableViewDelegate {

     var cellNameArray:NSArray!
      var cellvalueArray:NSArray!
      var tableView:UITableView!
    var userListDic:NSDictionary!
          var netDic:NSDictionary!
        var netToDic:NSMutableDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 self.view.backgroundColor=MainColor
        
        cellNameArray=["修改真实姓名","修改邮箱","修改手机号","修改时区","修改公司名称","重置密码"]
        cellvalueArray=[userListDic["activeName"] as! NSString,userListDic["email"] as! NSString,userListDic["phoneNum"] as! NSString,userListDic["timeZone"] as! Int,userListDic["company"] as! NSString,""]
        
        self.initUI()
    }

    override func viewWillAppear(_ animated: Bool) {
         self.initNet0()
    }
    
    func initUI(){
        tableView=UITableView()
        let H1=0*HEIGHT_SIZE
        tableView.frame=CGRect(x: 0, y: H1, width: SCREEN_Width, height: SCREEN_Height-H1)
        tableView.delegate=self
        tableView.dataSource=self
        tableView.backgroundColor=MainColor
        tableView.separatorColor=UIColor.white;
        tableView.tableFooterView = UIView.init(frame: .zero);
        // tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        if(tableView.responds(to: #selector(setter: UIView.layoutMargins)))
        {
            tableView.layoutMargins = UIEdgeInsets.zero;
        }
        if tableView.responds(to: #selector(setter: UITableViewCell.separatorInset))
        {
            tableView.separatorInset =  UIEdgeInsets.zero;
        }
        self.view.addSubview(tableView)
        
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellNameArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50*HEIGHT_SIZE
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //  let  cell = UITableViewCell.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cell");
        
        let cellId = "default"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        
        if cell == nil {
            cell = UITableViewCell (style: UITableViewCellStyle.subtitle, reuseIdentifier: cellId)
        }
        cell?.backgroundColor=MainColor
        cell?.textLabel?.text = cellNameArray[indexPath.row] as? String
       
       cell?.detailTextLabel?.text=cellvalueArray[indexPath.row] as? String
        if indexPath.row==3 {
              cell?.detailTextLabel?.text=String(format: "%d", cellvalueArray[indexPath.row] as! Int)
        }
        
        cell?.textLabel?.font=UIFont.systemFont(ofSize: 14*HEIGHT_SIZE)
        cell?.detailTextLabel?.font=UIFont.systemFont(ofSize: 10*HEIGHT_SIZE)
        cell?.textLabel?.textColor=UIColor.white
          cell?.detailTextLabel?.textColor=UIColor.white
        cell?.accessoryType=UITableViewCellAccessoryType.disclosureIndicator
        
        if(cell!.responds(to: #selector(setter: UIView.layoutMargins)))
        {
            cell!.layoutMargins = UIEdgeInsets.zero;
        }
        if cell!.responds(to: #selector(setter: UITableViewCell.separatorInset))
        {
            cell!.separatorInset =  UIEdgeInsets.zero;
        }
        return cell!
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    //    if indexPath.row==0 || indexPath.row==1 || indexPath.row==2 || indexPath.row==3 || indexPath.row==4{
            
            let goView=changUserInfoTwo()
            goView.lableName=cellNameArray[indexPath.row] as! NSString
            goView.typeNum = indexPath.row
        if indexPath.row==3 {
              goView.lableValue=NSString(format: "%d", cellvalueArray[indexPath.row] as! Int)
        }
       
           goView.userName=userListDic["accountName"] as! NSString
            self.navigationController?.pushViewController(goView, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
       
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    func initNet0(){
        
    
    //   let netDic=["searchType":typeNum,"param":value1,"page":pageNum,"serverAddr":addressString]
        
        netToDic.setValue(0, forKeyPath: "searchType")
        netToDic.setValue(userListDic["accountName"], forKeyPath: "param")
        
        self.showProgressView()
        BaseRequest.request(withMethodResponseStringResult: OSS_HEAD_URL, paramars: netToDic as NSDictionary as Dictionary , paramarsSite: "/api/v1/search/all", sucessBlock: {(successBlock)->() in
            
            self.hideProgressView()
            let data:Data=successBlock as! Data
            
            let jsonDate0=try? JSONSerialization.jsonObject(with: data, options:[])
            
            if (jsonDate0 != nil){
                let jsonDate=jsonDate0 as! Dictionary<String, Any>
                print("/api/v1/search/all=",jsonDate)
                
                // let result:NSString=NSString(format:"%s",jsonDate["result"] )
                let result1=jsonDate["result"] as! Int
                
                if result1==1 {
                    var plantAll:NSArray=[]
                     let objArray=jsonDate["obj"] as! Dictionary<String, Any>
                      plantAll=objArray["userList"] as! NSArray
                    self.userListDic=plantAll[0] as! NSDictionary
                    
                    if (self.tableView == nil){
                        self.initUI()
                    }else{
                           self.cellvalueArray=[self.userListDic["activeName"] as! NSString,self.userListDic["email"] as! NSString,self.userListDic["phoneNum"] as! NSString,self.userListDic["timeZone"] as! Int,self.userListDic["company"] as! NSString,""]
                        self.tableView.reloadData()
                    }
                    
                }else{
                    
                    self.showToastView(withTitle: jsonDate["msg"] as! String!)
                }
                
            }
            
        }, failure: {(error) in
            self.hideProgressView()
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
