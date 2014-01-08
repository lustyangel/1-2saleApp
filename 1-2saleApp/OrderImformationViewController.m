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
    
    UILabel  *lable=[[UILabel alloc]initWithFrame:CGRectMake(5, 10, 320, 20)];
    [lable setText:@"订单详情"];
    [lable setTextColor:[UIColor blackColor]];
    [lable setFont:[UIFont systemFontOfSize:18]];
    [self.view addSubview:lable];
    
    UILabel  *statelable=[[UILabel alloc]initWithFrame:CGRectMake(5, 40, 100, 20)];
      [statelable setText:@"订单状态"];
     [statelable setFont:[UIFont systemFontOfSize:14]];
    [statelable setTextColor:[UIColor blackColor]];
    [self.view addSubview:statelable];
    
    
    NSString  *lstate=[_dictionary objectForKey:@"state"];
    
    UILabel  *state=[[UILabel alloc]initWithFrame:CGRectMake(210, 40, 100, 20)];
    [state setFont:[UIFont systemFontOfSize:14]];
   
    [state setTextColor:[UIColor redColor]];
    [self.view addSubview:state];
    
      _array= [_dictionary  objectForKey:@"carts"];
    UITableView  * tableView=[[UITableView alloc]initWithFrame:CGRectMake(5, 60, 315, self.view.frame.size.height-130 ) style:UITableViewStylePlain];
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.bounces=NO;
    tableView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:tableView];            
//    NSLog(@"dic%@",self.dictionary);
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-70, 320, 70)];
//   view.backgroundColor=[UIColor grayColor];
//     view.alpha=0.5;
    view.layer.borderColor=[UIColor grayColor].CGColor;
    view.layer.borderWidth=0.5;
    
    UILabel *amountLable =[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 100, 30)];
    amountLable.backgroundColor=[UIColor clearColor];
    [amountLable setText:@"实付款:"];
    [amountLable setTextColor:[UIColor redColor]];
    [amountLable  setFont:[UIFont systemFontOfSize:14]];
    [view  addSubview:amountLable];

    UILabel *amount =[[UILabel alloc]initWithFrame:CGRectMake(220, 5, 70, 30)];
    amount.backgroundColor=[UIColor clearColor];
    [amount setTextColor:[UIColor redColor]];
    [amount  setText:[NSString stringWithFormat:@"¥%@",[_dictionary objectForKey:@"amount"]]];
    [amount  setNumberOfLines:2];
    [amount  setFont:[UIFont systemFontOfSize:14]];
    [view  addSubview:amount];
    
     UIButton   *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor=[UIColor redColor];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.frame=CGRectMake(220,35,70,30);
    [view addSubview:button];
    [self.view addSubview:view];
    
    switch ([lstate intValue]) {
        case 0:
            [state setText:@"等待买家付款"];
            [button setTitle:@"付款" forState:UIControlStateNormal];
            break;
        case 1:
            [state setText:@"卖家已发货"];
               [button setTitle:@"确认收货" forState:UIControlStateNormal];
            break;
        case 2:
            [state setText:@"交易成功"];
            [button setTitle:@"评价" forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }

   
    // Do any additional setup after loading the view from its nib.
}
-(void)buttonClick:(UIButton *)sender{
    
  //  if ([sender.currentTitle isEqualToString:@"评价"]) {
        evaluateViewController  *evaluate=[[evaluateViewController alloc]init];
        [self presentViewController:evaluate animated:NO completion:nil];
    //}
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_array count]+2;
}
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([indexPath row]<_array.count) {
         return 100;
    }else{
         return 140;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID=@"cellID";
    
    if ([indexPath row]<_array.count) {
        OrderCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil) {
            cell=[[OrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
         NSDictionary *dic=[_array objectAtIndex: [indexPath row]];
        //商品的总价
        NSString  *amount=[dic objectForKey:@"amount"];
        cell.price.text=[NSString stringWithFormat:@"¥%@",amount];
        
        //商品的数量
        NSString *count= [dic objectForKey:@"goodscount"];
        cell.count.text=[NSString stringWithFormat:@"共%@件商品", count ];
        
        //商品的名字
        cell.name.text=[dic objectForKey:@"name"];
        cell.stateButton.hidden=YES;
        return cell;
    }else if([indexPath row]==_array.count){
        
        showCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil) {
            cell=[[showCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
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
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
