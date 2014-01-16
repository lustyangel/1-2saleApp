//
//  evaluateView.m
//  1-2saleApp
//
//  Created by TY on 14-1-13.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import "evaluateView.h"

@implementation evaluateView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _ShowArray=[[NSMutableArray alloc]init];
        _lData=[[NSMutableData alloc]init];
        
        _lTabelView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 310, 450) style:UITableViewStylePlain];
        _lTabelView.delegate=self;
        _lTabelView.dataSource=self;
        [self addSubview:_lTabelView];
        
        [self getdata];
    }
    return self;
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  _ShowArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID=@"cellID";
    UITableViewCell *lCell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (lCell==nil) {
        lCell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//        [lCell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
//        lCell.textLabel.font=[UIFont systemFontOfSize:15];
    }else{
        [[lCell viewWithTag:101]removeFromSuperview];
        [[lCell viewWithTag:102]removeFromSuperview];
        [[lCell viewWithTag:103]removeFromSuperview];
    }
    int row=[indexPath row];
    NSDictionary *lDic=[_ShowArray objectAtIndex:row];
    
    UILabel *name=[[UILabel alloc]initWithFrame:CGRectMake(5, 5, 80, 20)];
    name.tag=101;
    name.text=[lDic objectForKey:@"name"];
    name.font=[UIFont systemFontOfSize:15];
    name.backgroundColor=[UIColor clearColor];
    [lCell.contentView addSubview:name];
    
    UILabel *detail=[[UILabel alloc]initWithFrame:CGRectMake(5, 30, 310, 50)];
    detail.numberOfLines=3;
    detail.tag=102;
    detail.text=[lDic objectForKey:@"detail"];
    detail.font=[UIFont systemFontOfSize:14];
    detail.backgroundColor=[UIColor clearColor];
    [lCell.contentView addSubview:detail];
    
    UILabel *date=[[UILabel alloc]initWithFrame:CGRectMake(5, 85, 150, 20)];
    date.tag=103;
    date.text=[lDic objectForKey:@"date"];
    date.font=[UIFont systemFontOfSize:13];
    date.backgroundColor=[UIColor clearColor];
    [lCell.contentView addSubview:date];
    
    return lCell;
}

-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

-(void)getdata{
    NSString *bodyString=[NSString stringWithFormat:@"goodsid=15&owncount=%i",_ShowArray.count];
//    NSString *bodyString=[NSString stringWithFormat:@"goodsid=%i&owncount=%i",[DanLi sharDanli].goodsID,_ShowArray.count];
    
    NSURL *lUrl=[NSURL URLWithString:[NSString stringWithFormat:@"http://%@/shop/getreview.php",kIP]];
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
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    _retryButton.hidden=YES;
    _connectFaileImage.hidden=YES;
    NSDictionary *lDic=[NSJSONSerialization JSONObjectWithData:_lData options:NSJSONReadingAllowFragments error:nil];
    NSDictionary *lDic1=[lDic objectForKey:@"msg"];
    [_ShowArray setArray:[lDic1 objectForKey:@"infos"]];
    
    [_lTabelView reloadData];
}

-(void)retryClick:(UIButton *)sender{
    [self getdata];
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
