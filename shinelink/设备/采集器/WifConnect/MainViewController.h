//
//  UDPViewController.h
//  udp
//
//  Created by Jakey on 15/1/12.
//  Copyright (c) 2015年 jakey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCDAsyncUdpSocket.h"
#import "AsyncUdpSocket.h"
#import "ConnetService.h"
#import "Reachability.h"

@interface MainViewController : UIViewController<GCDAsyncUdpSocketDelegate,UITextFieldDelegate,ConnetServiceDelegate>
{
    GCDAsyncUdpSocket *_udpSocket;
}
@property (strong, nonatomic)  UILabel *connectWifiLabel;
@property (strong, nonatomic)  UILabel *connectModemLabel;
@property (strong, nonatomic)  UILabel *ssidLabel;
@property (strong, nonatomic)  UILabel *wskeyLabel;
@property (strong, nonatomic)  UITextField *ssidTextField;
@property (strong, nonatomic)  UITextField *wskeyTextField;
@property (strong, nonatomic)  UITextField *wakeyTextField2;
//@property (strong, nonatomic) IBOutlet UIImageView *wskeyShowImageView;
//@property (strong, nonatomic) IBOutlet UIImageView *wakeyShowImageView;
@property (strong, nonatomic)  UILabel *moduleNameLabel;
@property (strong, nonatomic)  UILabel *checkCodeLabel;







//@property ( nonatomic) int*cellCount;



- (IBAction)clickSetButton:(id)sender;
//- (IBAction)SetAction:(id)sender;

@end
