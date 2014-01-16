//
//  GoodsIngoViewController.m
//  1-2saleApp
//
//  Created by TY on 14-1-8.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import "GoodsIngoViewController.h"
#import "ShoppingCartInterface.h"

@interface GoodsIngoViewController ()

@end

@implementation GoodsIngoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _lData=[[NSMutableData alloc]init];
        _lDic=[[NSDictionary alloc]init];
        _lBoolDetailInfo=NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self getdata];
    
    UIView *titleView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    titleView.backgroundColor=[UIColor underPageBackgroundColor];
    [self.view addSubview:titleView];
    
    UIButton *lButton=[[UIButton alloc]initWithFrame:CGRectMake(0,0, 44, 44)];
    [lButton setImage:[UIImage imageNamed:@"title_back.png"] forState:UIControlStateNormal];
    [lButton addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:lButton];
    
    _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    _titleLabel.center=CGPointMake(160, 22);
    _titleLabel.text=@"商品信息";
    _titleLabel.textAlignment=NSTextAlignmentCenter;
    _titleLabel.backgroundColor=[UIColor clearColor];
    [titleView addSubview:_titleLabel];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 返回按钮

-(void)backClick:(UIButton *)sender{
    if (_lBoolDetailInfo) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            _lWebView.center=CGPointMake(480, _lWebView.center.y);
        }completion:nil];
        _lBoolDetailInfo=NO;
        _titleLabel.text=@"商品信息";
    }
    else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - 获取基本商品信息

-(void)getdata{
    NSString *bodyString=[NSString stringWithFormat:@"goodsid=%i",[DanLi sharDanli].goodsID];
    
    NSURL *lUrl=[NSURL URLWithString:[NSString stringWithFormat:@"http://%@/shop/getgoodsinfo.php",kIP]];
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
        [self.view addSubview:_connectFaileImage];
        
        _retryButton=[[UIButton alloc]initWithFrame:CGRectMake(130, 350, 70, 30)];
        _retryButton.layer.borderColor=[UIColor darkGrayColor].CGColor;
        _retryButton.layer.borderWidth=1;
        [_retryButton setImage:[UIImage imageNamed:@"retry.png"] forState:UIControlStateNormal];
        _retryButton.backgroundColor=[UIColor grayColor];
        _retryButton.titleLabel.textColor=[UIColor blackColor];
        [_retryButton addTarget:self action:@selector(retryClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_retryButton];
    }
    _retryButton.hidden=NO;
    _connectFaileImage.hidden=NO;
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    _retryButton.hidden=YES;
    _connectFaileImage.hidden=YES;
    NSDictionary *lDic=[NSJSONSerialization JSONObjectWithData:_lData options:NSJSONReadingAllowFragments error:nil];
    _lDic=[lDic objectForKey:@"msg"];
    [self showGoodsInfo];
}

-(void)retryClick:(UIButton *)sender{
    [self getdata];
}

#pragma mark - 加载界面

