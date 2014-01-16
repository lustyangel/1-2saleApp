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
@interface AllAddressViewController ()

@end

@implementation AllAddressViewController

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
     _data=[[NSMutableData alloc]init];
    _addressArray=[[NSArray alloc]init];
    
    UILabel  *lable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    [lable setText:@"   收货地址管理"];
    lable.backgroundColor=[UIColor grayColor];
    [lable setTextColor:[UIColor blackColor]];
    [lable setFont:[UIFont systemFontOfSize:18]];
    [self.view addSubview:lable];
    
    
    UIButton  * button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, self.view.frame.size.height-40, 320,40);
    [button setTitle:@"新增地址" forState:UIControlStateNormal];
    button.backgroundColor=[UIColor grayColor];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
 	// Do any additional setup after loading the view.
}
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
    cell.textLabel.text=[dic objectForKey:@"name"];
    cell.detailTextLabel.text=[dic objectForKey:@"address"];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
     cell.selectionStyle=UITableViewCellSelectionStyleGray;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
     NSDictionary *dic=[_addressArray objectAtIndex:[indexPath row]];
    
    EditAddressViewController  *editaddress=[[EditAddressViewController alloc]init];
    editaddress.dictionary=dic;
    [self presentViewController:editaddress animated:YES completion:nil];
    
}
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"234");
}
-(void)buttonClick:(UIButton*)sender{
    AddressViewController  *addAddress=[[AddressViewController alloc]init];
    [self presentViewController:addAddress animated:YES completion:nil];
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
    [_tableView reloadData];

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

    
    NSLog(@"%@",_addressArray);
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"%@",error);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    
   
    NSURL *url=[NSURL URLWithString:@"http://192.168.1.137/shop/getaddress.php" ];
    NSString *bobyString=@"customerid=3" ;
    NSMutableURLRequest  *request=[[NSMutableURLRequest alloc]initWithURL:url];
    [request setHTTPMethod:@"post"];
    [request setHTTPBody:[ bobyString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLConnection  *connecation=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    [connecation start];

}
-(void)viewWillDisappear:(BOOL)animated{
    [_tableView removeFromSuperview];
}
@end
