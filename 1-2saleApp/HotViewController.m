//
//  HotViewController.m
//  1-2saleApp
//
//  Created by TY on 14-1-7.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import "HotViewController.h"

@interface HotViewController ()

@end

@implementation HotViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _lData=[[NSMutableData alloc]init];
        _showArray=[[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self getdata];
    
    // Do any additional setup after loading the view from its nib.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getdata{
    NSString *bodyString=@"type=0&order=0&owncount=0";
    
    NSURL *lUrl=[NSURL URLWithString:[NSString stringWithFormat:@"http://%@/shop/hotgoods.php ",kIP]];
    //    NSURL *lUrl=[NSURL URLWithString:@"http://192.168.1.125/shop/getgoods.php"];
    NSMutableURLRequest *lRequest1=[NSMutableURLRequest requestWithURL:lUrl];
    [lRequest1 setHTTPMethod:@"post"];
    [lRequest1 setHTTPBody:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLConnection *lConnection1=[NSURLConnection connectionWithRequest:lRequest1 delegate:self];
    [lConnection1 start];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [_lData setLength:0];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [_lData appendData:data];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"%@",error);
    UIAlertView *lAlertView=[[UIAlertView alloc]initWithTitle:@"错误提示" message:@"网络连接错误，请检查网络连接" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [lAlertView show];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSDictionary *lDic=[NSJSONSerialization JSONObjectWithData:_lData options:NSJSONReadingAllowFragments error:nil];
    [_showArray setArray:[lDic objectForKey:@"msg"]];
    [self showView];
}

-(void)showView{
    for (int i=0; i<10; i++) {
        NSDictionary *lDic=[_showArray objectAtIndex:i];
        if (i<9) {
            HotView *lHotView=[[HotView alloc]initWithDictionary:lDic];
            lHotView.frame=CGRectMake(5+i%3*105, 5+i/3*145, 300, 300);
            [self.view addSubview:lHotView];
        }
        else{
            HotView *lHotView=[[HotView alloc]initWithDictionary:lDic];
            lHotView.frame=CGRectMake(5, 5+i/3*145, 310, 100);
            [self.view addSubview:lHotView];
        }
    }
}



@end