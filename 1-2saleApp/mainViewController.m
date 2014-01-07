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
        _updown=0;
        _paixu=0;
        _loadState=0;
        _searchState=NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(not:) name:UITextFieldTextDidChangeNotification object:nil];
    
    _mainView=[[UIView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:_mainView];
    
    
    
    LLToolbar *lToolbar=[[LLToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    lToolbar.LLDelegate=self;
    [_mainView addSubview:lToolbar];
    
    
    _lSearchButton=[[UIButton alloc]initWithFrame:CGRectMake(270, 49, 36, 30)];
    [_lSearchButton setImage:[UIImage imageNamed:@"searchButton1.png"] forState:UIControlStateNormal];
    _lSearchButton.backgroundColor=[UIColor colorWithRed:1 green:66/255 blue:66/255 alpha:1];
    [_lSearchButton addTarget:self action:@selector(searchClickUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [_lSearchButton addTarget:self action:@selector(searchClickDown:) forControlEvents:UIControlEventTouchDown];
    [_lSearchButton addTarget:self action:@selector(searchCancelClick:) forControlEvents:UIControlEventTouchCancel];
    [_lSearchButton addTarget:self action:@selector(searchCancelClick:) forControlEvents:UIControlEventTouchUpOutside];
    [_mainView addSubview:_lSearchButton];
    
    
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
    
    _lSearchBar=[[LLSearchBar alloc]initWithFrame:CGRectMake(10, 49, 250, 30)];
    _lSearchBar.LLDelegate=self;
    _lSearchBar.lField.text=@"";
    [_mainView addSubview:_lSearchBar];
    
    _lDeleteButton=[[UIButton alloc]initWithFrame:CGRectMake(225, 8, 15, 15)];
    _lDeleteButton.tag=101;
    _lDeleteButton.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"delete.png"]];
    _lDeleteButton.hidden=YES;
    [_lDeleteButton addTarget:self action:@selector(DeleteClickUpInside:) forControlEvents:UIControlEventTouchUpInside];
//    [_lDeleteButton addTarget:self action:@selector(DeleteClickDown:) forControlEvents:UIControlEventTouchDown];
//    [_lDeleteButton addTarget:self action:@selector(DeleteCancelClick:) forControlEvents:UIControlEventTouchCancel];
//    [_lDeleteButton addTarget:self action:@selector(DeleteCancelClick:) forControlEvents:UIControlEventTouchUpOutside];
    [_lSearchBar addSubview:_lDeleteButton];
    
    
    LLSelectButton *lSelectButton=[[LLSelectButton alloc]initWithFrame:CGRectMake(0, 85, 320, 25)];
    lSelectButton.LLDelegate=self;
    [_mainView addSubview:lSelectButton];
    
    _lTabelView=[[UITableView alloc]initWithFrame:CGRectMake(0, 110, 320, 438) style:UITableViewStylePlain];
    _lTabelView.delegate=self;
    _lTabelView.dataSource=self;
    [_mainView addSubview:_lTabelView];
    
    
    [self getdata];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)not:(NSNotification *)sender{
    UITextField *lText=(UITextField *)[sender object];
    NSLog(@"A:%@",lText.text);
    NSLog(@"%@",[sender userInfo]);
}
-(void)searchClickDown:(UIButton *)sender{
    sender.backgroundColor=[UIColor colorWithRed:0.8 green:66/255 blue:66/255 alpha:1];
}
-(void)searchClickUpInside:(UIButton *)sender{
    sender.backgroundColor=[UIColor colorWithRed:1 green:66/255 blue:66/255 alpha:1];
    
    
    if ([_lSearchBar.lField.text isEqualToString:@""]) {
        if (_lSearchBar.lField.editing==NO) {
            return;
        }else{
            [_lSearchBar.lField resignFirstResponder];
            [_lSearchButton setImage:[UIImage imageNamed:@"searchButton1.png"] forState:UIControlStateNormal];
        }
    }
    else{
        [_showArray removeAllObjects];
        [self searchData:_lSearchBar.lField.text];
        [_lSearchBar.lField resignFirstResponder];
        _searchState=YES;
    }
}
-(void)searchCancelClick:(UIButton *)sender{
    sender.backgroundColor=[UIColor colorWithRed:1 green:66/255 blue:66/255 alpha:1];
}


//-(void)DeleteClickDown:(UIButton *)sender{
//    [sender setTitle:@"Hot" forState:UIControlStateHighlighted];
//    sender.backgroundColor=[UIColor colorWithRed:0.8 green:66/255 blue:66/255 alpha:1];
//}
-(void)DeleteClickUpInside:(UIButton *)sender{
    _lSearchBar.lField.text=@"";
    [_lSearchBar.lField becomeFirstResponder];
    [_lSearchButton setImage:nil forState:UIControlStateNormal];
    [_lSearchButton setTitle:@"取消" forState:UIControlStateNormal];
    _lSearchButton.titleLabel.font=[UIFont systemFontOfSize:15];
    sender.hidden=YES;
}
//-(void)DeleteCancelClick:(UIButton *)sender{
//    sender.backgroundColor=[UIColor colorWithRed:1 green:66/255 blue:66/255 alpha:1];
//}


-(BOOL)LLtextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
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
    if ([textField.text isEqualToString:@""]) {
        [_lSearchButton setImage:nil forState:UIControlStateNormal];
        [_lSearchButton setTitle:@"取消" forState:UIControlStateNormal];
        _lSearchButton.titleLabel.font=[UIFont systemFontOfSize:15];
    }
    
}

#pragma mark - LLToolbar ButtonClick

-(void)buttonItemSelect:(int)selectNumber{
    if (selectNumber==0) {
        self.view.center=CGPointMake(320, self.view.center.y);
    }
    else{
//        RightViewController *leftView=[[RightViewController alloc]init];
        self.lRightView=[[RightViewController alloc]init];
        if (_rightView==nil) {
            _rightView=[[UIView alloc]initWithFrame:self.view.frame];
        }
        self.rightView=self.lRightView.view;
        _rightView.center=CGPointMake(480, self.view.frame.size.height/2);
        [self.view addSubview:_rightView];
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            _mainView.center=CGPointMake(0, self.view.frame.size.height/2);
            _rightView.center=CGPointMake(320, self.view.frame.size.height/2);
        }completion:^(BOOL finish){
            
        }];
        
        NSLog(@"%f,%f",self.view.frame.size.height/2,self.view.center.y);
    }
}

