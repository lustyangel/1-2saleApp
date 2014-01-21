//
//  UserInfoViewController.h
//  pp
//
//  Created by TY on 14-1-17.
//  Copyright (c) 2014年 liumengxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInfoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *userNameLable;
@property (weak, nonatomic) IBOutlet UILabel *userIDLable;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UIButton *alerPasswordButton;
@property (weak, nonatomic) IBOutlet UILabel *telephoneLabel;
@property (weak, nonatomic) IBOutlet UIButton *myAdress;
- (IBAction)myAdressButton:(UIButton *)sender;
- (IBAction)alterPasswordButton:(UIButton *)sender;
- (IBAction)myOrder:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *headImageView;

@end
