//
//  AllOrderViewController.m
//  1-2saleApp
//
//  Created by TY on 14-1-3.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import "AllOrderViewController.h"
#import "OrderCell.h"
#import "OrderImformationViewController.h"
@interface AllOrderViewController ()

@end

@implementation AllOrderViewController

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
//    self.view.backgroundColor=[UIColor grayColor];
    
    UILabel  *lable=[[UILabel alloc]initWithFrame:CGRectMake(5, 10, 320, 20)];
    [lable setText:@"全部订单"];
    [lable setTextColor:[UIColor blackColor]];
    [lable setFont:[UIFont systemFontOfSize:18]];
    [self.view addSubview:lable];
    
      _data =[[NSMutableData alloc]init];
     _array =[[NSArray alloc]init];
    NSString *bodyString=@"customerid=3";
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"http://%@/shop/getorder.php",kIP] ];
    NSMutableURLRequest  *request=[NSMutableURLRequest requestWithURL:url];
    [request setHTTPBody:[ bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPMethod:@"post"];
    NSURLConnection  *connecation=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    [connecation start];
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(5, 30, 315, self.view.frame.size.height-20) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
   [self.view addSubview:_tableView];
 
    // Do any additional setup after loading the view from its nib.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_array count];
}
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID=@"cellID";
    OrderCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[OrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    NSDictionary *dic=[_array objectAtIndex:[indexPath row]];
    
    //商品的总价
       NSString  *amount=[dic objectForKey:@"amount"];
        cell.price.text=[NSString stringWithFormat:@"¥%@",amount];
    
    //商品的数量
       NSArray  *array=[dic objectForKey:@"carts"];
       cell.count.text=[NSString stringWithFormat:@"共%i件商品",array.count];

      //第一个商品的名字
        NSDictionary *dic1=[array objectAtIndex: 0];
       cell.name.text=[dic1 objectForKey:@"name"];
    
    //商品的状态
    NSString *state=[dic objectForKey:@"state"];
    switch ([state intValue]) {
        case  0:
            [cell.stateButton  setTitle:@"付款" forState:UIControlStateNormal];
            [cell.tradeState   setText:@"等待买家付款"];
            break;
        case  1:
            [cell.stateButton  setTitle:@"确认收货" forState:UIControlStateNormal];
               [cell.tradeState   setText:@"卖家已发货"];
            break;
        case  2:
            [cell.stateButton  setTitle:@"评价" forState:UIControlStateNormal];
              [cell.tradeState   setText:@"交易成功"];
            break;
            
        default:
            break;
    }
      
      cell.delegate=self;

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
   NSDictionary *dic=[_array objectAtIndex:[indexPath row]];    
    OrderImformationViewController  *order=[[OrderImformationViewController alloc]init];
     order.dictionary=dic;
    [self presentViewController:order animated:YES completion:nil];
     
}
-(void)stateButton:(UIButton *)sender String:(NSString *)string{
    NSLog(@"%@",string);
}


-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [_data setLength:0];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [_data setData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingAllowFragments error:nil];
    
    NSDictionary *dic1=[dic objectForKey:@"msg"];
          _array=[dic1 objectForKey:@"info"];
    
         //NSLog(@"%@",dic1);
        [_tableView reloadData];

}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"%@",error);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
