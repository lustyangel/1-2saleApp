//
//  AlerPasswordViewController.h
//  1-2saleApp
//
//  Created by TY on 14-1-10.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlerPasswordViewController : UIViewController<NSURLConnectionDataDelegate,UITextFieldDelegate>{
    NSMutableData *_data;
    int _x;
}

- (IBAction)toMain:(UIButton *)sender;
- (IBAction)exit:(UITextField *)sender;
@property (weak, nonatomic) IBOutlet UITextField *affirmText;
@property (weak, nonatomic) IBOutlet UITextField *oldPassword;
@property (weak, nonatomic) IBOutlet UITextField *npassword;
@property (weak, nonatomic) IBOutlet UIImageView *npasswordCheck;
@property (weak, nonatomic) IBOutlet UIImageView *affirmPasswordCheck;
@property (weak, nonatomic) IBOutlet UIImageView *oldPasswordCheck;

- (IBAction)backButton:(UIButton *)sender;
- (IBAction)confirmAler:(UIButton *)sender;

@end
