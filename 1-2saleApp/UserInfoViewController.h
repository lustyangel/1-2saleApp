//
//  UserInfoViewController.h
//  1-2saleApp
//
//  Created by TY on 14-1-7.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInfoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *userNameLable;
- (IBAction)changeUesr:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *userIDLable;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *telephoneLabel;
- (IBAction)backButton:(UIButton *)sender;
- (IBAction)alterPasswordButton:(UIButton *)sender;
- (IBAction)myAdressButton:(UIButton *)sender;


@end