-(void)rightViewTabelViewClick:(int)num{
    switch (num) {
        case 0:
            ;
            break;
            
        default:
            break;
    }
}

#pragma mark - Connect

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
    _sorryImage.hidden=YES;
    _lTabelView.hidden=NO;
    NSDictionary *lDic=[NSJSONSerialization JSONObjectWithData:_lData options:NSJSONReadingAllowFragments error:nil];
    NSDictionary *lDic1=[lDic objectForKey:@"msg"];
    int count=[[lDic1 objectForKey:@"count"]intValue];
    if (_loadState==3) {
        [self updateOK];
        if (_showArray.count<count) {
            [_showArray addObjectsFromArray:[lDic1 objectForKey:@"infos"]];
            [_lTabelView reloadData];
        }
        else{
            UILabel *lLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 40)];
            lLabel.backgroundColor=[UIColor grayColor];
            lLabel.layer.cornerRadius=2;
            lLabel.center=CGPointMake(160, 440);
            lLabel.text=@"已经没有了哦";
            lLabel.alpha=0;
            lLabel.textColor=[UIColor whiteColor];
            lLabel.textAlignment=NSTextAlignmentCenter;
            [_mainView addSubview:lLabel];
            [UIView animateWithDuration:1 delay:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                lLabel.alpha=1;
            }completion:^(BOOL finished){
                [UIView animateWithDuration:1 delay:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    lLabel.alpha=0;
                }completion:nil];
            }];
            return;
        }
        
    }
    
    if (_searchState==YES) {
        if (_backButton==nil) {
            _backButton=[[UIButton alloc]initWithFrame:CGRectMake(280, 350, 40, 120)];
            [_backButton setImage:[UIImage imageNamed:@"backimage.png"] forState:UIControlStateNormal];
            _backButton.alpha=0.5;
//            _backButton.backgroundColor=[UIColor colorWithRed:1 green:0.2 blue:0 alpha:1];
            [_backButton addTarget:self action:@selector(backAllProduct:) forControlEvents:UIControlEventTouchUpInside];
            [_mainView addSubview:_backButton];
        }
        _backButton.hidden=NO;
    }
    
    if (count==0) {
        if (_sorryImage==nil) {
            _sorryImage=[[UIImageView alloc]initWithFrame:CGRectMake(80, 160, 160, 219)];
            _sorryImage.image=[UIImage imageNamed:@"sorry.png"];
            [_mainView addSubview:_sorryImage];
            
            
        }
        
        _sorryImage.hidden=NO;
        _lTabelView.hidden=YES;
        return;
    }
    
    
        [_showArray setArray:[lDic1 objectForKey:@"infos"]];
        [_lTabelView reloadData];
}

