//
//  UserInfoViewController.m
//  1-2saleApp
//
//  Created by TY on 14-1-7.
//  Copyright (c) 2014年 ljt. All rights reserved.
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
    NSString *lN=@"用户名: ";
    self.userNameLable.text=[lN stringByAppendingString:[[DanLi sharDanli].userInfoDictionary objectForKey:@"name"]];
    NSString *lI=@"我的ID: ";
    self.userIDLable.text=[lI stringByAppendingString:[[DanLi sharDanli].userInfoDictionary objectForKey:@"customerid"]];
    NSString *le=@"我的邮箱: ";
    self.emailLabel.text=[le stringByAppendingString:[[DanLi sharDanli].userInfoDictionary objectForKey:@"email"]];
    NSString *lt=@"我的电话: ";
    self.telephoneLabel.text=[lt stringByAppendingString:[[DanLi sharDanli].userInfoDictionary objectForKey:@"telephone"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButton:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)alterPasswordButton:(UIButton *)sender {
    AlerPasswordViewController *lAlerPasswordViewController=[[AlerPasswordViewController alloc]init];
    [self presentViewController:lAlerPasswordViewController animated:YES completion:nil];
}

- (IBAction)myAdressButton:(UIButton *)sender {
    AllAddressViewController *lAllAddressViewController=[[AllAddressViewController alloc]init];
    [self presentViewController:lAllAddressViewController animated:YES completion:nil];
}

- (IBAction)changeUesr:(UIButton *)sender {
    ViewController *lViewController=[[ViewController alloc]init];
    [self presentViewController:lViewController animated:YES completion:nil];
}
@end
