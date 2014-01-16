//
//  mainViewController.m
//  1-2saleApp
//
//  Created by TY on 14-1-2.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import "mainViewController.h"
#import "ShoppingCartViewController.h"
#import "ViewController.h"
#import "userInfoViewController.h"
#import "DelayViewController.h"
#import "AllOrderViewController.h"


@interface mainViewController ()

@end

@implementation mainViewController

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
    
    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(not:) name:UITextFieldTextDidChangeNotification object:nil];
    
    _mainView=[[UIView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:_mainView];
    
    
    
    LLToolbar *lToolbar=[[LLToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    lToolbar.LLDelegate=self;
    [_mainView addSubview:lToolbar];
    
//    ShowAllView *lAllView=[[ShowAllView alloc]initWithFrame:CGRectMake(0, 44, 320, 504)];
//    [_mainView addSubview:lAllView];
//    
    _HotView=[[ShowHotView alloc]initWithFrame:CGRectMake(0, 44, 320, 504)];
    _HotView.LLDelegate=self;
    [_mainView addSubview:_HotView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//-(void)not:(NSNotification *)sender{
//    UITextField *lText=(UITextField *)[sender object];
//    NSLog(@"A:%@",lText.text);
//    NSLog(@"%@",[sender userInfo]);
//}


#pragma mark - 导航条热门商品和所有商品切换

-(void)actionViewSelect:(int)selectNumber{
    switch (selectNumber) {
        case 0:{
            [_AllView changeToHotView];
            if (_HotView==nil) {
                _HotView=[[ShowHotView alloc]initWithFrame:CGRectMake(0, 44, 320, 504)];
                [_mainView addSubview:_HotView];
            }else{
                [_HotView reloadView];
            }
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                _AllView.center=CGPointMake(480, _AllView.center.y);
                _HotView.center=CGPointMake(160, _HotView.center.y);
            }completion:nil];
        }
            break;
            
        case 1:{
            
            if (_AllView==nil) {
                _AllView=[[ShowAllView alloc]initWithFrame:CGRectMake(320, 44, 320, 504)];
                _AllView.LLDelegate=self;
                [_mainView addSubview:_AllView];
            }else{
                [_AllView reloadView];
            }
            
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                _AllView.center=CGPointMake(160, _AllView.center.y);
                _HotView.center=CGPointMake(-160, _HotView.center.y);
            }completion:nil];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - 左右菜单栏

-(void)buttonItemSelect:(int)selectNumber{
//    [_lSearchBar.lField resignFirstResponder];
    if (selectNumber==0) {
//        self.view.center=CGPointMake(320, self.view.center.y);
        
    }
    else{
        if (_rightView==nil) {
            self.lRightViewController=[[RightViewController alloc]init];
            _rightView=[[UIView alloc]initWithFrame:self.view.frame];
        }
        [_lRightViewController reloadRightView];
        _lRightViewController.delegate=self;
        self.rightView=self.lRightViewController.view;
        _rightView.center=CGPointMake(480, self.view.frame.size.height/2);
        [self.view addSubview:_rightView];
        
        if (_FrontView==nil) {
            _FrontView=[[UIButton alloc]init];
            [_FrontView addTarget:self action:@selector(frontViewClick:) forControlEvents:UIControlEventTouchUpInside];
            _FrontView.backgroundColor=[UIColor grayColor];
            _FrontView.alpha=0.3;
        }
        _FrontView.frame=_mainView.frame;
        [_mainView addSubview:_FrontView];
        
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            _mainView.center=CGPointMake(0, self.view.frame.size.height/2);
            _rightView.center=CGPointMake(320, self.view.frame.size.height/2);
        }completion:^(BOOL finish){
            
        }];
        
    }
}

-(void)frontViewClick:(UIButton *)sender{
    [self frontViewClickMethod];
    
}

-(void)frontViewClickMethod{
    _FrontView.frame=CGRectMake(0, 0, 0, 0);
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        _mainView.center=CGPointMake(160, self.view.frame.size.height/2);
        _rightView.center=CGPointMake(480, self.view.frame.size.height/2);
    }completion:^(BOOL finish){
        
    }];
}

#pragma mark - 右侧菜单栏点击事件

-(void)rightViewTabelViewClick:(int)num{
    [self frontViewClickMethod];

    switch (num) {
        case 0:
        {
            NSArray *AutologonArray=[NSArray arrayWithContentsOfFile:AutologonSign];
            NSString *AutologonString=[AutologonArray objectAtIndex:0];
            if ([AutologonString isEqualToString:@"1"]) {
                DelayViewController *lDelayViewController=[[DelayViewController alloc]init];
                [self presentViewController:lDelayViewController animated:YES completion:nil];
            }
            else{
                ViewController *lLoginViewController = [[ViewController alloc] init];
                [self presentViewController:lLoginViewController animated:YES completion:nil];
            }
        }
            break;
        case 1:{
            ShoppingCartViewController *lShoppingCartViewController = [[ShoppingCartViewController alloc] init];
            [self presentViewController:lShoppingCartViewController animated:YES completion:nil];
        }
            break;
        case 2:{
            if ([DanLi sharDanli].userID==0) {
                ViewController *lLoginViewController = [[ViewController alloc] init];
                [self presentViewController:lLoginViewController animated:YES completion:nil];
                return;
            }
            AllOrderViewController *orderController = [[AllOrderViewController alloc] init];
            [self presentViewController:orderController animated:YES completion:nil];
        }
        case 3:{
            if ([DanLi sharDanli].userInfoDictionary==nil) {
                UIAlertView *lAlertView=[[UIAlertView alloc]initWithTitle:nil message:@"YOU MUST To log in first" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [lAlertView show];
                return;
            }
            UserInfoViewController *lUserInfoViewController=[[UserInfoViewController alloc]init];
            [self presentViewController:lUserInfoViewController animated:YES completion:nil];
        }
            break;
            
            
        default:
            break;
    }
}

#pragma mark - hotView 点击事件，传入商品id

-(void)ShowHotViewClick{

    GoodsIngoViewController *lGoodsIngoViewController=[[GoodsIngoViewController alloc]init];
    [self presentViewController:lGoodsIngoViewController animated:YES completion:nil];
    NSLog(@"%i",[DanLi sharDanli].goodsID);
}

-(void)showAllViewDelegate:(int)index{
    GoodsIngoViewController *lGoodsIngoViewController=[[GoodsIngoViewController alloc]init];
    [self presentViewController:lGoodsIngoViewController animated:YES completion:nil];
    NSLog(@"%i",[DanLi sharDanli].goodsID);
}



@end
