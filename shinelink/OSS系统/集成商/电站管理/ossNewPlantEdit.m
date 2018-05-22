//
//  ossNewPlantEdit.m
//  ShinePhone
//
//  Created by sky on 2018/5/22.
//  Copyright © 2018年 sky. All rights reserved.
//

#import "ossNewPlantEdit.h"
#import "ZJBLStoreShopTypeAlert.h"
#import "LRLChannelEditController.h"
#import "DTKDropdownMenuView.h"
#import "ShinePhone-Swift.h"
#import "AnotherSearchViewController.h"
#import "SNLocationManager.h"

@interface ossNewPlantEdit ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITabBarControllerDelegate>
@property (nonatomic, strong) UIButton *finishButton;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *twoView;
@property (nonatomic, strong) UIView *threeView;
@property (nonatomic, assign)float H1;
@property (nonatomic, strong) NSDictionary*langurageDic;
@property (nonatomic, strong) NSDictionary*passWordDic;
@property (nonatomic, strong) NSDictionary*emailDic;
@property (nonatomic, strong)NSMutableArray *textFieldMutableArray;
@property (nonatomic, strong)NSArray *name1Array;
@property (nonatomic, strong)NSArray *keyArray;
@property (nonatomic, strong) NSDictionary* allDic;
@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, strong) UIDatePicker *date;
@property (nonatomic, strong) NSDateFormatter *dayFormatter;
@property (nonatomic, strong) NSString *currentDay;
@property (nonatomic, strong) NSMutableArray *countryListArray;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *latitude;

@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIImageView *imageView2;
@property(nonatomic,strong)NSDictionary *dictData;
@property (nonatomic, strong) UIActionSheet *uploadImageActionSheet;
@property (nonatomic, strong) UIImagePickerController *cameraImagePicker;
@property (nonatomic, strong) UIImagePickerController *photoLibraryImagePicker;
@property (nonatomic, assign)NSInteger imageNum;
@property (nonatomic, strong) NSMutableDictionary*twoDic;

@end

@implementation ossNewPlantEdit

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUiForPlant];
}


-(void)initUiForPlant{
    

    
    self.title=@"修改电站";
    _H1=40*HEIGHT_SIZE;
    
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, ScreenHeight)];
    _scrollView.scrollEnabled=YES;
    _scrollView.backgroundColor=COLOR(242, 242, 242, 1);
    [self.view addSubview:_scrollView];
    
    _finishButton=  [UIButton buttonWithType:UIButtonTypeCustom];
    
    [_finishButton setBackgroundImage:IMAGE(@"workorder_button_icon_nor.png") forState:UIControlStateNormal];
    [_finishButton setBackgroundImage:IMAGE(@"workorder_button_icon_click.png") forState:UIControlStateHighlighted];
    [_finishButton setTitle:@"完成" forState:UIControlStateNormal];
    _finishButton.titleLabel.font=[UIFont systemFontOfSize: 14*HEIGHT_SIZE];
    [_finishButton addTarget:self action:@selector(finishSet) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_finishButton];
    
        float H2=0*HEIGHT_SIZE;
    
