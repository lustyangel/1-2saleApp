//
//  ShowHotView.m
//  1-2saleApp
//
//  Created by TY on 14-1-7.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import "ShowHotView.h"

@implementation ShowHotView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _lData=[[NSMutableData alloc]init];
        _showArray=[[NSMutableArray alloc]init];
        
//        self.backgroundColor=[UIColor underPageBackgroundColor];
        _lScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 504)];
        _lScrollView.delegate=self;
        _lScrollView.contentSize=CGSizeMake(320, 10+5*170);
        [self addSubview:_lScrollView];
        
        
        [self getdata];
    }
    return self;
}

-(void)getdata{
    NSString *bodyString=@"type=0&order=0&owncount=0";
    
    NSURL *lUrl=[NSURL URLWithString:[NSString stringWithFormat:@"http://%@/shop/hotgoods.php ",kIP]];
    //    NSURL *lUrl=[NSURL URLWithString:@"http://192.168.1.125/shop/getgoods.php"];
    NSMutableURLRequest *lRequest1=[NSMutableURLRequest requestWithURL:lUrl];
    [lRequest1 setTimeoutInterval:5];
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
//    _lTabelView.hidden=YES;
    if (_connectFaileImage==nil) {
        _connectFaileImage=[[UIImageView alloc]initWithFrame:CGRectMake(90, 150, 150, 227)];
        _connectFaileImage.image=[UIImage imageNamed:@"ConnectFail.png"];
        [self addSubview:_connectFaileImage];
        
        _retryButton=[[UIButton alloc]initWithFrame:CGRectMake(130, 350, 70, 30)];
        _retryButton.layer.borderColor=[UIColor darkGrayColor].CGColor;
        _retryButton.layer.borderWidth=1;
        [_retryButton setImage:[UIImage imageNamed:@"retry.png"] forState:UIControlStateNormal];
        _retryButton.backgroundColor=[UIColor grayColor];
        _retryButton.titleLabel.textColor=[UIColor blackColor];
        [_retryButton addTarget:self action:@selector(retryClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_retryButton];
    }
    _retryButton.hidden=NO;
    _connectFaileImage.hidden=NO;
//    UIAlertView *lAlertView=[[UIAlertView alloc]initWithTitle:@"错误提示" message:@"网络连接错误，请检查网络连接" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//    [lAlertView show];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    _retryButton.hidden=YES;
    _connectFaileImage.hidden=YES;
    NSDictionary *lDic=[NSJSONSerialization JSONObjectWithData:_lData options:NSJSONReadingAllowFragments error:nil];
    [_showArray setArray:[lDic objectForKey:@"msg"]];
    [self showView];
}

-(void)retryClick:(UIButton *)sender{
    [self getdata];
}

-(void)showView{
    for (int i=0; i<10; i++) {
        NSDictionary *lDic=[_showArray objectAtIndex:i];
        HotView *lHotView=[[HotView alloc]initWithDictionary:lDic];
        lHotView.frame=CGRectMake(10+i%2*160, 10+i/2*170, 140, 160);
        lHotView.LLDelegate=self;
            [_lScrollView addSubview:lHotView];
//        }
//        else{
//            HotView *lHotView=[[HotView alloc]initWithDictionary:lDic];
//            lHotView.frame=CGRectMake(3, 5+i/3*133, 313, 98);
//            [_lScrollView addSubview:lHotView];
//        }
    }
}

-(void)HotViewClick{
    [_LLDelegate ShowHotViewClick];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