-(void)showGoodsInfo{
    [self getImage];
    
    _lScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 44, 320, 504)];
    _lScrollView.contentSize=CGSizeMake(320, 504);
    _lScrollView.bounces=NO;
    [self.view addSubview:_lScrollView];
    
    UILabel *name=[[UILabel alloc]initWithFrame:CGRectMake(160, 5, 155, 75)];
    name.numberOfLines=5;
    name.text=[_lDic objectForKey:@"name"];
    name.font=[UIFont systemFontOfSize:14];
    [_lScrollView addSubview:name];
    
    UILabel *price=[[UILabel alloc]initWithFrame:CGRectMake(160, 80, 155, 20)];
    price.text=[NSString stringWithFormat:@"¥ %@",[_lDic objectForKey:@"price"]];
    price.font=[UIFont systemFontOfSize:14];
    price.textColor=[UIColor redColor];
    [_lScrollView addSubview:price];
    
    UILabel *cellcount=[[UILabel alloc]initWithFrame:CGRectMake(160, 100, 155, 20)];
    cellcount.text=[NSString stringWithFormat:@"已售：%@ 件",[_lDic objectForKey:@"sellcount"]];
    cellcount.font=[UIFont systemFontOfSize:14];
    cellcount.textColor=[UIColor darkGrayColor];
    [_lScrollView addSubview:cellcount];
    
    UIButton *lBuyButton=[[UIButton alloc]initWithFrame:CGRectMake(160, 160, 75, 25)];
    lBuyButton.backgroundColor=[UIColor colorWithRed:1 green:0.2 blue:0 alpha:1];
    lBuyButton.titleLabel.font=[UIFont systemFontOfSize:15];
    [lBuyButton setTitle:@"我的购物车" forState:UIControlStateNormal];
    [lBuyButton addTarget: self action:@selector(buyClick:) forControlEvents:UIControlEventTouchUpInside];
    [lBuyButton addTarget: self action:@selector(buyCancel:) forControlEvents:UIControlEventTouchCancel];
    [lBuyButton addTarget: self action:@selector(buyCancel:) forControlEvents:UIControlEventTouchUpOutside];
    [lBuyButton addTarget: self action:@selector(buyTouchDown:) forControlEvents:UIControlEventTouchDown];
    [_lScrollView addSubview:lBuyButton];
    
    UIButton *addShopCar=[[UIButton alloc]initWithFrame:CGRectMake(240, 160, 75, 25)];
    addShopCar.backgroundColor=[UIColor orangeColor];
    [addShopCar setTitle:@"加入购物车" forState:UIControlStateNormal];
    addShopCar.titleLabel.font=[UIFont systemFontOfSize:15];
    [addShopCar addTarget: self action:@selector(addShopCarClick:) forControlEvents:UIControlEventTouchUpInside];
    [addShopCar addTarget: self action:@selector(addShopCarCancel:) forControlEvents:UIControlEventTouchCancel];
    [addShopCar addTarget: self action:@selector(addShopCarCancel:) forControlEvents:UIControlEventTouchUpOutside];
    [addShopCar addTarget: self action:@selector(addShopCarDown:) forControlEvents:UIControlEventTouchDown];
    [_lScrollView addSubview:addShopCar];
    
    UIButton *jianButton=[[UIButton alloc]initWithFrame:CGRectMake(180, 125, 25, 25)];
    jianButton.backgroundColor=[UIColor grayColor];
    [jianButton setTitle:@"-" forState:UIControlStateNormal];
    [jianButton addTarget:self action:@selector(jianClick:) forControlEvents:UIControlEventTouchUpInside];
    [jianButton addTarget:self action:@selector(jianTouchDown:) forControlEvents:UIControlEventTouchDown];
    [_lScrollView addSubview:jianButton];
    
    UIButton *jiaButton=[[UIButton alloc]initWithFrame:CGRectMake(275, 125, 25, 25)];
    jiaButton.backgroundColor=[UIColor grayColor];
    [jiaButton setTitle:@"+" forState:UIControlStateNormal];
    [jiaButton addTarget:self action:@selector(jiaClick:) forControlEvents:UIControlEventTouchUpInside];
    [jiaButton addTarget:self action:@selector(jiaTouchDown:) forControlEvents:UIControlEventTouchDown];
    [_lScrollView addSubview:jiaButton];
    

    _lNumber=[[UITextField alloc]initWithFrame:CGRectMake(210, 125, 60, 25)];
    _lNumber.borderStyle=UITextBorderStyleLine;
    _lNumber.text=@"1";
    _lNumber.textAlignment=NSTextAlignmentCenter;
    [_lNumber addTarget:self action:@selector(editEnd:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [_lScrollView addSubview:_lNumber];
    
    UILabel *baseInfo=[[UILabel alloc]initWithFrame:CGRectMake(5, 175, 70, 20)];
    baseInfo.textAlignment=NSTextAlignmentCenter;
    baseInfo.backgroundColor=[UIColor lightGrayColor];
    baseInfo.text=@"基本信息";
    baseInfo.font=[UIFont systemFontOfSize:16];
    baseInfo.textColor=[UIColor whiteColor];
    [_lScrollView addSubview:baseInfo];
    
//    UIView *line1=[[UIView alloc]initWithFrame:CGRectMake(5, 200, 310, 1)];
//    line1.backgroundColor=[UIColor lightGrayColor];
//    [_lScrollView addSubview:line1];
    
    
    UILabel *detail=[[UILabel alloc]initWithFrame:CGRectMake(5, 205, 60, 20)];
    detail.text=@"商品描述:";
    detail.font=[UIFont systemFontOfSize:14];
    [_lScrollView addSubview:detail];
    
    UITextView *lTextView=[[UITextView alloc]initWithFrame:CGRectMake(70, 200, 240, 60)];
    lTextView.text=[_lDic objectForKey:@"detail"];
    lTextView.font=[UIFont systemFontOfSize:14];
    lTextView.bounces=NO;
    lTextView.editable=NO;
    lTextView.backgroundColor=[UIColor clearColor];
    [_lScrollView addSubview:lTextView];
    
    UILabel *color=[[UILabel alloc]initWithFrame:CGRectMake(5, 265, 60, 20)];
    color.text=@"颜       色:";
    color.font=[UIFont systemFontOfSize:14];
    [_lScrollView addSubview:color];
    
    UILabel *colorInfo=[[UILabel alloc]initWithFrame:CGRectMake(75, 265, 200, 20)];
    colorInfo.text=[_lDic objectForKey:@"color"];
    colorInfo.font=[UIFont systemFontOfSize:14];
    [_lScrollView addSubview:colorInfo];
    
    UILabel *size=[[UILabel alloc]initWithFrame:CGRectMake(5, 290, 60, 20)];
    size.text=@"型       号:";
    size.font=[UIFont systemFontOfSize:14];
    [_lScrollView addSubview:size];
    
    UILabel *sizeInfo=[[UILabel alloc]initWithFrame:CGRectMake(75, 290, 200, 20)];
    sizeInfo.text=[_lDic objectForKey:@"size"];
    sizeInfo.font=[UIFont systemFontOfSize:14];
    [_lScrollView addSubview:sizeInfo];
    
    UIView *line2=[[UIView alloc]initWithFrame:CGRectMake(5, 315, 310, 1)];
    line2.backgroundColor=[UIColor lightGrayColor];
    [_lScrollView addSubview:line2];
    
    UILabel *detailInfo=[[UILabel alloc]initWithFrame:CGRectMake(5, 320, 70, 20)];
    detailInfo.textAlignment=NSTextAlignmentCenter;
    detailInfo.backgroundColor=[UIColor lightGrayColor];
    detailInfo.text=@"详细信息";
    detailInfo.font=[UIFont systemFontOfSize:16];
    detailInfo.textColor=[UIColor whiteColor];
    [_lScrollView addSubview:detailInfo];
    
//    UIView *line3=[[UIView alloc]initWithFrame:CGRectMake(5, 345, 310, 1)];
//    line3.backgroundColor=[UIColor lightGrayColor];
//    [_lScrollView addSubview:line3];
    
    UITableView *lTabelView=[[UITableView alloc]initWithFrame:CGRectMake(5, 345, 310, 120) style:UITableViewStylePlain];
    lTabelView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    lTabelView.layer.borderWidth=1;
    lTabelView.layer.cornerRadius=5;
    lTabelView.delegate=self;
    lTabelView.dataSource=self;
    lTabelView.bounces=NO;
    [_lScrollView addSubview:lTabelView];
    
    UIButton *PingJia=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    PingJia.frame=CGRectMake(5, 470, 310, 30);
//    PingJia.layer.cornerRadius=5;
//    PingJia.layer.borderColor=[UIColor grayColor].CGColor;
//    PingJia.layer.borderWidth=1;
    [PingJia setTitle:@"点击查看评论" forState:UIControlStateNormal];
    [PingJia setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [PingJia addTarget:self action:@selector(scanEvaluate:) forControlEvents:UIControlEventTouchUpInside];
    [_lScrollView addSubview:PingJia];
}

-(void)getImage{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *lURL=[NSURL URLWithString:[NSString stringWithFormat:@"http://%@/shop/goodsimage/%@",kIP,[_lDic objectForKey:@"headerimage"]]];
        NSData *lData=[NSData dataWithContentsOfURL:lURL];
        UIImage *lImage=[[UIImage alloc]initWithData:lData];
        dispatch_sync(dispatch_get_main_queue(), ^{
            UIImageView *lImageView=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 150, 150)];
            lImageView.image=lImage;
            lImageView.layer.borderColor=[UIColor grayColor].CGColor;
            lImageView.layer.borderWidth=1;
            [_lScrollView addSubview:lImageView];
        });
    });
}