-(void)backAllProduct:(UIButton *)sender{
    [_showArray removeAllObjects];
    [self getdata];
    sender.hidden=YES;
    _searchState=NO;
    _lSearchBar.lField.text=@"";
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
    lCell.priceLabel.text=[NSString stringWithFormat:@"¥ %@",[lDic objectForKey:@"price"]];
    lCell.sellCount.text=[NSString stringWithFormat:@"已售：%@",[lDic objectForKey:@"sellcount"]];
    if ([self judgeLocationImage:[lDic objectForKey:@"headerimage"]]!=nil) {
        lCell.lImageView.image=[self judgeLocationImage:[lDic objectForKey:@"headerimage"]];
    }
    
    return lCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(UIImage *)judgeLocationImage:(NSString *)imageName{
    NSString *lStr=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *lPath=[lStr stringByAppendingPathComponent:imageName];
    UIImage *lImage=[UIImage imageWithContentsOfFile:lPath];
    if (lImage==nil) {
        [self getHeadImage:imageName];
        return nil;
    }
    else{
        return lImage;
    }
}

-(void)getHeadImage:(NSString *)imageName{
    if (![self queue]) {
        [self setQueue:[[ASINetworkQueue alloc]init]];
        [self queue].maxConcurrentOperationCount=15;
        [[self queue]setShouldCancelAllRequestsOnFailure:NO];
    }
    NSURL *lUrl=[NSURL URLWithString:[NSString stringWithFormat:@"http://%@/shop/goodsimage/%@",kIP,imageName]];
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:lUrl];
    request.delegate=self;
    
    NSString *lStr=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *lPath=[lStr stringByAppendingPathComponent:imageName];
    
    [request setDownloadDestinationPath:lPath];
    [request setDidFinishSelector:@selector(DownloadFinish:)];
    [request setDidFailSelector:@selector(DownloadFailed:)];
    [_queue addOperation:request];
    [_queue go];
}

-(void)DownloadFinish:(ASIHTTPRequest *)sender{
    [_lTabelView reloadData];
}
-(void)DownloadFailed:(ASIHTTPRequest *)sender{
    NSLog(@"Error");
}

-(void)buttonValueChange:(LLSelectValue)SelectValue{
//    NSLog(@"%@",SelectValue.value1,SelectValue.value2);
    if (SelectValue.value2==2) {
        _paixu=SelectValue.value1;
    }
    if (SelectValue.value1==2) {
        _updown=SelectValue.value2;
    }
    
    if ([_lSearchBar.lField.text isEqualToString:@""]) {
        [_showArray removeAllObjects];
        [self getdata];
    }
    else{
        [_showArray removeAllObjects];
        [self searchData:nil];
    }
    
    
}

-(void)getdata{
    NSString *bodyString=[NSString stringWithFormat:@"type=%i&order=%i&owncount=%i",_paixu,_updown,_showArray.count];

    NSURL *lUrl=[NSURL URLWithString:[NSString stringWithFormat:@"http://%@/shop/getgoods.php",kIP]];
//    NSURL *lUrl=[NSURL URLWithString:@"http://192.168.1.125/shop/getgoods.php"];
    NSMutableURLRequest *lRequest1=[NSMutableURLRequest requestWithURL:lUrl];
    [lRequest1 setHTTPMethod:@"post"];
    [lRequest1 setHTTPBody:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLConnection *lConnection1=[NSURLConnection connectionWithRequest:lRequest1 delegate:self];
    [lConnection1 start];
}

-(void)searchData:(NSString *)searchText{
    //search=三星&type=0&order=0&owncount=0
    NSString *bodyString=[NSString stringWithFormat:@"search=%@&type=%i&order=%i&owncount=%i",_lSearchBar.lField.text,_paixu,_updown,_showArray.count];
    
    NSURL *lUrl=[NSURL URLWithString:[NSString stringWithFormat:@"http://%@/shop/searchgoods.php",kIP]];
    NSMutableURLRequest *lRequest1=[NSMutableURLRequest requestWithURL:lUrl];
    [lRequest1 setHTTPMethod:@"post"];
    [lRequest1 setHTTPBody:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLConnection *lConnection1=[NSURLConnection connectionWithRequest:lRequest1 delegate:self];
    [lConnection1 start];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    float offset=scrollView.contentOffset.y;
    
    if (offset>(_showArray.count*80-368)) {
        [UIView  beginAnimations:@"123" context:nil];
        scrollView.contentInset=UIEdgeInsetsMake(0, 0, 41, 0);
        [UIView commitAnimations];
        [_loadView updating];
        _loadState=3;
        [self getdata];
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    float offset=scrollView.contentOffset.y;

    if (offset>(_showArray.count*80-368)&&_loadState==1) {
        [_loadView xuanzhuan];
        _loadState=2;
    }
    if (offset>(_showArray.count*80-438)&&_loadState==0) {
        if (_loadView==nil) {
            _loadView=[[loadView alloc]init];
        }
        _loadView.frame=CGRectMake(0, _showArray.count*80, 320, 40);
        [scrollView addSubview:_loadView];
        _loadState=1;
    }
    if (offset<(_showArray.count*80-368)&&_loadState==2) {
        [_loadView xuanzhuanfanhui];
        _loadState=0;
    }
}

-(BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView{
    if (_loadState==3) {
        return NO;
    }else{
        return YES;
    }
}

-(void)updateOK{
    [UIView beginAnimations:@"123" context:nil];
    _lTabelView.contentInset=UIEdgeInsetsMake(0, 0, 0, 0);
    [UIView commitAnimations];
    _loadState=0;
    [_loadView xuanzhuanfanhui];
}

@end
