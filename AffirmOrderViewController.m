//
//  AffirmOrderViewController.m
//  1-2saleApp
//
//  Created by TY on 14-1-14.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import "AffirmOrderViewController.h"
#import "AllAddressViewController.h"
@interface AffirmOrderViewController ()

@end

@implementation AffirmOrderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _cartInfo=[[NSDictionary alloc]init];
          // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"_cartInfo%@",_cartInfo);
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
  
#pragma mark - content  
    
     _lTabelView=[[UITableView alloc]initWithFrame:CGRectMake(5, 44, 310, self.view.frame.size.height-44) style:UITableViewStylePlain];
    _lTabelView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    _lTabelView.layer.borderWidth=1;
    _lTabelView.layer.cornerRadius=5;
    _lTabelView.delegate=self;
    _lTabelView.dataSource=self;
   // lTabelView.bounces=NO;
    [self.view addSubview:_lTabelView];
    [self foodView];
  
    // Do any additional setup after loading the view from its nib.
}
#pragma mark - UITableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([indexPath row]==1) {
        return 70; 
    }else{
    return 40;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID=@"cellID";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
       // [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        cell.textLabel.font=[UIFont systemFontOfSize:16];
    }
    switch ([indexPath row]) {
        case 0:{
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text=[[DanLi sharDanli].address objectForKey:@"name"];
            cell.detailTextLabel.text=[[DanLi sharDanli].address objectForKey:@"address"];
        }
            break;
        case 1:{
              cell.textLabel.numberOfLines=2;
            cell.textLabel.font=[UIFont systemFontOfSize:14];
            cell.imageView.image=[UIImage imageNamed:@"goShop"];
            cell.textLabel.text=[_cartInfo objectForKey:@"name"];
            cell.detailTextLabel.text=[NSString stringWithFormat:@"单价：¥%@",[_cartInfo objectForKey:@"price"]];
        }
              break;
        case 2:{
            cell.textLabel.text=@"购买数量";
            cell.detailTextLabel.text=[_cartInfo objectForKey:@"goodscount"];
        }
            break;
            
        default:
            break;
    }

 
    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
           [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch ([indexPath row]) {
        case 0:{
            AllAddressViewController  *address=[[AllAddressViewController alloc]init];
            address.isSelect=YES;
            [self presentViewController:address animated:YES completion:nil];
        }
            break;
                                                      
        default:
            break;
    }
}
#pragma mark - 返回按钮

-(void)backClick:(UIButton *)sender{
    
    [self dismissViewControllerAnimated:YES completion:nil];    
}
-(void)foodView{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-80 , 320, 80)];
    view.backgroundColor=[UIColor grayColor];
    [self.view addSubview:view];
    
    UILabel*titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 5, 100, 30)];
    titleLabel.text=@"实际付款：";
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.backgroundColor=[UIColor clearColor];
    [view addSubview:titleLabel];
    
    
    
    UILabel*moneyLabel=[[UILabel alloc]initWithFrame:CGRectMake(180, 5, 100, 30)];
    moneyLabel.text=[NSString stringWithFormat:@"¥%@",[_cartInfo objectForKey:@"amount"]];
    [moneyLabel setTextColor:[UIColor redColor]];
    moneyLabel.textAlignment=NSTextAlignmentLeft;
    moneyLabel.backgroundColor=[UIColor clearColor];
    [view addSubview:moneyLabel];
    
    UIButton *lButton=[[UIButton alloc]initWithFrame:CGRectMake(0,40, 320, 40)];
    lButton.backgroundColor=[UIColor redColor];
    [lButton setTitle:@"确认" forState:UIControlStateNormal];
    [lButton addTarget:self action:@selector(submitOrder:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:lButton];
    
}
-(void)submitOrder:(UIButton *)sender{
    
    NSString *bodyString=[NSString stringWithFormat:@"customerid=%i&&addressid=%@&cartids[0]=3",[DanLi sharDanli].userID,[[DanLi sharDanli].address objectForKey:@"addressid"]];
    // NSLog(@"id%i",[DanLi sharDanli].userID);
    //NSString *bodyString=@"customerid=3";
    NSURL *url=[NSURL URLWithString:[NSString  stringWithFormat:@"http://%@/shop/addorder.php",kIP]];
    NSMutableURLRequest  *request=[NSMutableURLRequest requestWithURL:url];
    [request setHTTPBody:[ bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPMethod:@"post"];
    NSURLConnection  *connecation=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    [connecation start];
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [_lTabelView reloadData];      
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
