//
//  AddressViewController.m
//  1-2saleApp
//
//  Created by TY on 14-1-6.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import "AddressViewController.h"
#import "NetManager.h"
@interface AddressViewController ()

@end

@implementation AddressViewController

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
    _isClick=YES;
    _data=[[NSMutableData alloc]init];
    _cityString=[[NSMutableString alloc]init];
    _cityArray=[[NSMutableArray alloc]initWithArray:[[self getAllCity]allKeys]];
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
    
   
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(5, 44, 320, self.view.frame.size.height ) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
     _tableView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:_tableView];
   
    // Do any dditional setup after loading the view from its nib.
}
#pragma mark-返回上页
-(void)backClick:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark-tableview
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return _cityArray.count;
}
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID=@"cellID";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
    cell.textLabel.text=[_cityArray objectAtIndex:[indexPath row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
  
     NSString  *string=[_cityArray objectAtIndex:[indexPath row]];
     [_cityString  appendString:string];
       if (!_isClick) {
       // NSLog(@"_cityString%@",_cityString);
           [_tableView removeFromSuperview];
           UIButton *button=(UIButton *)[self.view viewWithTag:100];
           [button removeFromSuperview];
           
           [self addressView];
           
       }else{
           
           UIButton  * button=[UIButton buttonWithType:UIButtonTypeCustom];
           button.frame=CGRectMake(0, 40, 320,40);
           button.tag=100;
           button.backgroundColor=[UIColor grayColor];
           [button setTitle: string forState:UIControlStateNormal];
           [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
           button.titleLabel.textAlignment=NSTextAlignmentLeft;
           button.alpha=0.8;
           [self.view addSubview:button];
           
           [_cityArray  removeAllObjects];
           [_cityArray addObjectsFromArray: [[self getAllCity]objectForKey:string]];
           _tableView.frame=CGRectMake(5, 80, 320, self.view.frame.size.height );
           [_tableView  reloadData];

       }
     _isClick=NO;
}
#pragma mark-点击回到城市的选择
-(void)buttonClick:(UIButton*)sender{
        _isClick=YES;
     [_cityString  setString:@" "];
        [sender removeFromSuperview];
        _tableView.frame=CGRectMake(5, 44, 320, self.view.frame.size.height );
         _cityArray=[NSMutableArray  arrayWithArray:[[self getAllCity]allKeys]];
        [_tableView  reloadData];
     
}
#pragma mark-提交地址数据
-(void)submitAddress:(UIButton*)sender{
    [_cityString appendString:_detailRess.text];
    if (![_detailRess.text  isEqualToString:@""]&&![_name.text isEqualToString:@""]&&![_telephone.text isEqualToString:@""]&&![_code.text isEqualToString:@""]) {
       
        if ([self verifyTelephone:_telephone.text]&&[self verifyCode:_code.text]) {
             [self getData];
        }else{
            NSString  *string=@"电话号码或是邮编错误";
            [self errorMessage:string];
        }
        
           }else{
                NSString *string=@"地址，收件人，电话号码或邮编不能为空!";
               [self errorMessage:string];
               
        }
}
#pragma mark-数据输入错误提醒
-(void)errorMessage:(NSString*)string{
    UILabel  *message=[[UILabel alloc]initWithFrame:CGRectMake(0, 250, 320, 30)];
    message.text=string;
    [message setTextColor:[UIColor redColor]];
    message.tag=800;
    message.alpha=0.5;
    message.font=[UIFont systemFontOfSize:14];
    message.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:message];
    [self  performSelector:@selector(removeMessage:) withObject:message afterDelay:1];
}
-(void)removeMessage:(UILabel*)label{
        [label removeFromSuperview];
  }

#pragma mark-数据下载
-(void)getData{
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"http://%@/shop/addaddress.php",kIP] ];
    NSString *bobyString=[NSString stringWithFormat:@"customerid=%i&name=%@&telephone=%@&code=%@&address=%@",[DanLi sharDanli].userID,_name.text,_telephone.text,_code.text, _cityString ];
    
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
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
                [self errorView];
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

