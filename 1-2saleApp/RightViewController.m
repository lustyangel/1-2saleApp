//
//  RightViewController.m
//  1-2saleApp
//
//  Created by TY on 14-1-7.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import "RightViewController.h"

@interface RightViewController ()

@end

@implementation RightViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _lArray=[[NSArray alloc]initWithObjects:@"登陆",@"我的购物车",@"我的订单",@"我的资料",@"设置", nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor grayColor];
    // Do any additional setup after loading the view from its nib.
    _lTabelView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, _lArray.count*40)];
    _lTabelView.delegate=self;
    _lTabelView.dataSource=self;
    _lTabelView.backgroundColor=[UIColor grayColor];
    _lTabelView.separatorColor=[UIColor lightGrayColor];
    [self.view addSubview:_lTabelView];
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID=@"cellID";
    UITableViewCell *lCell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (lCell==nil) {
        lCell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    lCell.textLabel.text=[_lArray objectAtIndex:[indexPath row]];
    lCell.textLabel.textColor=[UIColor whiteColor];
    lCell.textLabel.font=[UIFont systemFontOfSize:18];
    return lCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [_delegate rightViewTabelViewClick:[indexPath row]];
}
@end
