//
//  datalogerControlView.swift
//  ShinePhone
//
//  Created by sky on 17/5/24.
//  Copyright © 2017年 sky. All rights reserved.
//

import UIKit

class datalogerControlView: RootViewController,UITableViewDataSource,UITableViewDelegate{

      var tableView:UITableView!
      var cellNameArray:NSArray!
      var valueDic:NSDictionary!
        var snString:NSString!
     var  paramTypeString:NSString!
    var  value1:NSString!
    var  value2:NSString!
      var netDic:NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     self.view.backgroundColor=MainColor
      self.initUI()
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
        if indexPath.row==0 {
        //    cell?.detailTextLabel?.text=valueDic[""]
        }
        cell?.textLabel?.font=UIFont.systemFont(ofSize: 14*HEIGHT_SIZE)
         cell?.textLabel?.textColor=UIColor.white
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
        
        
        if indexPath.row==0 || indexPath.row==1 || indexPath.row==4{
            let goView=datalogerControlTwo()
            goView.lableName=cellNameArray[indexPath.row] as! NSString
            goView.typeNum = NSString(format: "%d", indexPath.row)
            goView.snString=self.snString
            self.navigationController?.pushViewController(goView, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
        }else if indexPath.row==2{
                self.initAlertView()
            
        }else if indexPath.row==3{
             self.initAlertView2()
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
  func initAlertView(){
    let alertController = UIAlertController(title: "是否重启采集器？", message: nil, preferredStyle:.alert)
    
    // 设置2个UIAlertAction
    let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
    let okAction = UIAlertAction(title: "确认", style: .default) { (UIAlertAction) in
        self.value1="1"
        self.value2=""
        self.paramTypeString="3"
        self.finishSet()
    }
    // 添加
    alertController.addAction(cancelAction)
    alertController.addAction(okAction)
    // 弹出
    self.present(alertController, animated: true, completion: nil)
 
    }
    
    func initAlertView2(){
        let alertController = UIAlertController(title: "是否清除采集器记录？", message: nil, preferredStyle:.alert)
        
        // 设置2个UIAlertAction
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "确认", style: .default) { (UIAlertAction) in
            self.value1="1"
            self.value2=""
            self.paramTypeString="4"
             self.finishSet()
        }
        // 添加
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        // 弹出
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    
    
    
    func finishSet(){
      

        netDic=["datalogSn":snString,"paramType":paramTypeString,"param_1":value1,"param_2":value2]
        self.showProgressView()
        BaseRequest.request(withMethodResponseStringResult: OSS_HEAD_URL, paramars: netDic as! [AnyHashable : Any]!, paramarsSite: "/api/v1/deviceSet/set/datalog", sucessBlock: {(successBlock)->() in
            self.hideProgressView()
            
            let data:Data=successBlock as! Data
            
            let jsonDate0=try? JSONSerialization.jsonObject(with: data, options:[])
            
            if (jsonDate0 != nil){
                let jsonDate=jsonDate0 as! Dictionary<String, Any>
                print("/api/v1/device/info",jsonDate)
                // let result:NSString=NSString(format:"%s",jsonDate["result"] )
                let result1=jsonDate["result"] as! Int
                
                if result1==1 {
                    
                    self.showToastView(withTitle: "设置成功")
                  //  self.navigationController!.popViewController(animated: true)
                    
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
