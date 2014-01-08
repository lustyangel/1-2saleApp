//
//  EditAddressViewController.m
//  1-2saleApp
//
//  Created by TY on 14-1-8.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import "EditAddressViewController.h"

@interface EditAddressViewController ()

@end

@implementation EditAddressViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _dictionary =[[NSDictionary alloc]init];

        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _data =[[NSMutableData alloc]init];
    UILabel  *lable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    [lable setText:@"   收货地址管理"];
    lable.backgroundColor=[UIColor grayColor];
    [lable setTextColor:[UIColor blackColor]];
    [lable setFont:[UIFont systemFontOfSize:18]];
    [self.view addSubview:lable];
    
    UILabel  *addresslabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 50, 90, 30)];
    [addresslabel setText:@"收货地址：" ];
    addresslabel.textAlignment=NSTextAlignmentRight;
    addresslabel.font=[UIFont systemFontOfSize:16];
    addresslabel.backgroundColor=[UIColor clearColor];
    [self.view addSubview:addresslabel];
    
    _detailAddress=[[UITextField alloc]initWithFrame:CGRectMake(40,80, 300, 30)];
    _detailAddress.borderStyle=UITextBorderStyleNone;
    _detailAddress.font=[UIFont systemFontOfSize:14];
    _detailAddress.text= [_dictionary objectForKey:@"address"];
    [self.view addSubview:_detailAddress];
    
    UILabel  *namelabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 110, 90, 30)];
    [namelabel setText:@"收货人：" ];
    namelabel.font=[UIFont systemFontOfSize:16];
    
    namelabel.textAlignment=NSTextAlignmentRight;
    namelabel.backgroundColor=[UIColor clearColor];
    [self.view addSubview:namelabel];
    
    _name=[[UITextField alloc]initWithFrame:CGRectMake(100, 115, 250, 30)];
    _name.borderStyle=UITextBorderStyleNone;
    _name.text= [_dictionary objectForKey:@"name"];
    [self.view addSubview:_name];
    
    
    UILabel  *telephonelabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 140, 90, 30)];
    [telephonelabel setText:@"联系电话：" ];
    telephonelabel.font=[UIFont systemFontOfSize:16];
    
    telephonelabel.textAlignment=NSTextAlignmentRight;
    // telephonelabel.backgroundColor=[UIColor redColor];
    telephonelabel.backgroundColor=[UIColor clearColor];
    [self.view addSubview:telephonelabel];
    
    _telephone=[[UITextField alloc]initWithFrame:CGRectMake(100, 145, 250, 30)];
    _telephone.borderStyle=UITextBorderStyleNone;
    _telephone.text=[_dictionary objectForKey:@"telephone"];
    [self.view addSubview:_telephone];
    
    UILabel  *codelabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 170, 90, 30)];
    [codelabel setText:@"邮编：" ];
    codelabel.font=[UIFont systemFontOfSize:16];
    codelabel.textAlignment=NSTextAlignmentRight;
    codelabel.backgroundColor=[UIColor clearColor];
    [self.view addSubview:codelabel];
    
    _code=[[UITextField alloc]initWithFrame:CGRectMake(100, 175, 250, 30)];
    _code.borderStyle=UITextBorderStyleNone;
    _code.text=[_dictionary objectForKey:@"code"];
    [self.view addSubview:_code];
    
    
    
    UIButton  *deletebutton=[UIButton buttonWithType:UIButtonTypeCustom];
    deletebutton.frame=CGRectMake(100, self.view.frame.size.height-70, 40,40);
    deletebutton.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"delete.jpg"]];
    [deletebutton addTarget:self action:@selector(deleteAddress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deletebutton];
    
    
    
    UIButton  * button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(220, self.view.frame.size.height-70, 60,30);
    button.backgroundColor=[UIColor redColor];
    [button setTitle: @"提交" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(submitAddress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    // Do any additional setup after loading the view from its nib.
}
-(void)deleteAddress:(UIButton*)sender{
    NSURL *url=[NSURL URLWithString:@"http://192.168.1.137/shop/deleteaddress.php" ];
    int addressId=[[_dictionary objectForKey:@"addressid"]intValue];
    NSLog(@"%i",addressId);
    NSString *bobyString=[NSString stringWithFormat:@"addressid=%i",addressId ];
    
    NSMutableURLRequest  *request=[[NSMutableURLRequest alloc]initWithURL:url];
    [request setHTTPMethod:@"post"];
    [request setHTTPBody:[ bobyString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLConnection  *connecation=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    [connecation start];

    
}
-(void)submitAddress:(UIButton*)sender{
    NSURL *url=[NSURL URLWithString:@"http://192.168.1.137/shop/addaddress.php" ];
    NSString *bobyString=[NSString stringWithFormat:@"customerid=3&name=%@&telephone=%@&code=%@&address=%@",_name.text,_telephone.text,_code.text, _detailAddress.text ];
    
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
    NSLog(@"%@",dic);
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"%@",error);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)hideKey:(UIControl *)sender {
     [ _telephone  resignFirstResponder];
      [ _code  resignFirstResponder];
      [ _detailAddress  resignFirstResponder];
      [ _name  resignFirstResponder];
}
@end
