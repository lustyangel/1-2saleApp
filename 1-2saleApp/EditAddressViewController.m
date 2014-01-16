//
//  EditAddressViewController.m
//  1-2saleApp
//
//  Created by TY on 14-1-8.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import "EditAddressViewController.h"
#import "AddressCell.h"
#import "NetManager.h"
@interface EditAddressViewController ()

@end

@implementation EditAddressViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _dictionary =[[NSDictionary alloc]init];
        _setAddress=NO;

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
        
    _detailAddress=[[AddressCell alloc]initWithFrame:CGRectMake(0,50,320, 40)];
    _detailAddress.titleLabel.text= @"收货地址：";
    _detailAddress.textField.text=[_dictionary objectForKey:@"address"];
    [self.view addSubview:_detailAddress];
    
    
    _name=[[AddressCell alloc]initWithFrame:CGRectMake(0,90,320, 40)];
    _name.titleLabel.text= @"收货人：";
    _name.textField.text=[_dictionary objectForKey:@"name"];
    [self.view addSubview:_name];
    
    
    _telephone=[[AddressCell alloc]initWithFrame:CGRectMake(0, 130, 320, 40)];
    _telephone.titleLabel.text= @"联系电话：";
    _telephone.textField.text=[_dictionary objectForKey:@"telephone"];
    [self.view addSubview:_telephone];
    
       
    _code=[[AddressCell alloc]initWithFrame:CGRectMake(0, 170, 320, 40)];
    _code.titleLabel.text= @"邮编：";
    _code.textField.text=[_dictionary objectForKey:@"code"];
    [self.view addSubview:_code];
    
    UILabel  *addresslable=[[UILabel alloc]initWithFrame: CGRectMake(180, 220 ,100, 20)];
    [addresslable setText:@"设为默认地址"];
    addresslable.textAlignment=NSTextAlignmentCenter;
    addresslable.backgroundColor=[UIColor clearColor];
    [addresslable setFont:[UIFont systemFontOfSize:14]];
    [self.view addSubview:addresslable];
    
    UIButton *ClickButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [ClickButton setImage:[UIImage imageNamed:@"title_back"] forState:UIControlStateNormal];
    
   NSDictionary *dic=[[NSUserDefaults  standardUserDefaults]objectForKey:@"address"];
    if ( [[_dictionary objectForKey:@"addressid"] isEqualToString: [dic objectForKey:@"addressid"]]) {
    [ClickButton setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
        _setAddress=YES;
    }                          
    
    [ClickButton setFrame:CGRectMake(160, 220 ,20, 20)];
    [ClickButton addTarget:self action:@selector(setAddressButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ClickButton];
 
    [self foodView];
   
    // Do any additional setup after loading the view from its nib.
}
-(void)setAddressButton:(UIButton*)sender{
    if (_setAddress) {
        _setAddress=NO;
        [sender setImage: nil forState:UIControlStateNormal];
    }else{
        _setAddress=YES;
     [sender setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
    }
       
}

#pragma mark-返回上页
-(void)backClick:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark-编辑view
-(void)foodView{
    UIView  *view=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-50, 320, 50)];
    view.backgroundColor=[UIColor grayColor];
    
    UIButton  *deletebutton=[UIButton buttonWithType:UIButtonTypeCustom];
    deletebutton.frame=CGRectMake(80, 5, 40,40);
    deletebutton.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"delete.jpg"]];
    [deletebutton addTarget:self action:@selector(deleteAddress:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:deletebutton];
    
    UIButton  * button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(200, 10, 60,30);
    button.backgroundColor=[UIColor redColor];
    [button setTitle: @"提交" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(submitAddress:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    [self.view addSubview:view];
}
#pragma mark- 删除数据
-(void)deleteAddress:(UIButton*)sender{
    if (![NetManager sharNet].connectedToNetwork) {
        [self errorView];
    }else{
        NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"http://%@/shop/deleteaddress.php",kIP]];
        int addressId=[[_dictionary objectForKey:@"addressid"]intValue];
        // NSLog(@"%i",addressId);
        NSString *bobyString=[NSString stringWithFormat:@"addressid=%i",addressId ];
        
        NSMutableURLRequest  *request=[[NSMutableURLRequest alloc]initWithURL:url];
        [request setHTTPMethod:@"post"];
        [request setHTTPBody:[ bobyString dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSURLConnection  *connecation=[[NSURLConnection alloc]initWithRequest:request delegate:self];
        [connecation start];
    }
}
#pragma mark- 提交数据
-(void)submitAddress:(UIButton*)sender{
    
    if (_setAddress) {
        [[NSUserDefaults  standardUserDefaults]setObject:_dictionary forKey:@"address"];
        [NSUserDefaults resetStandardUserDefaults];        
    }
    _isSubmit=YES;
    [self deleteAddress:sender];
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [_data setLength:0];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [_data setData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    if (_isSubmit) {
        
        NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"http://%@/shop/addaddress.php",kIP] ];
        NSString *bobyString=[NSString stringWithFormat:@"customerid=%i&name=%@&telephone=%@&code=%@&address=%@",[DanLi sharDanli].userID,_name.textField.text,_telephone.textField.text,_code.textField.text, _detailAddress.textField.text ];
        
        NSMutableURLRequest  *request=[[NSMutableURLRequest alloc]initWithURL:url];
        [request setHTTPMethod:@"post"];
        [request setHTTPBody:[ bobyString dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSURLConnection  *connecation=[[NSURLConnection alloc]initWithRequest:request delegate:self];
        [connecation start];
        _isSubmit=NO;
    }
    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"%@",dic);
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
      [self errorView];
}

#pragma mark- 错误提醒
-(void)errorView{
        
    UIImageView*connectFaileImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 150, 227)];
    connectFaileImage.image=[UIImage imageNamed:@"ConnectFail.png"];
    [self.view addSubview:connectFaileImage];
    [self performSelector:@selector(retryClick:) withObject:connectFaileImage afterDelay:2];
    
}
-(void)retryClick:(UIImageView*)image{
    [image removeFromSuperview];
   
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)hideKey:(UIControl *)sender {
     [ _telephone.textField  resignFirstResponder];
      [ _code.textField  resignFirstResponder];
      [ _detailAddress.textField  resignFirstResponder];
      [ _name.textField  resignFirstResponder];
}
@end
