//
//  AllAddressViewController.m
//  1-2saleApp
//
//  Created by TY on 14-1-8.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import "AllAddressViewController.h"
#import "AddressViewController.h"
#import "EditAddressViewController.h"
#import "NetManager.h"
@interface AllAddressViewController ()

@end

@implementation AllAddressViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _isSelect=NO;
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     _data=[[NSMutableData alloc]init];
    _addressArray=[[NSArray alloc]init];
    
#pragma mark-导航
        UIView  *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
          view.backgroundColor=[UIColor redColor];

       UILabel  *lable=[[UILabel alloc]initWithFrame: view.frame];
       [lable setText:@"收货地址管理"];
       lable.textAlignment=NSTextAlignmentCenter;
       lable.backgroundColor=[UIColor clearColor];
       [lable setFont:[UIFont systemFontOfSize:18]];
        [view addSubview:lable];
     
         UIButton *lButton=[UIButton buttonWithType:UIButtonTypeCustom];
         [lButton setImage:[UIImage imageNamed:@"title_back"] forState:UIControlStateNormal];
         [lButton setFrame:CGRectMake(0, 2, 44, 44)];
        [lButton addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:lButton];
        [self.view  addSubview:view];
    
    
#pragma mark-新增地址按钮    
    UIButton  * button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, self.view.frame.size.height-40, 320,40);
    [button setTitle:@"新增地址" forState:UIControlStateNormal];
    button.backgroundColor=[UIColor grayColor];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
 	// Do any additional setup after loading the view.
}
#pragma mark-返回上页
-(void)backClick:(UIButton *)sender{
       [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark-tableview
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _addressArray.count;
}
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID=@"cellID";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
           NSDictionary *dic=[_addressArray objectAtIndex:[indexPath row]];
            if ( [[[DanLi sharDanli].address objectForKey:@"addressid"] isEqualToString: [dic objectForKey:@"addressid"]]) {
                  cell.imageView.image=[UIImage imageNamed:@"check"];
            } 
    cell.textLabel.text=[dic objectForKey:@"name"];
    cell.detailTextLabel.text=[dic objectForKey:@"address"];
     cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
     cell.selectionStyle=UITableViewCellSelectionStyleGray;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
     NSDictionary *dic=[_addressArray objectAtIndex:[indexPath row]];
    if (_isSelect) {
        [DanLi sharDanli].address=dic;
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }else{
        EditAddressViewController  *editaddress=[[EditAddressViewController alloc]init];
        editaddress.dictionary=dic;
        [self presentViewController:editaddress animated:YES completion:nil];
    }
    
   
    
}
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
   // NSLog(@"234");
}

#pragma mark-跳到增加地址的页面
-(void)buttonClick:(UIButton*)sender{
    AddressViewController  *addAddress=[[AddressViewController alloc]init];
    [self presentViewController:addAddress animated:YES completion:nil];
}
#pragma mark- 下载数据
-(void)getData{
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat: @"http://%@/shop/getaddress.php",kIP] ];
    NSString *bobyString=[NSString stringWithFormat:@"customerid=%i",[DanLi sharDanli].userID] ;
    NSMutableURLRequest  *request=[[NSMutableURLRequest alloc]initWithURL:url];
    [request setHTTPMethod:@"post"];
    [request setHTTPBody:[ bobyString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLConnection  *connecation=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    [connecation start];
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [_data setLength:0];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [_data setData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingAllowFragments error:nil];
    NSDictionary *dic1=  [dic objectForKey:@"msg"];
          _addressArray= [dic1 objectForKey:@"info"];
    
    if ([DanLi sharDanli].address.count==0) {
        [[NSUserDefaults  standardUserDefaults] setObject:[_addressArray objectAtIndex:0] forKey:@"address"];
        [NSUserDefaults resetStandardUserDefaults];
    }
    
     //  [_tableView reloadData];

    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(5, 40, 320, _addressArray.count* 60) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.showsVerticalScrollIndicator=NO;
    if (_addressArray.count>8) {
        _tableView.bounces=YES;
    }else{
        _tableView.bounces=NO;
    }
    [self.view addSubview:_tableView];

    
  

   // NSLog(@"%@",_addressArray);
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    [self errorView];
}
#pragma mark- 错误提醒
-(void)errorView{
    UIView  *view=[[UIView alloc]initWithFrame:CGRectMake(90, 150, 150, 257)];
    view.tag=900;
    
    UIImageView*connectFaileImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 150, 227)];
    connectFaileImage.image=[UIImage imageNamed:@"ConnectFail.png"];
    [view addSubview:connectFaileImage];
    
    UIButton*retryButton=[[UIButton alloc]initWithFrame:CGRectMake(40, 227, 70, 30)];
    retryButton.layer.borderColor=[UIColor darkGrayColor].CGColor;
    retryButton.layer.borderWidth=1;
    [retryButton setImage:[UIImage imageNamed:@"retry.png"] forState:UIControlStateNormal];
    retryButton.backgroundColor=[UIColor grayColor];
    retryButton.titleLabel.textColor=[UIColor blackColor];
    [retryButton addTarget:self action:@selector(retryClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:retryButton];
    [self.view addSubview:view];
}
-(void)retryClick:(UIButton*)sender{
    UIView *view=[self.view viewWithTag:900];
    [view removeFromSuperview];
    [self getData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    if ([NetManager sharNet].connectedToNetwork) {
         [self getData]; 
    }else{
        [self errorView];
    }
   
}
-(void)viewWillDisappear:(BOOL)animated{
    [_tableView removeFromSuperview];
}


@end
