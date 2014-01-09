//
//  DelayViewController.m
//  1-2saleApp
//
//  Created by TY on 14-1-8.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import "DelayViewController.h"
#import "mainViewController.h"
#import "ViewController.h"

@interface DelayViewController ()

@end

@implementation DelayViewController

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
	// Do any additional setup after loading the view.
        UIImage *lImage=[UIImage imageNamed:@"lengjing-1.tiff"];
        NSArray *lArray=[[NSArray alloc]initWithObjects:[UIImage imageNamed:@"lengjing-1.tiff"],[UIImage imageNamed:@"lengjing-2.tiff"],[UIImage imageNamed:@"lengjing-3.tiff"],nil];
        _autologonImageView=[[UIImageView alloc]initWithImage:lImage];
        [_autologonImageView setFrame:self.view.frame];
        _autologonImageView.animationImages=lArray;
        _autologonImageView.animationDuration=0.2;
        [_autologonImageView setUserInteractionEnabled:YES];//UIImageView默认是把事件关闭的！！
        [self.view addSubview: _autologonImageView];
        [_autologonImageView startAnimating];
        
       
        UIActivityIndicatorView *lUIActivityIndicatorView=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(180, 245, 0, 0)];
        lUIActivityIndicatorView.activityIndicatorViewStyle= UIActivityIndicatorViewStyleWhiteLarge;
        [lUIActivityIndicatorView setColor:[UIColor blueColor]];
        UILabel *lLabel=[[UILabel alloc]initWithFrame:CGRectMake(90,235,90, 20)];
        lLabel.font=[UIFont systemFontOfSize:20];
        lLabel.backgroundColor=[UIColor clearColor];
        lLabel.text=@"登录中...";
        UIButton *lButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        lButton.frame=CGRectMake(200, 235, 50, 30);
        [lButton setTitle:@"取消" forState: UIControlStateNormal];
        [lButton setEnabled:YES];
        [lButton addTarget:self action:@selector(cancelAutologon:) forControlEvents:UIControlEventTouchUpInside];
        [_autologonImageView addSubview:lButton];
        [_autologonImageView addSubview:lLabel];
        [_autologonImageView addSubview:lUIActivityIndicatorView];
        [lUIActivityIndicatorView startAnimating];
    
        [self performSelector:@selector(DelayOfLanding) withObject:nil afterDelay:3.5];
}
-(void)DelayOfLanding{
    mainViewController *lmainViewController=[[mainViewController alloc]init];
    [self presentViewController:lmainViewController animated:YES completion:nil];
}
-(void)cancelAutologon:(UIButton *)sender{
    ViewController *lViewController=[[ViewController alloc]init];
    [self presentViewController:lViewController animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
