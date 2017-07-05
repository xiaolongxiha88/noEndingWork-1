//
//  orderCellTwo.h
//  ShinePhone
//
//  Created by sky on 2017/6/29.
//  Copyright © 2017年 sky. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Model;

@interface orderCellTwo : UITableViewCell<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property(nonatomic,strong) UIView *titleView;
@property(nonatomic,strong)UIView *View3;
@property(nonatomic,strong)UIView *View5;

@property(nonatomic, strong) Model *model;

@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UIImageView *titleImage;
@property(nonatomic,strong)UITextField* textfield;
@property(nonatomic,strong) UIButton *goBut;

@property(nonatomic,strong) UILabel *contentLabel;
@property(nonatomic,strong) UIButton *moreTextBtn;
@property(nonatomic, assign) BOOL isShowMoreText;

@property(nonatomic,strong)NSString *titleString;
@property(nonatomic,strong)NSString *contentString;
@property(nonatomic)CGFloat cellFirstH;
@property(nonatomic,strong)NSString *statusString;
@property(nonatomic,strong)NSString *orderID;
@property(nonatomic,strong)NSDictionary *allValueDic;
@property (nonatomic, strong) NSMutableArray *picArray;
@property (nonatomic, strong) NSMutableArray *picArray2;
@property(nonatomic,strong)NSString *orderType;
@property(nonatomic,strong)NSString *deviceType;
@property(nonatomic,strong)NSString *latitude;//纬度
@property(nonatomic,strong)NSString *longitude;
@property(nonatomic,strong)NSString *city;
@property(nonatomic,strong)NSString *country;
@property(nonatomic,strong)NSString *countryGet;
@property (nonatomic, strong) UIImagePickerController *cameraImagePicker;
@property (nonatomic, strong) UIImagePickerController *photoLibraryImagePicker;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSDateFormatter *dayFormatter;
@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, strong) UIDatePicker *date;
@property(nonatomic,strong)NSString *goTimeString;

@property(nonatomic,strong)UITextView* textfield2;

@property(nonatomic, copy) void(^showMoreBlock)(UITableViewCell *currentCell);


@property (nonatomic, strong) UIImageView *image1;
@property (nonatomic, strong) UIImageView *image2;
@property (nonatomic, strong) UIImageView *image3;
@property (nonatomic, strong) UIImageView *image4;
@property (nonatomic, strong) UIImageView *image5;
@property (nonatomic, strong) UIImageView *image6;
@property (nonatomic, strong) UIImageView *image7;
@property (nonatomic, strong) UIImageView *image8;
@property (nonatomic, strong) UIImageView *image9;
@property (nonatomic, strong) UIImageView *image10;
@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;
@property (nonatomic, strong) UIButton *button3;
@property (nonatomic, strong) UIButton *button4;
@property (nonatomic, strong) UIButton *button5;
@property (nonatomic, strong) UIButton *button6;
@property (nonatomic, strong) UIButton *button7;
@property (nonatomic, strong) UIButton *button8;
@property (nonatomic, strong) UIButton *button9;
@property (nonatomic, strong) UIButton *button10;
@property(nonatomic,strong)UIView *imageViewAll;
@property(nonatomic,strong)UIView *imageViewAll2;
@property(nonatomic,strong) NSString*picGetType;
@property(nonatomic,strong)NSString *remarkString;

/**
 默认高度
 
 @param model 模型
 @return 默认高度
 */
+ (CGFloat)defaultHeight;

/**
 展开高度
 
 @param model 模型
 @return 展开高度
 */

+ (CGFloat)moreHeight:(CGFloat) navigationH status:(NSString*)status remarkH:(CGFloat) remarkH;
@end
