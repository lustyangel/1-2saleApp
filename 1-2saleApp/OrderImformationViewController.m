//
//  OrderImformationViewController.m
//  1-2saleApp
//
//  Created by TY on 14-1-3.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import "OrderImformationViewController.h"
#import "OrderCell.h"
#import "showCell.h"
#import "evaluateViewController.h"
@interface OrderImformationViewController ()

@end

@implementation OrderImformationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.dictionary=[[NSDictionary alloc]init];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
      _data =[[NSMutableData alloc]init];
#pragma mark-导航
    
    UIView  *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    view.backgroundColor=[UIColor redColor];
    
    UILabel  *lable=[[UILabel alloc]initWithFrame: view.frame];
    [lable setText:@"订单详情"];
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
        
      _array= [_dictionary  objectForKey:@"carts"];
     NSLog(@"dic%@",_dictionary);    
    
  _tableView=[[UITableView alloc]initWithFrame:CGRectMake(5, 44, 315, self.view.frame.size.height-130 ) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    if (_array.count<2) {
        _tableView.bounces=NO;
    } 
   
    _tableView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:_tableView];            
   
    [self foodView];
    // Do any additional setup after loading the view from its nib.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_array count]+3;
}
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([indexPath row]==0) {
        return 30;
    }else   if ([indexPath row]<=_array.count ) {
         return 100;
    }else{
         return 140;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID=@"cellID";
    int row=[indexPath row];
    if (row==0) {
       
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        }
         cell.selected=NO;
         cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.textLabel.text=@"订单状态";
            cell.detailTextLabel.text=[self orderState];
            return cell;
    }else if (_array.count>=row>0){
    
        OrderCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil) {
            cell=[[OrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
         cell.selectionStyle=UITableViewCellSelectionStyleNone;
         NSDictionary *dic=[_array objectAtIndex:row-1];
        //商品的总价
        NSString  *amount=[dic objectForKey:@"amount"];
        cell.price.text=[NSString stringWithFormat:@"¥%@",amount];
        
        //商品的数量
        NSString *count= [dic objectForKey:@"goodscount"];
        cell.count.text=[NSString stringWithFormat:@"共%@件商品", count ];
        
        //商品的名字
        cell.name.text=[dic objectForKey:@"name"];
        cell.stateButton.hidden=YES;
        //商品的图片
        NSString  *headerimage=[dic objectForKey:@"headerimage"];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSURL *lURL=[NSURL URLWithString:[NSString stringWithFormat:@"http://%@/shop/goodsimage/%@",kIP, headerimage]];
            NSData *lData=[NSData dataWithContentsOfURL:lURL];
            UIImage *image=[[UIImage alloc]initWithData:lData];
            dispatch_sync(dispatch_get_main_queue(), ^{
                cell.imageview.image=image;
                
            });
        });

        
        
        return cell;
    }else if( row==_array.count+1){
        
        showCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil) {
            cell=[[showCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        // cell.selected=NO;
         cell.selectionStyle=UITableViewCellSelectionStyleNone;
         cell.titleText.text=@"收货地址";
         cell.labelText1.text=@"地址";
         cell.labelText2.text=@"邮编";
         cell.labelText3.text=@"姓名";
         cell.labelText4.text=@"电话";
        cell.showText1.text=[_dictionary objectForKey:@"address"];
        cell.showText2.text=[_dictionary objectForKey:@"code"];
        cell.showText3.text=[_dictionary objectForKey:@"name"];
        cell.showText4.text=[_dictionary objectForKey:@"telephone"];
        
        return cell;
    }else{
        showCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil) {
            cell=[[showCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
         cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.selected=NO;
        cell.titleText.text=@"订单信息";
        cell.labelText1.text=@"交易号";
        cell.labelText2.text=@"订单号";
        cell.labelText3.text=@"订单日期";

        cell.showText1.text=[_dictionary objectForKey:@"ordercode"];
        cell.showText2.text=[_dictionary objectForKey:@"orderid"];
        cell.showText3.text=[_dictionary objectForKey:@"name"];
        return cell;

    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    int row=[indexPath row];
   // NSLog(@"%i",row);
    if (_array.count>=row&&row!=0) {
        NSLog(@"1232");
        
        
    }
     
}
#pragma mark-返回
-(void)backClick:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark-订单状态
-(NSString*)orderState{
      NSString  *string=[[NSString alloc]init];
     NSString  *state=[_dictionary objectForKey:@"state"];
    switch ([state intValue]) {
        case 0:
            string= @"等待卖家发货";
           break;
        case 1:
              string=@"卖家已发货" ;
            break;
        case 2:
           string=@"交易成功";
            break;
            
        default:
            break;
    }
     return string;
}
#pragma mark-editView
-(void)foodView{
    UIView *foodview=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-70, 320, 70)];
    foodview.layer.borderColor=[UIColor grayColor].CGColor;
    foodview.layer.borderWidth=0.5;
    
    UILabel *amountLable =[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 150, 30)];
    amountLable.backgroundColor=[UIColor clearColor];
    [amountLable setText:@"实付款:(包含运费)"];
    [amountLable setTextColor:[UIColor redColor]];
    [amountLable  setFont:[UIFont systemFontOfSize:14]];
    [foodview  addSubview:amountLable];
    
    UILabel *amount =[[UILabel alloc]initWithFrame:CGRectMake(220, 5, 70, 30)];
    amount.backgroundColor=[UIColor clearColor];
    [amount setTextColor:[UIColor redColor]];
    [amount  setText:[NSString stringWithFormat:@"¥%@",[_dictionary objectForKey:@"amount"]]];
    [amount  setNumberOfLines:2];
    [amount  setFont:[UIFont systemFontOfSize:14]];
    [foodview  addSubview:amount];
    
    UIButton   *deletebutton=[UIButton buttonWithType:UIButtonTypeCustom];
    deletebutton.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"delete.jpg"]];
    [deletebutton addTarget:self action:@selector(deleteOrder:) forControlEvents:UIControlEventTouchUpInside];
    deletebutton.frame=CGRectMake(50,30,40,40);
    [foodview addSubview:deletebutton];
    
    
    UIButton   *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor=[UIColor redColor];
    button.titleLabel.font=[UIFont systemFontOfSize:16];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.frame=CGRectMake(210,35,100,30);
    NSString  *state=[_dictionary objectForKey:@"state"];
    switch ([state intValue]) {
        case 0:
         [button  setTitle:@"等待卖家发货" forState:UIControlStateNormal];
             deletebutton.hidden=NO;
            break;
        case 1:
            [button  setTitle:@"卖家已发货" forState:UIControlStateNormal];
            deletebutton.hidden=YES;
            break;
        case 2:
            [button  setTitle:@"交易成功" forState:UIControlStateNormal];
             deletebutton.hidden=YES;
            break;
            
        default:
            break;
    }

    [foodview addSubview:button];
    [self.view addSubview:foodview];

}
-(void)buttonClick:(UIButton *)sender{
    
    //  if ([sender.currentTitle isEqualToString:@"评价"]) {
    evaluateViewController  *evaluate=[[evaluateViewController alloc]init];
    [self presentViewController:evaluate animated:NO completion:nil];
    //}
}
-(void)deleteOrder:(UIButton*)sender{
    NSLog(@"delete");
    [self getData];
    
}
#pragma mark-删除数据
-(void)getData{
      NSString *bodyString=[NSString stringWithFormat:@"ordercode=%@", [_dictionary objectForKey:@"ordercode"]];
    // NSLog(@"id%i",[DanLi sharDanli].userID);
    
    NSURL *url=[NSURL URLWithString:[NSString  stringWithFormat:@"http://%@/shop/deleteorder.php",kIP]];
    NSMutableURLRequest  *request=[NSMutableURLRequest requestWithURL:url];
    [request setHTTPBody:[ bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPMethod:@"post"];
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
    
//    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingAllowFragments error:nil];
//    NSDictionary *dic1=[dic objectForKey:@"msg"];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    [self errorView];
//    UIAlertView  *alter=[[UIAlertView alloc]initWithTitle:@"message" message:@"network is error!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
//    [alter show];
}
#pragma mark- 下载错误提醒
-(void)errorView{
    
    UIImageView*connectFaileImage=[[UIImageView alloc]initWithFrame:CGRectMake(90, 150, 150, 227)];
    connectFaileImage.image=[UIImage imageNamed:@"ConnectFail.png"];
    [self.view addSubview:connectFaileImage];
    [self performSelector:@selector(retryClick:) withObject:connectFaileImage afterDelay:3];
}
-(void)retryClick: (UIImageView*)image{
    [image removeFromSuperview];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
