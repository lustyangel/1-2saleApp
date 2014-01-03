//
//  mainViewController.m
//  1-2saleApp
//
//  Created by TY on 14-1-2.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import "mainViewController.h"

@interface mainViewController ()

@end

@implementation mainViewController

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
    // Do any additional setup after loading the view from its nib.
    
    
    
    _lSearchButton=[[UIButton alloc]initWithFrame:CGRectMake(270, 50, 36, 30)];
    [_lSearchButton setImage:[UIImage imageNamed:@"searchButton1.png"] forState:UIControlStateNormal];
    _lSearchButton.backgroundColor=[UIColor colorWithRed:1 green:66/255 blue:66/255 alpha:1];
    [_lSearchButton addTarget:self action:@selector(searchClickUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [_lSearchButton addTarget:self action:@selector(searchClickDown:) forControlEvents:UIControlEventTouchDown];
    [_lSearchButton addTarget:self action:@selector(searchCancelClick:) forControlEvents:UIControlEventTouchCancel];
    [_lSearchButton addTarget:self action:@selector(searchCancelClick:) forControlEvents:UIControlEventTouchUpOutside];
    [self.view addSubview:_lSearchButton];
    
    
//    _lHotButton=[[UIButton alloc]initWithFrame:CGRectMake(10, 10, 36, 30)];
//    [_lHotButton setTitle:@"Hot" forState:UIControlStateNormal];
//    _lHotButton.tintColor=[UIColor whiteColor];
////    [lHotButton setImage:[UIImage imageNamed:@"searchButton1.png"] forState:UIControlStateNormal];
//    _lHotButton.backgroundColor=[UIColor colorWithRed:1 green:66/255 blue:66/255 alpha:1];
//    [_lHotButton addTarget:self action:@selector(HotClickUpInside:) forControlEvents:UIControlEventTouchUpInside];
//    [_lHotButton addTarget:self action:@selector(HotClickDown:) forControlEvents:UIControlEventTouchDown];
//    [_lHotButton addTarget:self action:@selector(HotCancelClick:) forControlEvents:UIControlEventTouchCancel];
//    [_lHotButton addTarget:self action:@selector(HotCancelClick:) forControlEvents:UIControlEventTouchUpOutside];
//    [self.view addSubview:_lHotButton];
    
    LLSearchBar *lSearchBar=[[LLSearchBar alloc]initWithFrame:CGRectMake(10, 50, 250, 30)];
    lSearchBar.LLDelegate=self;
    [self.view addSubview:lSearchBar];
    
    _lDeleteButton=[[UIButton alloc]initWithFrame:CGRectMake(225, 8, 15, 15)];
    _lDeleteButton.tag=101;
    _lDeleteButton.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"delete.png"]];
    _lDeleteButton.hidden=YES;
    [lSearchBar addSubview:_lDeleteButton];
    
    
    LLToolbar *lToolbar=[[LLToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [self.view addSubview:lToolbar];
    
    _lTabelView=[[UITableView alloc]initWithFrame:CGRectMake(0, 120, 320, 458) style:UITableViewStylePlain];
    _lTabelView.delegate=self;
    _lTabelView.dataSource=self;
    [self.view addSubview:_lTabelView];
    
    NSString *bodyString=@"type=0&order=0&owncount=0";
    NSURL *lUrl=[NSURL URLWithString:@"http://192.168.1.125/shop/getgoods.php"];
    NSMutableURLRequest *lRequest1=[NSMutableURLRequest requestWithURL:lUrl];
    [lRequest1 setHTTPMethod:@"post"];
    [lRequest1 setHTTPBody:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLConnection *lConnection1=[NSURLConnection connectionWithRequest:lRequest1 delegate:self];
    [lConnection1 start];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)searchClickDown:(UIButton *)sender{
    sender.backgroundColor=[UIColor colorWithRed:0.8 green:66/255 blue:66/255 alpha:1];
}
-(void)searchClickUpInside:(UIButton *)sender{
    sender.backgroundColor=[UIColor colorWithRed:1 green:66/255 blue:66/255 alpha:1];
}
-(void)searchCancelClick:(UIButton *)sender{
    sender.backgroundColor=[UIColor colorWithRed:1 green:66/255 blue:66/255 alpha:1];
}


-(void)HotClickDown:(UIButton *)sender{
    [sender setTitle:@"Hot" forState:UIControlStateHighlighted];
    sender.backgroundColor=[UIColor colorWithRed:0.8 green:66/255 blue:66/255 alpha:1];
}
-(void)HotClickUpInside:(UIButton *)sender{
    sender.backgroundColor=[UIColor colorWithRed:1 green:66/255 blue:66/255 alpha:1];
}
-(void)HotCancelClick:(UIButton *)sender{
    sender.backgroundColor=[UIColor colorWithRed:1 green:66/255 blue:66/255 alpha:1];
}

-(BOOL)LLtextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSLog(@"%lu,%lu",(unsigned long)range.location,(unsigned long)range.length);
    if (range.location==0&&range.length==1){
        _lDeleteButton.hidden=YES;
        [_lSearchButton setImage:nil forState:UIControlStateNormal];
        [_lSearchButton setTitle:@"取消" forState:UIControlStateNormal];
        _lSearchButton.titleLabel.font=[UIFont systemFontOfSize:15];
    }
    else{
        _lDeleteButton.hidden=NO;
        [_lSearchButton setImage:[UIImage imageNamed:@"searchButton1.png"] forState:UIControlStateNormal];
    }
    return YES;
}
-(void)LLtextFieldDidBeginEditing:(UITextField *)textField{
    [_lSearchButton setImage:nil forState:UIControlStateNormal];
    [_lSearchButton setTitle:@"取消" forState:UIControlStateNormal];
    _lSearchButton.titleLabel.font=[UIFont systemFontOfSize:15];
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
    NSDictionary *lDic1=[lDic objectForKey:@"msg"];
    _showArray=[lDic1 objectForKey:@"infos"];
    [_lTabelView reloadData];
    //    NSDictionary *lDic2=[_showArray objectAtIndex:0];
    //    NSString *lStr=[lDic2 objectForKey:@"name"];
    //    UIImageView *lImageView=[[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 50, 50)];
    //    [self.view addSubview:lImageView];
    //    NSLog(@"%@",lStr);
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _showArray.count;
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID=@"cellID";
    LLTabelViewCell *lCell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (lCell==nil) {
        lCell=[[LLTabelViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    NSInteger row=[indexPath row];
    NSDictionary *lDic=[_showArray objectAtIndex:row];
    lCell.nameLabel.text=[lDic objectForKey:@"name"];
    lCell.priceLabel.text=[NSString stringWithFormat:@"    ¥ %@",[lDic objectForKey:@"price"]];
    lCell.sellCount.text=[NSString stringWithFormat:@"    已售：%@",[lDic objectForKey:@"sellcount"]];
    return lCell;
}

@end