#pragma mark-获取城市和区县
-(NSDictionary*)getAllCity{
    
    NSString  *path= [[NSBundle mainBundle]pathForResource:@"city" ofType:@"json"];
    NSData *data=[NSData dataWithContentsOfFile:path];
    NSDictionary  *dic=[NSJSONSerialization  JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray  *array=[dic objectForKey:@"城市代码"];
    NSMutableDictionary   *cityDic=[[NSMutableDictionary alloc]init];
    
    for (int i=0; i<array.count; i++) {
        NSDictionary *ldic=[array objectAtIndex:i];
        NSString  *cityname=[ldic objectForKey:@"省"];
        NSArray  *array=[ldic  objectForKey:@"市"];
        NSMutableArray   *addCity=[[NSMutableArray alloc]init];
        for (NSDictionary  *dic in array) {
            [addCity  addObject: [dic objectForKey:@"市名"]];
        }
             [cityDic  setObject:addCity forKey:cityname];
   
           }
    return cityDic;

}

#pragma mark- 数据页面
-(void)addressView{
   // UIView  *view=[[UIView alloc]initWithFrame:CGRectMake(5, 50, 320, self.view.frame.size.height)];
    
    UILabel  *label=[[UILabel alloc]initWithFrame:CGRectMake(10, 50, 320, 40)];
    [label setText:  [NSString stringWithFormat:@"所在地区:%@",_cityString]];
    label.backgroundColor=[UIColor clearColor];
    [self.view addSubview:label];
    
  _detailRess=[[UITextField alloc]initWithFrame:CGRectMake(20, 95, 250, 30)];
    _detailRess.borderStyle=UITextBorderStyleRoundedRect;
    _detailRess.placeholder=@"请输入详细的街道地址";
    _detailRess.text=@"";
    [self.view addSubview:_detailRess];
    
     _name=[[UITextField alloc]initWithFrame:CGRectMake(20, 125, 250, 30)];
    _name.borderStyle=UITextBorderStyleRoundedRect;
    _name.placeholder=@"请输入收货人姓名";
    _name.text=@"";
    [self.view addSubview:_name];
    
    _telephone=[[UITextField alloc]initWithFrame:CGRectMake(20, 155, 250, 30)];
    _telephone.borderStyle=UITextBorderStyleRoundedRect;
    _telephone.placeholder=@"请输入收货人联系电话";
    _telephone.text=@"";
    _telephone.tag=500;
    _telephone.delegate=self;
    [self.view addSubview:_telephone];
    
    _code=[[UITextField alloc]initWithFrame:CGRectMake(20, 185, 250, 30)];
    _code.borderStyle=UITextBorderStyleRoundedRect;
    _code.placeholder=@"请输入邮编";
    _code.tag=600;
    _code.delegate=self;
    _code.text=@"";
    [self.view addSubview:_code];
    
    _verifyView=[[UIImageView alloc]initWithFrame:CGRectMake(270, 165, 15, 15)];
    _verifyView.hidden=YES;
    _verifyView.image=[UIImage imageNamed:@"error"];
       [self.view addSubview:_verifyView];
    
    
    UIButton  * button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(120, 225, 60,30);
    button.backgroundColor=[UIColor redColor];
    [button setTitle: @"提交" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(submitAddress:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.textAlignment=NSTextAlignmentLeft;
    [self.view addSubview:button];
    
  //  return view;
   
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (![textField.text isEqualToString:@""]) {
              if (textField.tag==500) {
                       if (![self verifyTelephone:textField.text]) {
                               _verifyView.frame=CGRectMake(270, 165, 15, 15);
                                _verifyView.hidden=NO;
                             }else{
                                   _verifyView.hidden=YES;
                               }
                    }else if (textField.tag==600){
                         if (![self verifyCode:textField.text]) {
                                  _verifyView.frame=CGRectMake(270, 195, 15, 15);
                                  _verifyView.hidden=NO;
                             }else{
                                      _verifyView.hidden=YES;
                                    }
                         }
           }

    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-验证电话号码
-(BOOL)verifyTelephone:(NSString *)string{
       NSString *regex=@"[0-9]{11}";
     NSPredicate  *predicate=[NSPredicate predicateWithFormat:@"self matches %@",regex];
     bool isMatch=[predicate evaluateWithObject:string];
        if (isMatch) {
              return YES;
          }else{
                   return NO;
               }
  
   }
#pragma mark-验证邮政编码
-(BOOL)verifyCode:(NSString *)string{
       //^(13[0-9]|15[0|3|6|7|8|9]|18[8|9])d{8}$
        NSString *regex=@"[0-9]{6}";
        NSPredicate  *predicate=[NSPredicate predicateWithFormat:@"self matches %@",regex];
      BOOL isMatch=[predicate evaluateWithObject:string];
      if (isMatch) {
           return YES;
         }else{
               return NO;
            }  
}
-(void)viewWillAppear:(BOOL)animated{
    if (![NetManager sharNet].connectedToNetwork) {
        [self errorView];
    }
}
- (IBAction)hideKey:(UIControl *)sender {
    [_code resignFirstResponder];
    [_detailRess  resignFirstResponder];
    [_name resignFirstResponder];
    [_telephone resignFirstResponder];
}
@end