//    _twoView=[[UIView alloc]initWithFrame:CGRectMake(0, H2, SCREEN_Width, 850*HEIGHT_SIZE)];
//    _twoView.backgroundColor=COLOR(242, 242, 242, 1);
//    [_scrollView addSubview:_twoView];
    
    

    
    NSArray *name1Array=@[@"电站名称",@"别名",@"安装时间",@"设计功率(W)",@"国家",@"城市",@"时区",@"定位"];
    for (int i=0; i<name1Array.count; i++) {
  
        NSInteger type=0;
        if (i==2|| i==4 || i==6 || i==7) {
            type=1;
        }
        
        [self getUnitUI:name1Array[i] Hight:H2 type:type tagNum:3000+i firstView:_scrollView];
        
          H2=H2+_H1;
        
    }
    
    H2=H2+20*HEIGHT_SIZE;
    NSArray *name2Array=@[@"资金收益",@"收益单位",@"节约煤标准(kg)",@"C02减排",@"S02减排"];
    for (int i=0; i<name2Array.count; i++) {

        NSInteger type=0;
        if (i==1) {
            type=1;
        }
        
        [self getUnitUI:name2Array[i] Hight:H2 type:type tagNum:3000+i+name1Array.count firstView:_scrollView];
        
         H2=H2+_H1;
    }
    
    UILabel *lable0 = [[UILabel alloc] initWithFrame:CGRectMake(0*NOW_SIZE, H2,ScreenWidth, _H1/2.0)];
    lable0.textColor = COLOR(154, 154, 154, 1);
    lable0.backgroundColor=[UIColor whiteColor];
    lable0.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    lable0.textAlignment=NSTextAlignmentCenter;
    lable0.text=@"(以1kWh发电量为换算标准)";
    [_scrollView addSubview:lable0];
    
    H2=H2+_H1/2.0+20*HEIGHT_SIZE;
    
    NSArray *name3Array=@[@"电站图片",@"位置图片"];
    for (int i=0; i<name3Array.count; i++) {
        
        NSInteger type=1;

        [self getUnitUI:name3Array[i] Hight:H2 type:type tagNum:4000+i firstView:_scrollView];
        
        H2=H2+_H1;
    }
    
    _threeView=[[UIView alloc]initWithFrame:CGRectMake(0, H2, SCREEN_Width, 100*HEIGHT_SIZE)];
    _threeView.backgroundColor=[UIColor whiteColor];
    [_scrollView addSubview:_threeView];
    
        _finishButton.frame=CGRectMake(60*NOW_SIZE,_threeView.frame.origin.y+_threeView.frame.size.height+20*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
    
    float imageW=80*HEIGHT_SIZE;
      float H33=_threeView.frame.size.height;
       float W33=ScreenWidth/2.0;
    _imageView=[[UIImageView alloc]initWithFrame:CGRectMake((W33-imageW)/2.0, (H33-imageW)/2.0, imageW, imageW)];
    _imageView.contentMode=UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds=YES;
    [_threeView addSubview:_imageView];
    
    _imageView2=[[UIImageView alloc]initWithFrame:CGRectMake(W33+(W33-imageW)/2.0, (H33-imageW)/2.0, imageW, imageW)];
    _imageView2.contentMode=UIViewContentModeScaleAspectFill;
    _imageView2.clipsToBounds=YES;
    [_threeView addSubview:_imageView2];
    
    _scrollView.contentSize=CGSizeMake(ScreenWidth, _finishButton.frame.origin.y+_finishButton.frame.size.height+100*HEIGHT_SIZE);
    
    
    
}




-(void)getUnitUI:(NSString*)name Hight:(float)Hight type:(NSInteger)type tagNum:(NSInteger)tagNum firstView:(UIView*)firstView{
    float W1=8*NOW_SIZE;
    
    UIView *V011 = [[UIView alloc]initWithFrame:CGRectMake(0*NOW_SIZE,Hight, SCREEN_Width,_H1)];
    V011.backgroundColor =[UIColor whiteColor];
    [firstView addSubview:V011];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE,2*HEIGHT_SIZE+Hight, W1, _H1)];
    label.text=@"*";
    label.textAlignment=NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:18*HEIGHT_SIZE];
    label.textColor=COLOR(154, 154, 154, 1);
    //    if ((type==0) || (type==1)) {
    //        [firstView addSubview:label];
    //    }
    //
    
    NSString *nameString=[NSString stringWithFormat:@"%@:",name];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:14*HEIGHT_SIZE] forKey:NSFontAttributeName];
    CGSize size = [nameString boundingRectWithSize:CGSizeMake(MAXFLOAT, _H1) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(10*NOW_SIZE+W1, Hight,size.width, _H1)];
    lable1.textColor = COLOR(154, 154, 154, 1);
    lable1.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    lable1.textAlignment=NSTextAlignmentLeft;
    lable1.text=nameString;
    [firstView addSubview:lable1];
    
    UIView *V01 = [[UIView alloc]initWithFrame:CGRectMake(10*NOW_SIZE,_H1+Hight-1*HEIGHT_SIZE, SCREEN_Width-(2*10*NOW_SIZE),1*HEIGHT_SIZE)];
    V01.backgroundColor = COLOR(222, 222, 222, 1);
    [firstView addSubview:V01];
    
    float WK1=5*NOW_SIZE;
    float W_image1=6*HEIGHT_SIZE;
    float H_image1=12*HEIGHT_SIZE;
    float W2=SCREEN_Width-(10*NOW_SIZE+W1+size.width+WK1)-10*NOW_SIZE;
    
    if (type==1 || type==2) {
        
        UIView *V0= [[UIView alloc]initWithFrame:CGRectMake(10*NOW_SIZE+W1+size.width+WK1,Hight, W2,_H1)];
        V0.backgroundColor = [UIColor clearColor];
        V0.userInteractionEnabled=YES;
        V0.tag=tagNum;
        UITapGestureRecognizer *labelTap1;
        labelTap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectChioce:)];
        [V0 addGestureRecognizer:labelTap1];
        [firstView addSubview:V0];
        
        UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,W2-W_image1-WK1, _H1)];
        lable1.textColor = COLOR(51, 51, 51, 1);
        lable1.tag=tagNum+100;
        lable1.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        lable1.textAlignment=NSTextAlignmentLeft;
        lable1.userInteractionEnabled=YES;
        [V0 addSubview:lable1];
        
        UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(W2-W_image1, (_H1-H_image1)/2, W_image1,H_image1 )];
        image2.userInteractionEnabled=YES;
        image2.image=IMAGE(@"select_icon.png");
        [V0 addSubview:image2];
        
    }else{
        UITextField *text1 = [[UITextField alloc] initWithFrame:CGRectMake(10*NOW_SIZE+W1+size.width+WK1, Hight, W2, _H1)];
        text1.textColor =  COLOR(51, 51, 51, 1);
        text1.tintColor =  COLOR(51, 51, 51, 1);
        text1.tag=tagNum+100;
        text1.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [firstView addSubview:text1];
        
        [_textFieldMutableArray addObject:text1];
    }
    
}


