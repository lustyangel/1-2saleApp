//
//  logonViewController.h
//  Go Shopping
//
//  Created by TY on 13-11-7.
//  Copyright (c) 2013年 liumengxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface logonViewController : UIViewController<NSURLConnectionDataDelegate,UITextFieldDelegate>{
    NSMutableData *_data;
    int _x;
}

- (IBAction)backButton:(UIButton *)sender;
- (IBAction)textExit:(UITextField *)sender;
@property (retain, nonatomic) IBOutlet UITextField *nameText;
@property (retain, nonatomic) IBOutlet UITextField *cipherText;
@property (retain, nonatomic) IBOutlet UITextField *affimCipherText;
@property (weak, nonatomic) IBOutlet UITextField *telephoneText;
@property (weak, nonatomic) IBOutlet UITextField *emailText;
- (IBAction)commitButton:(UIButton *)sender;

@end
