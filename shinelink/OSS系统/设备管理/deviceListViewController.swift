//
//  deviceListViewController.swift
//  ShinePhone
//
//  Created by sky on 17/5/20.
//  Copyright © 2017年 sky. All rights reserved.
//

import UIKit

class deviceListViewController: RootViewController,UITableViewDataSource,UITableViewDelegate {
   var view1:UIView!
       var tableView:UITableView!
    var cellNameArray:NSArray!
    var cellValue0Array:NSArray!
    var cellValue1Array:NSArray!
    var cellValue2Array:NSArray!
    var cellValue3Array:NSArray!
       var cellValue4Array:NSArray!
       var cellValue5Array:NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()

      self.initUI()
    }

    func initUI(){
        //采集器1  逆变器2 储能机3
        
        cellNameArray=["序列号","状态","所属采集器序列号","采集器类型","设备类型"];
        cellValue0Array=["采集器","逆变器","储能机"];
        cellValue1Array=["我是序列号","SSSSSS","HHHHHH","HHHHHH","HHHHHH"];
          cellValue2Array=["我是别名","SSSSSS","HHHHHH","HHHHHH","HHHHHH"];
         cellValue3Array=["我是状态","SSSSSS","HHHHHH","HHHHHH","HHHHHH"];
         cellValue4Array=["1","1","2","2","3"];
          cellValue5Array=["我是采集器类型","我是采集器类型","我是所属采集器序列号","我是所属采集器序列号","我是所属采集器序列号"];
        
       let buttonView=uibuttonView0()
        buttonView.frame=CGRect(x: 0*NOW_SIZE, y: 0*HEIGHT_SIZE, width: SCREEN_Width, height: 30*HEIGHT_SIZE)
        buttonView.isUserInteractionEnabled=true
        buttonView.backgroundColor=backgroundGrayColor
        buttonView.buttonArray=["采集器","逆变器","储能机"]
        buttonView.initUI()
        self.view .addSubview(buttonView)
        
        tableView=UITableView()
        let H1=35*HEIGHT_SIZE
        tableView.frame=CGRect(x: 0, y: H1, width: SCREEN_Width, height: SCREEN_Height-H1)
        tableView.delegate=self
        tableView.dataSource=self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.register(deviceListCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
    
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellValue1Array.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 96*HEIGHT_SIZE
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //  let  cell = UITableViewCell.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cell");
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as!deviceListCell
        let lable1=NSString(format: "%@%@", cellNameArray[0]as!NSString,cellValue1Array[indexPath.row]as!NSString)
        let lable2=NSString(format: "%@%@", cellNameArray[1]as!NSString,cellValue3Array[indexPath.row]as!NSString)
        let lable3:NSString!
          var lable4:NSString!
        
        if cellValue4Array[indexPath.row] as? Int==1{
           lable3=NSString(format: "%@%@", cellNameArray[3]as!NSString,cellValue2Array[indexPath.row]as!NSString)
             lable4=NSString(format: "%@%@", cellNameArray[4]as!NSString,cellValue0Array[0]as!NSString)
        }else{
          lable3=NSString(format: "%@%@", cellNameArray[2]as!NSString,cellValue2Array[indexPath.row]as!NSString)
            if cellValue4Array[indexPath.row] as? Int==2{
             lable4=NSString(format: "%@%@", cellNameArray[4]as!NSString,cellValue0Array[1]as!NSString)
            }
            if cellValue4Array[indexPath.row] as? Int==3{
                 lable4=NSString(format: "%@%@", cellNameArray[4]as!NSString,cellValue0Array[2]as!NSString)
            }
        }
        
       
         cell.TitleLabel0.text=cellValue2Array[indexPath.row] as? String
        
        cell.TitleLabel1.text=lable1 as String
        cell.TitleLabel2.text=lable2 as String
         cell.TitleLabel3.text=lable3 as String?
            cell.TitleLabel4.text=lable4 as String?
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let goView=deviceListViewController()
        self.navigationController?.pushViewController(goView, animated: true)
        
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