-(void)selectChioce:(UITapGestureRecognizer*)tap{
    NSInteger Num=tap.view.tag;
    

    
    if (Num==3002 ){
        [self pickDate];
    }
    
    if (Num==3004 ){
        [self choiceTheCountry];
    }
    if (Num==3007 ){
        [self getTheLocation];
    }
    
    if (Num==3006 || Num==3009) {
        [self choiceTheValue:Num];
    }
    
    if (Num==4000 || Num==4001){
       [self choiceTheImage:Num];
    }
    
}

-(void)choiceTheImage:(NSInteger)Num{
        _imageNum=Num;
    [self selectImageButtonPressed];
   
}

-(void)choiceTheValue:(NSInteger)Num{
    NSArray *nameArray;NSString *title;
    if (Num==3006) {
        title=@"选择时区";
        nameArray=[NSArray arrayWithObjects:@"+1",@"+2",@"+3",@"+4",@"+5",@"+6",@"+7",@"+8",@"+9",@"+10",@"+11",@"+12",@"-1",@"-2",@"-3",@"-4",@"-5",@"-6",@"-7",@"-8",@"-9",@"-10",@"-11",@"-12", nil];
        
    }else if (Num==3008) {
   
    }
    
    
    
    [ZJBLStoreShopTypeAlert showWithTitle:title titles:nameArray selectIndex:^(NSInteger selectIndex) {
        
    }selectValue:^(NSString *selectValue){
        UILabel *lable=[self.view viewWithTag:Num+100];
        lable.text=selectValue;
        
    } showCloseButton:YES ];
}




-(void)getTheLocation{
    [[SNLocationManager shareLocationManager] startUpdatingLocationWithSuccess:^(CLLocation *location, CLPlacemark *placemark) {
        _longitude=[NSString stringWithFormat:@"%.2f", location.coordinate.longitude];
        _latitude=[NSString stringWithFormat:@"%.2f", location.coordinate.latitude];
        NSString* _city=placemark.locality;
        //   NSString* _countryGet=placemark.country;
        
        NSString *lableText=[NSString stringWithFormat:@"%@(%@,%@)",_city,_longitude,_latitude];
        UILabel *lable=[self.view viewWithTag:3007+100];
        lable.text=lableText;
        
    } andFailure:^(CLRegion *region, NSError *error) {
        
    }];
}




-(void)pickDate{
    // float buttonSize=70*HEIGHT_SIZE;
    _date=[[UIDatePicker alloc]initWithFrame:CGRectMake(0*NOW_SIZE, SCREEN_Height-300*HEIGHT_SIZE, SCREEN_Width, 300*HEIGHT_SIZE)];
    _date.backgroundColor=[UIColor whiteColor];
    _date.datePickerMode=UIDatePickerModeDateAndTime;
    [self.view addSubview:_date];
    
    if (self.toolBar) {
        [UIView animateWithDuration:0.3f animations:^{
            self.toolBar.alpha = 1;
            self.toolBar.frame = CGRectMake(0, SCREEN_Height-300*HEIGHT_SIZE-44*HEIGHT_SIZE, SCREEN_Width, 44*HEIGHT_SIZE);
            [self.view addSubview:_toolBar];
        }];
    } else {
        self.toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, SCREEN_Height-300*HEIGHT_SIZE-44*HEIGHT_SIZE, SCREEN_Width, 44*HEIGHT_SIZE)];
        self.toolBar.barStyle = UIBarStyleDefault;
        self.toolBar.barTintColor = MainColor;
        [self.view addSubview:self.toolBar];
        
        UIBarButtonItem *spaceButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(removeToolBar)];
        
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(completeSelectDate:)];
        
        UIBarButtonItem *flexibleitem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:(UIBarButtonSystemItemFlexibleSpace) target:self action:nil];
        
        spaceButton.tintColor=[UIColor whiteColor];
        doneButton.tintColor=[UIColor whiteColor];
        
        //           [doneButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14*HEIGHT_SIZE],NSFontAttributeName, nil] forState:UIControlStateNormal];
        //
        //        doneButton.tintColor = [UIColor whiteColor];
        self.toolBar.items = @[spaceButton,flexibleitem,doneButton];
    }
    
}


