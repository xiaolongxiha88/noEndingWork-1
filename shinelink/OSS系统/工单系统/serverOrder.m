//
//  serverOrder.m
//  ShinePhone
//
//  Created by sky on 17/6/20.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "serverOrder.h"
    #import "moreBigImage.h"

@interface serverOrder ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic,strong)UIView *imageViewAll;
@property (nonatomic, strong) UIImageView *image1;
@property (nonatomic, strong) UIImageView *image2;
@property (nonatomic, strong) UIImageView *image3;
@property (nonatomic, strong) UIImageView *image4;
@property (nonatomic, strong) UIImageView *image5;
@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;
@property (nonatomic, strong) UIButton *button3;
@property (nonatomic, strong) UIButton *button4;
@property (nonatomic, strong) UIButton *button5;
@property (nonatomic, strong) UIImagePickerController *cameraImagePicker;
@property (nonatomic, strong) UIImagePickerController *photoLibraryImagePicker;
@property (nonatomic, strong) NSMutableArray *picArray;


@end

@implementation serverOrder

- (void)viewDidLoad {
    [super viewDidLoad];

    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithTitle:@"上传" style:UIBarButtonItemStylePlain target:self action:@selector(addimage)];
    self.navigationItem.rightBarButtonItem=rightItem;
    
     _picArray=[NSMutableArray array];
    
    [self initUI];
}


-(void)initUI{
    float  imageViewH=40*HEIGHT_SIZE;

  float  H1=[[UIApplication sharedApplication] statusBarFrame].size.height+self.navigationController.navigationBar.frame.size.height;
    
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height-imageViewH-H1)];
    _scrollView.backgroundColor=[UIColor clearColor];
    _scrollView.userInteractionEnabled=YES;
    [self.view addSubview:_scrollView];
    
    
    _imageViewAll = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_Height-imageViewH-H1, SCREEN_Width,imageViewH )];
    _imageViewAll.backgroundColor =COLOR(242, 242, 242, 1);
    _imageViewAll.userInteractionEnabled = YES;
    [self.view addSubview:_imageViewAll];
    
    UIView *VI = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_Width-imageViewH-10*NOW_SIZE, 0*HEIGHT_SIZE, imageViewH,imageViewH )];
    VI.backgroundColor =[UIColor clearColor];
    VI.userInteractionEnabled = YES;
    UITapGestureRecognizer * forget1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(controlPhoto)];
    [VI addGestureRecognizer:forget1];
    [_imageViewAll addSubview:VI];
    
    UIImageView *image4=[[UIImageView alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 10*HEIGHT_SIZE, 20*HEIGHT_SIZE,20*HEIGHT_SIZE )];
    image4.userInteractionEnabled = YES;
    image4.image = IMAGE(@"pic_icon.png");
    [VI addSubview:image4];
    
}

-(void)addimage{
    NSMutableDictionary *dataImageDict = [NSMutableDictionary dictionary];
    
    NSMutableArray *picAll=[NSMutableArray arrayWithArray:_picArray];
    [picAll removeObject:@"del"];
    for (int i=0; i<picAll.count; i++) {
        NSData *imageData = UIImageJPEGRepresentation(picAll[i], 0.5);
        NSString *imageName=[NSString stringWithFormat:@"image%d",i+1];
        [dataImageDict setObject:imageData forKey:imageName];
    }
    
}


