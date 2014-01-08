//
//  GoodsIngoViewController.m
//  1-2saleApp
//
//  Created by TY on 14-1-8.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import "GoodsIngoViewController.h"

@interface GoodsIngoViewController ()

@end

@implementation GoodsIngoViewController

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
    UIButton *lButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [lButton setFrame:CGRectMake(100, 100, 100, 50)];
    [lButton addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lButton];
    
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