-(void)removeToolBar{
    [self.toolBar removeFromSuperview];
    [self.date removeFromSuperview];
    
}


- (void)completeSelectDate:(UIToolbar *)toolBar {
    self.dayFormatter = [[NSDateFormatter alloc] init];
    [self.dayFormatter setDateFormat:@"yyyy-MM-dd"];
    self.currentDay = [self.dayFormatter stringFromDate:self.date.date];
    UILabel *lable=[self.view viewWithTag:3002+100];
    lable.text=_currentDay;
    
    [self.toolBar removeFromSuperview];
    [self.date removeFromSuperview];
    
}



-(void)choiceTheCountry{
    _countryListArray=[NSMutableArray array];
    [self netForCountry];
}


-(void)netForCountry{
    
    
    
    [self showProgressView];
    [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL_Demo_CN paramars:@{@"admin":@"admin"} paramarsSite:@"/newCountryCityAPI.do?op=getCountryCity" sucessBlock:^(id content) {
        [self hideProgressView];
        NSLog(@"getCountryCity: %@", content);
        if (content) {
            NSArray *dataDic=[NSArray arrayWithArray:content];
            if (dataDic.count>0) {
                for (int i=0; i<dataDic.count; i++) {
                    NSString *DY=[NSString stringWithFormat:@"%@",content[i][@"country"]];
                    [ _countryListArray addObject:DY];
                }
                
                [_countryListArray sortUsingComparator:^NSComparisonResult(__strong id obj1,__strong id obj2){
                    NSString *str1=(NSString *)obj1;
                    NSString *str2=(NSString *)obj2;
                    return [str1 compare:str2];
                }];
                
                [_countryListArray insertObject:@"A1_中国" atIndex:0];
                [self choiceTheCountry2];
            }else{
                
                [self hideProgressView];
                [self showToastViewWithTitle:root_Networking];
                
            }
            
            
            
        }
        
    } failure:^(NSError *error) {
        [self hideProgressView];
        
    }];
    
    
}

