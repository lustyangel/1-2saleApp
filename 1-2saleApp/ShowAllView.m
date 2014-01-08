//
//  ShowAllView.m
//  1-2saleApp
//
//  Created by TY on 14-1-7.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import "ShowAllView.h"

@implementation ShowAllView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor=[UIColor whiteColor];
        
        _lData=[[NSMutableData alloc]init];
        _showArray=[[NSMutableArray alloc]init];
        _updown=0;
        _paixu=0;
        _loadState=0;
        _searchState=NO;
        
        _lSearchButton=[[UIButton alloc]initWithFrame:CGRectMake(270, 5, 36, 30)];
        [_lSearchButton setImage:[UIImage imageNamed:@"searchButton1.png"] forState:UIControlStateNormal];
        _lSearchButton.backgroundColor=[UIColor colorWithRed:1 green:66/255 blue:66/255 alpha:1];
        [_lSearchButton addTarget:self action:@selector(searchClickUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [_lSearchButton addTarget:self action:@selector(searchClickDown:) forControlEvents:UIControlEventTouchDown];
        [_lSearchButton addTarget:self action:@selector(searchCancelClick:) forControlEvents:UIControlEventTouchCancel];
        [_lSearchButton addTarget:self action:@selector(searchCancelClick:) forControlEvents:UIControlEventTouchUpOutside];
        [self addSubview:_lSearchButton];
        
        
        _lSearchBar=[[LLSearchBar alloc]initWithFrame:CGRectMake(10, 5, 250, 30)];
        _lSearchBar.LLDelegate=self;
        _lSearchBar.lField.text=@"";
        [self addSubview:_lSearchBar];
        
        _lDeleteButton=[[UIButton alloc]initWithFrame:CGRectMake(225, 8, 15, 15)];
        _lDeleteButton.tag=101;
        _lDeleteButton.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"delete.png"]];
        _lDeleteButton.hidden=YES;
        [_lDeleteButton addTarget:self action:@selector(DeleteClickUpInside:) forControlEvents:UIControlEventTouchUpInside];
        //    [_lDeleteButton addTarget:self action:@selector(DeleteClickDown:) forControlEvents:UIControlEventTouchDown];
        //    [_lDeleteButton addTarget:self action:@selector(DeleteCancelClick:) forControlEvents:UIControlEventTouchCancel];
        //    [_lDeleteButton addTarget:self action:@selector(DeleteCancelClick:) forControlEvents:UIControlEventTouchUpOutside];
        [_lSearchBar addSubview:_lDeleteButton];
        
        
        LLSelectButton *lSelectButton=[[LLSelectButton alloc]initWithFrame:CGRectMake(0, 41, 320, 25)];
        lSelectButton.LLDelegate=self;
        [self addSubview:lSelectButton];
        
        _lTabelView=[[UITableView alloc]initWithFrame:CGRectMake(0, 66, 320, 438) style:UITableViewStylePlain];
        _lTabelView.delegate=self;
        _lTabelView.dataSource=self;
//        _lTabelView.bounces=NO
        [self addSubview:_lTabelView];
        
        [self getdata];
    }
    return self;
}


#pragma mark - 搜索键click

-(void)searchClickDown:(UIButton *)sender{
    sender.backgroundColor=[UIColor colorWithRed:0.8 green:66/255 blue:66/255 alpha:1];
}
-(void)searchCancelClick:(UIButton *)sender{
    sender.backgroundColor=[UIColor colorWithRed:1 green:66/255 blue:66/255 alpha:1];
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



//-(void)DeleteClickDown:(UIButton *)sender{
//    [sender setTitle:@"Hot" forState:UIControlStateHighlighted];
//    sender.backgroundColor=[UIColor colorWithRed:0.8 green:66/255 blue:66/255 alpha:1];
//}
#pragma mark - 搜索栏删除button

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


#pragma mark - 搜索栏 textfied

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

#pragma mark - 网络连接

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
    _requesting=NO;
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
            return;
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
            [self addSubview:lLabel];
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
            [self addSubview:_backButton];
        }
        _backButton.hidden=NO;
    }
    
    if (count==0) {
        if (_sorryImage==nil) {
            _sorryImage=[[UIImageView alloc]initWithFrame:CGRectMake(80, 160, 160, 219)];
            _sorryImage.image=[UIImage imageNamed:@"sorry.png"];
            [self addSubview:_sorryImage];
            
            
        }
        
        _sorryImage.hidden=NO;
        _lTabelView.hidden=YES;
        return;
    }
    
    
    [_showArray setArray:[lDic1 objectForKey:@"infos"]];
    [_lTabelView reloadData];
}

#pragma mark - 返回所有商品按钮

-(void)backAllProduct:(UIButton *)sender{
    [_showArray removeAllObjects];
    [self getdata];
    sender.hidden=YES;
    _searchState=NO;
    _lSearchBar.lField.text=@"";
}

#pragma mark - tabelview 显示

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
    lCell.lImageView.image=[self judgeLocationImage:[lDic objectForKey:@"headerimage"]];
    return lCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 判断本地是否有图片

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

#pragma mark - 从网络获取图片

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

#pragma mark - 排序方式

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

#pragma mark - 建立网络连接

-(void)getdata{
    if (_requesting) {
        return;
    }
    NSString *bodyString=[NSString stringWithFormat:@"type=%i&order=%i&owncount=%i",_paixu,_updown,_showArray.count];
    
    NSURL *lUrl=[NSURL URLWithString:[NSString stringWithFormat:@"http://%@/shop/getgoods.php",kIP]];
    //    NSURL *lUrl=[NSURL URLWithString:@"http://192.168.1.125/shop/getgoods.php"];
    NSMutableURLRequest *lRequest1=[NSMutableURLRequest requestWithURL:lUrl];
    [lRequest1 setTimeoutInterval:5];
    [lRequest1 setHTTPMethod:@"post"];
    [lRequest1 setHTTPBody:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLConnection *lConnection1=[NSURLConnection connectionWithRequest:lRequest1 delegate:self];
    _requesting=YES;
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

#pragma mark - 上拉加载功能

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

//-(BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView{
//    if (_loadState==3) {
//        return NO;
//    }else{
//        return YES;
//    }
//}

-(void)updateOK{
    [UIView beginAnimations:@"123" context:nil];
    _lTabelView.contentInset=UIEdgeInsetsMake(0, 0, 0, 0);
    [UIView commitAnimations];
    _loadState=0;
    [_loadView xuanzhuanfanhui];
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