#pragma mark - tabelView商品详细信息

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID=@"cellID";
    UITableViewCell *lCell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (lCell==nil) {
        lCell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        [lCell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        lCell.textLabel.font=[UIFont systemFontOfSize:15];
    }
    int row=[indexPath row];
    switch (row) {
        case 0:
            lCell.textLabel.text=@"图片详情";
            break;
        case 1:
            lCell.textLabel.text=@"详细参数";
            break;
        case 2:
            lCell.textLabel.text=@"包装清单";
            break;
        case 3:
            lCell.textLabel.text=@"售后服务";
            break;
            
        default:
            break;
    }
    return lCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _lBoolDetailInfo=YES;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_lWebView==nil) {
        _lWebView=[[UIWebView alloc]initWithFrame:CGRectMake(320, 44, 320, 504)];
        _lWebView.scrollView.bounces=NO;
        [self.view addSubview:_lWebView];
    }

    
    int row=[indexPath row];
    NSString *lStr=[[NSString alloc]init];
    switch (row) {
        case 0:
            lStr=@"introduction.php";
            _titleLabel.text=@"图片详情";
            break;
        case 1:
            lStr=@"specifications.php";
            _titleLabel.text=@"详细参数";
            break;
        case 2:
            lStr=@"packinglist.php";
            _titleLabel.text=@"包装清单";
            break;
        case 3:
            lStr=@"service.php";
            _titleLabel.text=@"售后服务";
            break;
            
        default:
            break;
    }
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        _lWebView.center=CGPointMake(160, _lWebView.center.y);
        NSURL *lURL=[NSURL URLWithString:[NSString stringWithFormat:@"http://%@/shop/html/%i/%@",kIP,[DanLi sharDanli].goodsID,lStr]];
        NSURLRequest *lRequest=[[NSURLRequest alloc]initWithURL:lURL];
        [_lWebView loadRequest:lRequest];
    }completion:nil];
