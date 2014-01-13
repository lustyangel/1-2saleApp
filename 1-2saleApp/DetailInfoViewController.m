//
//  DetailInfoViewController.m
//  1-2saleApp
//
//  Created by TY on 14-1-13.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import "DetailInfoViewController.h"

@interface DetailInfoViewController ()

@end

@implementation DetailInfoViewController

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
    UIView *titleView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    titleView.backgroundColor=[UIColor underPageBackgroundColor];
    [self.view addSubview:titleView];
    
    UIButton *lButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [lButton setFrame:CGRectMake(0, 0, 40, 40)];
    [lButton addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:lButton];
    
    NSURL *lURL=[NSURL URLWithString:@"http://192.168.1.138/shop/html/15/introduction.php"];
    NSURLRequest *lRequest1=[NSURLRequest requestWithURL:lURL];
    
    UIWebView *lWebView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 44, 320, 504)];
//    lWebView.delegate=self;
    [lWebView loadRequest:lRequest1];
    lWebView.scrollView.bounces=NO;
    [self.view addSubview:lWebView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backClick:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
