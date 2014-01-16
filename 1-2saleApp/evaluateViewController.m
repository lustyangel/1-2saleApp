//
//  evaluateViewController.m
//  1-2saleApp
//
//  Created by TY on 14-1-6.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import "evaluateViewController.h"

@interface evaluateViewController ()

@end

@implementation evaluateViewController

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
#pragma mark - 导航
    UIView *titleView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    titleView.backgroundColor=[UIColor underPageBackgroundColor];
    [self.view addSubview:titleView];
    
    UIButton *lButton=[[UIButton alloc]initWithFrame:CGRectMake(0,0, 44, 44)];
    [lButton setImage:[UIImage imageNamed:@"title_back.png"] forState:UIControlStateNormal];
    [lButton addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:lButton];
    
    UILabel*titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleLabel.center=CGPointMake(160, 22);
    titleLabel.text=@"确认订单";
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.backgroundColor=[UIColor clearColor];
    [titleView addSubview:titleLabel];
    // Do any additional setup after loading the view from its nib.
}
#pragma mark - 返回按钮

-(void)backClick:(UIButton *)sender{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