-(void)finishSet{
    
//    NSArray *name1Array=@[@"电站名称",@"别名",@"安装时间",@"设计功率(W)",@"国家",@"城市",@"时区",@"定位"];
//    NSArray *name2Array=@[@"资金收益",@"收益单位",@"节约煤标准(kg)",@"C02减排",@"S02减排"];
 
    
    NSArray*keyArray=@[@"plantName",@"alias",@"addDate",@"designPower",@"country",@"city",@"timezone",@"wd",@"zjsy",@"zjsy_uint",@"coal",@"co2",@"so2"];
    
    
    
    _twoDic=[NSMutableDictionary new];
    for (int i=0; i<keyArray.count; i++) {
        if (i==2 || i==4 || i==6 || i==7 || i==9) {
            UILabel *lable=[self.view viewWithTag:3100+i];
            if ([lable.text isEqualToString:@""] || lable.text==nil) {
                [_twoDic setObject:@"" forKey:keyArray[i]];
            }else{
                [_twoDic setObject:lable.text forKey:keyArray[i]];
            }
            if (i==4) {
                if ([lable.text isEqualToString:@"A1_中国"] || [lable.text containsString:@"中国"]) {
                    [_twoDic setObject:@"China" forKey:keyArray[i]];
                }
            }
        }else{
            UITextField *field=[self.view viewWithTag:3100+i];
            if ([field.text isEqualToString:@""] || field.text==nil) {
                [_twoDic setObject:@"" forKey:keyArray[i]];
            }else{
                [_twoDic setObject:field.text forKey:keyArray[i]];
            }
            
        }
        
    }
    
    [_twoDic setObject:_userName forKey:@"userName"];
    [_twoDic setObject:_plantId forKey:@"plantId"];
        [_twoDic setObject:_serverId forKey:@"serverId"];
    [_twoDic setObject:_latitude forKey:@"wd"];
    [_twoDic setObject:_longitude forKey:@"jd"];
    
    
       UILabel *lable40=[self.view viewWithTag:4000+100];
    UILabel *lable41=[self.view viewWithTag:4001+100];
        NSMutableDictionary *dataImageDict = [NSMutableDictionary dictionary];
    if ([lable40.text isEqualToString:@""] || lable40.text==nil) {
     //     [dataImageDict setObject:@"" forKey:@"file1"];
    }else{
          NSData *imageData = UIImageJPEGRepresentation(_imageView.image, 0.5);
            [dataImageDict setObject:imageData forKey:@"file1"];
    }
    if ([lable41.text isEqualToString:@""] || lable41.text==nil) {
     //   [dataImageDict setObject:@"" forKey:@"file2"];
    }else{
        NSData *imageData = UIImageJPEGRepresentation(_imageView2.image, 0.5);
        [dataImageDict setObject:imageData forKey:@"file2"];
    }
    


    
    
    [BaseRequest uplodImageWithMethod:OSS_HEAD_URL paramars:_twoDic paramarsSite:@"/api/v3/customer/plantManage/edit" dataImageDict:dataImageDict sucessBlock:^(id content) {
        
        id  content1= [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"/api/v3/device/getAPPDisPlants: %@", content1);
        
        NSString *res = [[NSString alloc] initWithData:content encoding:NSUTF8StringEncoding];
        if ([res rangeOfString:@"true"].location == NSNotFound) {
            [self showToastViewWithTitle:root_Modification_fails];
            
        } else {
            [self showToastViewWithTitle:root_Successfully_modified];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {
        [self hideProgressView];
        [self showToastViewWithTitle:root_Networking];
    }];
    
}

-(void)choiceTheCountry2{
    if(_countryListArray.count>0){
        
        AnotherSearchViewController *another = [AnotherSearchViewController new];
        //返回选中搜索的结果
        [another didSelectedItem:^(NSString *item) {
            UILabel *lable=[self.view viewWithTag:3004+100];
            lable.text=item;
        }];
        another.title =@"选择国家";
        another.dataSource=_countryListArray;
        [self.navigationController pushViewController:another animated:YES];
    }else{
        [self showToastViewWithTitle:@"重新点击获取国家列表"];
        return;
    }
}



-(void)selectImageButtonPressed{
    
    NSLog(@"取照片");
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil
                                                                              message: nil
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    //添加Button
    [alertController addAction: [UIAlertAction actionWithTitle: root_paiZhao style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //处理点击拍照
        self.cameraImagePicker = [[UIImagePickerController alloc] init];
        self.cameraImagePicker.allowsEditing = YES;
        self.cameraImagePicker.delegate = self;
        self.cameraImagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:_cameraImagePicker animated:YES completion:nil];
        
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: root_xiangkuang_xuanQu style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        //处理点击从相册选取
        self.photoLibraryImagePicker = [[UIImagePickerController alloc] init];
        self.photoLibraryImagePicker.allowsEditing = YES;
        self.photoLibraryImagePicker.delegate = self;
        self.photoLibraryImagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:_photoLibraryImagePicker animated:YES completion:nil];
        
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: root_cancel style: UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController: alertController animated: YES completion: nil];
    
    

}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet == _uploadImageActionSheet) {
        //拍照
        if (buttonIndex == 0) {
            self.cameraImagePicker = [[UIImagePickerController alloc] init];
            self.cameraImagePicker.allowsEditing = YES;
            self.cameraImagePicker.delegate = self;
            self.cameraImagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:_cameraImagePicker animated:YES completion:nil];
        }
        //从相册选择
        if (buttonIndex == 1) {
            
            self.photoLibraryImagePicker = [[UIImagePickerController alloc] init];
            self.photoLibraryImagePicker.allowsEditing = YES;
            self.photoLibraryImagePicker.delegate = self;
            self.photoLibraryImagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:_photoLibraryImagePicker animated:YES completion:nil];
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = info[@"UIImagePickerControllerEditedImage"];
    if (_imageNum==4000) {
          _imageView.image=image;
        UILabel *lable=[self.view viewWithTag:4000+100];
        lable.text=@"已选择电站图片";
    }
    if (_imageNum==4001) {
        _imageView2.image=image;
        UILabel *lable=[self.view viewWithTag:4001+100];
        lable.text=@"已选择位置图片";
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