-(void)controlPhoto{
    // [_picArray removeObject:@"del"];
    
    if (_image1 &&_image2 &&_image3 &&_image4 &&_image5) {
        [self showAlertViewWithTitle:nil message:@"最多上传5张图片" cancelButtonTitle:root_Yes];
    }else{
        
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
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[@"UIImagePickerControllerEditedImage"];
    
   
    
    float imageH=200*NOW_SIZE;  float imageX=(SCREEN_Width-imageH)/2; float buttonX=(SCREEN_Width+imageH)/2;float ButtonImage=18*HEIGHT_SIZE;
    float firstH=20*HEIGHT_SIZE; float sizeTT=imageH+30*HEIGHT_SIZE;
    
    _scrollView.contentSize=CGSizeMake(SCREEN_Width, 30+sizeTT*5);
    
    if(!_image1){
        [_picArray insertObject:image atIndex:0];
        _image1=[[UIImageView alloc]initWithFrame:CGRectMake(imageX, firstH, imageH,imageH )];
        _image1.userInteractionEnabled = YES;
        _image1.image = image;
        _image1.tag=1+3000;
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moreBigImage:)];
        [_image1 addGestureRecognizer:tap1];
        [_scrollView addSubview:_image1];
        
        _button1= [[UIButton alloc] initWithFrame:CGRectMake(buttonX-ButtonImage/2, firstH-ButtonImage/2, ButtonImage,ButtonImage)];
        [_button1 setImage:IMAGE(@"cancel_icon111.png") forState:UIControlStateNormal];
        _button1.tag=2000+1;
        [_button1 addTarget:self action:@selector(delPicture:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:_button1];
        
    }else if(_image1 && !_image2){
        [_picArray insertObject:image atIndex:1];
        _image2=[[UIImageView alloc]initWithFrame:CGRectMake(imageX, firstH+sizeTT, imageH,imageH )];
        _image2.userInteractionEnabled = YES;
        _image2.image = image;
        _image2.tag=2+3000;
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moreBigImage:)];
        [_image2 addGestureRecognizer:tap1];
        [_scrollView addSubview:_image2];
        
        _button2= [[UIButton alloc] initWithFrame:CGRectMake(buttonX-ButtonImage/2, firstH-ButtonImage/2+sizeTT, ButtonImage,ButtonImage)];
        [_button2 setImage:IMAGE(@"cancel_icon111.png") forState:UIControlStateNormal];
        _button2.tag=2000+2;
        // _button2.titleLabel.font=[UIFont systemFontOfSize: 10*HEIGHT_SIZE];
        [_button2 addTarget:self action:@selector(delPicture:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:_button2];
        
    }else if(_image1 && _image2 && !_image3){
        [_picArray insertObject:image atIndex:2];
        _image3=[[UIImageView alloc]initWithFrame:CGRectMake(imageX, firstH+sizeTT*2, imageH,imageH )];
        _image3.userInteractionEnabled = YES;
        _image3.image = image;
        _image3.tag=3+3000;
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moreBigImage:)];
        [_image3 addGestureRecognizer:tap1];
        [_scrollView addSubview:_image3];
        
        _button3= [[UIButton alloc] initWithFrame:CGRectMake(buttonX-ButtonImage/2, firstH-ButtonImage/2+sizeTT*2, ButtonImage,ButtonImage)];
        [_button3 setImage:IMAGE(@"cancel_icon111.png") forState:UIControlStateNormal];
        _button3.tag=2000+3;
        //  _button3.titleLabel.font=[UIFont systemFontOfSize: 10*HEIGHT_SIZE];
        [_button3 addTarget:self action:@selector(delPicture:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:_button3];
    }else if(_image1 && _image2 && _image3 && !_image4){
        [_picArray insertObject:image atIndex:3];
        _image4=[[UIImageView alloc]initWithFrame:CGRectMake(imageX, firstH+sizeTT*3, imageH,imageH )];
        _image4.userInteractionEnabled = YES;
        _image4.image = image;
        _image4.tag=4+3000;
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moreBigImage:)];
        [_image4 addGestureRecognizer:tap1];
        [_scrollView addSubview:_image4];
        
        _button4= [[UIButton alloc] initWithFrame:CGRectMake(buttonX-ButtonImage/2, firstH-ButtonImage/2+sizeTT*3, ButtonImage,ButtonImage)];
        [_button4 setImage:IMAGE(@"cancel_icon111.png") forState:UIControlStateNormal];
        _button4.tag=2000+4;
        //  _button3.titleLabel.font=[UIFont systemFontOfSize: 10*HEIGHT_SIZE];
        [_button4 addTarget:self action:@selector(delPicture:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:_button4];
    }else if(_image1 && _image2 && _image3 && _image4 && !_image5){
        [_picArray insertObject:image atIndex:4];
        _image5=[[UIImageView alloc]initWithFrame:CGRectMake(imageX, firstH+sizeTT*4, imageH,imageH )];
        _image5.userInteractionEnabled = YES;
        _image5.image = image;
        _image5.tag=5+3000;
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moreBigImage:)];
        [_image5 addGestureRecognizer:tap1];
        [_scrollView addSubview:_image5];
        
        _button5= [[UIButton alloc] initWithFrame:CGRectMake(buttonX-ButtonImage/2, firstH-ButtonImage/2+sizeTT*4, ButtonImage,ButtonImage)];
        [_button5 setImage:IMAGE(@"cancel_icon111.png") forState:UIControlStateNormal];
        _button5.tag=2000+5;
        //  _button3.titleLabel.font=[UIFont systemFontOfSize: 10*HEIGHT_SIZE];
        [_button5 addTarget:self action:@selector(delPicture:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:_button5];
    }
    
    
   
    
}


-(void)moreBigImage:(UITapGestureRecognizer*)tap{
    UIImageView *imageV=(UIImageView*)tap.view;
    
    moreBigImage *go=[[moreBigImage alloc]init];
    go.paramsImageArray=[NSMutableArray arrayWithObject:imageV.image ];
    [self.navigationController pushViewController:go animated:YES];
    
}


-(void)delPicture:(UIButton*)del{
    UIButton  *a=del;
    NSString *replaceName=@"del";
    int Tag=(int)a.tag-2001;
    [_picArray replaceObjectAtIndex:Tag withObject:replaceName];
    
    if ((a.tag-2000)==1) {
        [_image1 removeFromSuperview];
        [_button1 removeFromSuperview];
        _image1=nil;
        _button1=nil;
    }else  if ((a.tag-2000)==2) {
        [_image2 removeFromSuperview];
        [_button2 removeFromSuperview];
        _image2=nil;
        _button2=nil;
    }else  if ((a.tag-2000)==3) {
        [_image3 removeFromSuperview];
        [_button3 removeFromSuperview];
        _image3=nil;
        _button3=nil;
    }else  if ((a.tag-2000)==4) {
        [_image4 removeFromSuperview];
        [_button4 removeFromSuperview];
        _image4=nil;
        _button4=nil;
    }else  if ((a.tag-2000)==5) {
        [_image5 removeFromSuperview];
        [_button5 removeFromSuperview];
        _image5=nil;
        _button5=nil;
    }
    

    
    
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
