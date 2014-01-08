//
//  AddressViewController.m
//  1-2saleApp
//
//  Created by TY on 14-1-6.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import "AddressViewController.h"

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
    
    UILabel  *lable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    [lable setText:@"  收货地址"];
    lable.backgroundColor=[UIColor grayColor];
    [lable setTextColor:[UIColor blackColor]];
    [lable setFont:[UIFont systemFontOfSize:18]];
    [self.view addSubview:lable];
    
   
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(5, 40, 320, self.view.frame.size.height ) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
     _tableView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:_tableView];
    
    
    _cityArray=[[NSMutableArray alloc]initWithArray:[[self getAllCity]allKeys]];
    
  
    // Do any dditional setup after loading the view from its nib.
}
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
           
            UIView  *view=[self addressView];
           [self.view addSubview:view];
           
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

-(void)buttonClick:(UIButton*)sender{
        _isClick=YES;
     [_cityString  setString:@" "];
        [sender removeFromSuperview];
        _tableView.frame=CGRectMake(5, 40, 320, self.view.frame.size.height );
         _cityArray=[NSMutableArray  arrayWithArray:[[self getAllCity]allKeys]];
        [_tableView  reloadData];
     
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [_data setLength:0];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [_data setData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
   // NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingAllowFragments error:nil];
  // NSLog(@"%@",dic);
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"%@",error);
}


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
-(UIView*)addressView{
    UIView  *view=[[UIView alloc]initWithFrame:CGRectMake(5, 50, 320, self.view.frame.size.height)];
    UILabel  *label=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 320, 40)];
    [label setText:  [NSString stringWithFormat:@"所在地区:%@",_cityString]];
    label.backgroundColor=[UIColor clearColor];
    [view addSubview:label];
    
_detailRess=[[UITextField alloc]initWithFrame:CGRectMake(20, 45, 250, 30)];
    _detailRess.borderStyle=UITextBorderStyleRoundedRect;
    _detailRess.placeholder=@"请输入详细的街道地址";
    [view addSubview:_detailRess];
    
     _name=[[UITextField alloc]initWithFrame:CGRectMake(20, 80, 250, 30)];
    _name.borderStyle=UITextBorderStyleRoundedRect;
    _name.placeholder=@"请输入收货人姓名";
    [view addSubview:_name];
    
    _telephone=[[UITextField alloc]initWithFrame:CGRectMake(20, 115, 250, 30)];
    _telephone.borderStyle=UITextBorderStyleRoundedRect;
    _telephone.placeholder=@"请输入收货人联系电话";
    [view addSubview:_telephone];
    
    _code=[[UITextField alloc]initWithFrame:CGRectMake(20, 150, 250, 30)];
    _code.borderStyle=UITextBorderStyleRoundedRect;
    _code.placeholder=@"请输入邮编";
    [view addSubview:_code];
    
    
    UIButton  * button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(120, 190, 60,30);
    button.backgroundColor=[UIColor redColor];
    [button setTitle: @"提交" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(submitAddress:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.textAlignment=NSTextAlignmentLeft;
    [view addSubview:button];
    
    return view;
   
}
-(void)submitAddress:(UIButton*)sender{
    
  
   [_cityString appendString:_detailRess.text];
      NSURL *url=[NSURL URLWithString:@"http://192.168.1.137/shop/addaddress.php" ];
    NSString *bobyString=[NSString stringWithFormat:@"customerid=3&name=%@&telephone=%@&code=%@&address=%@",_name.text,_telephone.text,_code.text, _cityString ];
    
    NSMutableURLRequest  *request=[[NSMutableURLRequest alloc]initWithURL:url];
    [request setHTTPMethod:@"post"];
    [request setHTTPBody:[ bobyString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLConnection  *connecation=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    [connecation start];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