//     ^(BOOL finished){
//        NSURL *lURL=[NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.1.138/shop/html/%i/%@",[DanLi sharDanli].goodsID,lStr]];
//        NSURLRequest *lRequest=[[NSURLRequest alloc]initWithURL:lURL];
//        [_lWebView loadRequest:lRequest];
//    }
//     ];
}

#pragma mark - 查看评价

-(void)scanEvaluate:(UIButton *)sender{
//    sender.hidden=YES;
    if ([sender.titleLabel.text isEqualToString:@"点击收起"]) {
        [sender setTitle:@"点击查看评论" forState:UIControlStateNormal];
        
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            _lScrollView.contentOffset=CGPointMake(0, 0);
        }completion:^(BOOL finished){
            _lScrollView.contentSize=CGSizeMake(320, 504);
        }];
    }
    else{
        [sender setTitle:@"点击收起" forState:UIControlStateNormal];
        
        _lScrollView.contentSize=CGSizeMake(320, 969);
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            _lScrollView.contentOffset=CGPointMake(0, 465);
        }completion:nil];
        
        evaluateView *lView=[[evaluateView alloc]initWithFrame:CGRectMake(5, 505, 310, 465)];
        [_lScrollView addSubview:lView];
    }

}

#pragma mark - 加减按钮

-(void)jiaTouchDown:(UIButton *)sender{
    sender.backgroundColor=[UIColor blueColor];
}

-(void)jiaClick:(UIButton *)sender{
    sender.backgroundColor=[UIColor grayColor];
    
    int num=[_lNumber.text intValue]+1;
    _lNumber.text=[NSString stringWithFormat:@"%i",num];
}

-(void)jianTouchDown:(UIButton *)sender{
    sender.backgroundColor=[UIColor blueColor];
    
}

-(void)jianClick:(UIButton *)sender{
    sender.backgroundColor=[UIColor grayColor];
    
    int num=[_lNumber.text intValue];
    if (num>1) {
        num=num-1;
    }
    _lNumber.text=[NSString stringWithFormat:@"%i",num];
}


-(void)editEnd:(UITextField *)sender{
    [sender resignFirstResponder];
}


#pragma mark - 立即购买

-(void)buyTouchDown:(UIButton *)sender{
    sender.backgroundColor=[UIColor orangeColor];
}
-(void)buyClick:(UIButton *)sender{
    sender.backgroundColor=[UIColor colorWithRed:1 green:0.2 blue:0 alpha:1];
}

-(void)buyCancel:(UIButton *)sender{
    sender.backgroundColor=[UIColor colorWithRed:1 green:0.2 blue:0 alpha:1];
}

#pragma mark － 加入购物车

-(void)addShopCarDown:(UIButton *)sender{
    sender.backgroundColor=[UIColor colorWithRed:1 green:0.2 blue:0 alpha:1];
}
-(void)addShopCarClick:(UIButton *)sender{
    sender.backgroundColor=[UIColor orangeColor];
    
    NSString *goodsid = [NSString stringWithFormat:@"%i",[DanLi sharDanli].goodsID];
    NSString *goodscount = _lNumber.text;
    NSDictionary *lDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:goodsid,@"goodsid",goodscount,@"goodscount", nil];
    ShoppingCartInterface *lShoppingCartInterface = [[ShoppingCartInterface alloc] init];
    [lShoppingCartInterface addToShoppingCart:lDictionary];
}
-(void)addShopCarCancel:(UIButton *)sender{
    sender.backgroundColor=[UIColor orangeColor];
}

@end
