//
//  UserInfoViewController.m
//  pp
//
//  Created by TY on 14-1-17.
//  Copyright (c) 2014年 liumengxiang. All rights reserved.
//

#import "UserInfoViewController.h"
#import "AlerPasswordViewController.h"
#import "AllAddressViewController.h"

@interface UserInfoViewController ()

@end

@implementation UserInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.userNameLable.text=[[DanLi sharDanli].userInfoDictionary objectForKey:@"name"];
    NSString *lI=@"ID: ";
    self.userIDLable.text=[lI stringByAppendingString:[[DanLi sharDanli].userInfoDictionary objectForKey:@"customerid"]];
    NSString *le=@"邮箱: ";
    self.emailLabel.text=[le stringByAppendingString:[[DanLi sharDanli].userInfoDictionary objectForKey:@"email"]];
    NSString *lt=@"电话: ";
    self.telephoneLabel.text=[lt stringByAppendingString:[[DanLi sharDanli].userInfoDictionary objectForKey:@"telephone"]];
    self.alerPasswordButton.layer.cornerRadius=5;
    self.myAdress.layer.cornerRadius=5;
    self.headImageView.layer.cornerRadius=200;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)myAdressButton:(UIButton *)sender {
    AllAddressViewController *lAllAddressViewController=[[AllAddressViewController alloc]init];
    [self presentViewController:lAllAddressViewController animated:YES completion:nil];
}

- (IBAction)alterPasswordButton:(UIButton *)sender {
    AlerPasswordViewController *lAlerPasswordViewController=[[AlerPasswordViewController alloc]init];
    [self presentViewController:lAlerPasswordViewController animated:YES completion:nil];
}

- (IBAction)myOrder:(UIButton *)sender {
}

- (IBAction)backButton:(UIButton *)sender {
     [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)changeUesr:(UIButton *)sender {
    [DanLi sharDanli].userInfoDictionary=nil;
    landViewController *llandViewController=[[landViewController alloc]init];
    [self presentViewController:llandViewController animated:YES completion:nil];
}
@end
