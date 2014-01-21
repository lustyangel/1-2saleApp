//
//  ViewController.m
//  GG
//
//  Created by TY on 14-1-20.
//  Copyright (c) 2014年 liumengxiang. All rights reserved.
//

#import "landViewController.h"
#import "logonViewController.h"
#import "mainViewController.h"
#import "DelayViewController.h"

#define signImage [UIImage imageNamed:@"xuanze.jpg"]
#define localUsername [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"UesrnameData"]
#define localPassword [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"PasswordData"]
#define localRemPassword [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"RemPassword"]

@interface landViewController ()

@end

@implementation landViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.nameText.layer.cornerRadius=3;
    self.cipherText.layer.cornerRadius=3;
    CALayer * passwordSaveButtonLayer = [self.passwordSaveButton layer];
    [passwordSaveButtonLayer setCornerRadius:3.0];
    [passwordSaveButtonLayer setBorderWidth:1.0];
    [passwordSaveButtonLayer setBorderColor:[[UIColor grayColor] CGColor]];
    
    CALayer * autologonButtonLayer = [self.autologonButton layer];
    [autologonButtonLayer setCornerRadius:3.0];
    [autologonButtonLayer setBorderWidth:1.0];
    [autologonButtonLayer setBorderColor:[[UIColor grayColor] CGColor]];
    
    _passwordSign=@"0";
    _autologonSign=@"0";
    _ifDragButtonSpread=NO;
    self.nameText.delegate=self;
    self.cipherText.delegate=self;
    self.cipherText.clearButtonMode=UITextFieldViewModeWhileEditing;
    self.cipherText.secureTextEntry = YES;//密码保护设置
   _uLabel=[[UILabel alloc]initWithFrame:CGRectMake(68, 78, 88, 21)];
    _uLabel.text=@"请输入帐号";
    _uLabel.textColor=[UIColor grayColor];
    [self.view addSubview:_uLabel];
    _uLabel.hidden=YES;
   _pLabel=[[UILabel alloc]initWithFrame:CGRectMake(68, 138, 88, 21)];
    _pLabel.text=@"请输入密码";
    _pLabel.textColor=[UIColor grayColor];
    [self.view addSubview:_pLabel];
    _pLabel.hidden=YES;
    
    _data=[[NSMutableData alloc]init];
    [self.dragButton setImage:[UIImage imageNamed:@"login_textfield_more@2x.png"] forState:UIControlStateNormal];
    
    //设置光标位置
    self.nameText.leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 0)];
    self.nameText.leftView.userInteractionEnabled = NO;
    self.nameText.leftViewMode = UITextFieldViewModeAlways;
    
    self.cipherText.leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 0)];
    self.cipherText.leftViewMode=UITextFieldViewModeAlways;
    self.cipherText.leftView.userInteractionEnabled=NO;
    
    //读取本地用户名，密码，保存密码标记，自动登陆标记
    _localUsernameArray=[NSArray arrayWithContentsOfFile:localUsername];
    _localPasswordArray=[NSArray arrayWithContentsOfFile:localPassword];
    _remenberPasswordArray=[NSArray arrayWithContentsOfFile:localRemPassword];
    NSArray *AutologonArray=[NSArray arrayWithContentsOfFile:AutologonSign];
    NSString *AutologonString=[AutologonArray objectAtIndex:0];
    
    //上次登陆信息根据标记来读出，并显示
    if (_localUsernameArray.count>0) {
        self.nameText.text=[_localUsernameArray objectAtIndex:_localUsernameArray.count-1];
    }
    else{
        _uLabel.hidden=NO;
    }
    NSString *lString=[_remenberPasswordArray objectAtIndex:_localUsernameArray.count-1];
    if ([lString isEqualToString:@"1"]) {
        self.cipherText.text=[_localPasswordArray objectAtIndex:_localUsernameArray.count-1];
        [self.passwordSaveButton setImage:signImage forState:UIControlStateNormal];
        _passwordSign=@"1";
    }
    else{
        _pLabel.hidden=NO;
    }
    
    if ([AutologonString isEqualToString:@"1"]) {
        [self.autologonButton setImage:signImage forState:UIControlStateNormal];
        _autologonSign=@"1";
        DelayViewController *lDelayViewController=[[DelayViewController alloc]init];
        [self presentViewController:lDelayViewController animated:YES completion:nil];
    }
    
    //添加保存最近登陆用户的TableView
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(10,108, 300, 44*_localPasswordArray.count) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.hidden=YES;
    _tableView.backgroundColor=[UIColor grayColor];
    [self.view addSubview:_tableView];
    
    //注册成功后，直接把注册用户名和密码载入登陆输入项
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(logondeAction:) name:@"logonSuccess" object:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)logondeAction:(NSNotification *)sender{
    self.nameText.text=[sender.userInfo objectForKey:@"name"];
    self.cipherText.text=[sender.userInfo objectForKey:@"password"];
    [self.passwordSaveButton setImage:nil forState:UIControlStateNormal];
    _passwordSign=@"0";
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    switch (textField.tag) {
        case 1:
            _uLabel.hidden=YES;
            break;
        case 2:
            _pLabel.hidden=YES;
            break;

        default:
            break;
    }    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    switch (textField.tag) {
        case 1:{
            NSString *lSt;
            if ([string isEqualToString:@""]) {
                lSt=[self.nameText.text substringToIndex:self.nameText.text.length-1];
            }
            else{
                lSt=[self.nameText.text stringByAppendingString:string];
            }
            if ([lSt isEqualToString:@""]) {
                _uLabel.hidden=NO;
            }
            else{
                _uLabel.hidden=YES;
            }
        }
            break;
        case 2:{
            NSString *lSt;
            if ([string isEqualToString:@""]) {
                lSt=[self.cipherText.text substringToIndex:self.cipherText.text.length-1];
            }
            else{
                lSt=[self.cipherText.text stringByAppendingString:string];
            }
            if ([lSt isEqualToString:@""]) {
                _pLabel.hidden=NO;
            }
            else{
                _pLabel.hidden=YES;
            }
        }
            break;
        default:
            break;
    }
   
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.tag==2) {
        [self landButton:nil];
    }
    return YES;
}//输入完成后按Enter键就可以自动登陆

#pragma mark - 登陆按钮
- (IBAction)landButton:(UIButton *)sender {
    if ([JPNetwork isNetworkContected] )
    {
        //网络连接正常
        NSLog(@"网络连接正常");
    }else{
        //无网络连接
        [JPNetwork networkBreak];
        NSLog(@"网络连接不正常");
        return;
    }
    if (self.nameText.text==nil||[self.nameText.text isEqualToString:@""]) {
        UIAlertView *lAlertView=[[UIAlertView alloc]initWithTitle:@"Error" message:@"The Username Can Not Be Empty" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [lAlertView show];
        return;
    }
    if (self.cipherText.text==nil||[self.cipherText.text isEqualToString:@""]) {
        UIAlertView *lAlertView=[[UIAlertView alloc]initWithTitle:@"Error" message:@"The Password Can Not Be Empty" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [lAlertView show];
        return;
    }
    
    NSString *lBodyString=[NSString stringWithFormat:@"name=%@&password=%@",self.nameText.text,self.cipherText.text];
    NSURL *lURL=[NSURL URLWithString:[NSString stringWithFormat:@"http://%@/shop/login.php",kIP]];
    NSMutableURLRequest *lURLRequest=[NSMutableURLRequest requestWithURL:lURL];
    [lURLRequest setHTTPMethod:@"post"];
    [lURLRequest setHTTPBody:[lBodyString dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLConnection *lConnection=[NSURLConnection connectionWithRequest:lURLRequest delegate:self];
    [lConnection start];
}
#pragma mark - connection Delegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [_data setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [_data appendData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSString *lA=@"{\"error\":";
    NSString *lB=@",";
    
    NSString *lString=[[NSString alloc]initWithData:_data encoding:NSUTF8StringEncoding];
    NSScanner *lScanner1=[NSScanner scannerWithString:lString];
    NSString *errorString;
    [lScanner1 scanString:lA intoString:nil];
    [lScanner1 scanUpToString:lB intoString:&errorString];
    
    
    if ([errorString isEqualToString:@"0"]) {
        //获取customerid
        NSScanner *lScanner2=[NSScanner scannerWithString:lString];
        [lScanner2 setScanLocation:32];
        int customeridValue;
        [lScanner2 scanInt:&customeridValue];
        NSLog(@"%i",customeridValue);
        [DanLi sharDanli].userID=customeridValue;
        //得到用户信息并写入本地
        NSString *userDicString1=[lString substringFromIndex:17];
        NSString *userDicString2=[userDicString1 substringToIndex:userDicString1.length-1];
        NSData *ldata=[userDicString2 dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *lDictionary=[NSJSONSerialization JSONObjectWithData:ldata options:NSJSONReadingAllowFragments error:nil];
        [DanLi sharDanli].userInfoDictionary=lDictionary;
        [lDictionary writeToFile:localUserInfoDic atomically:YES];
        
        
        //把用户名,密码和密码标记写入本地,分TableView是否装满5个和是否用户名已存在于TableView中的情况
        if (_localUsernameArray.count>4) {
            if (![_localUsernameArray containsObject:self.nameText.text]) {
                NSMutableArray *usernameArray=[NSMutableArray arrayWithArray:  _localUsernameArray];
                [usernameArray removeObjectAtIndex:0];
                [usernameArray addObject:self.nameText.text];
                [usernameArray writeToFile:localUsername atomically:YES];
                
                NSMutableArray *passwordArray=[NSMutableArray arrayWithArray:  _localPasswordArray];
                [passwordArray removeObjectAtIndex:0];
                [passwordArray addObject:self.cipherText.text];
                [passwordArray writeToFile:localPassword atomically:YES];
                
                NSMutableArray *sign=[[NSMutableArray alloc]initWithArray:_remenberPasswordArray];
                [sign removeObjectAtIndex:0];
                [sign addObject:_passwordSign];
                [sign writeToFile:localRemPassword atomically:YES];
            }
            else{
                NSMutableArray *usernameArray=[NSMutableArray arrayWithArray:  _localUsernameArray];
                NSInteger X=[usernameArray indexOfObject:self.nameText.text];
                [usernameArray removeObjectAtIndex:X];
                [usernameArray addObject:self.nameText.text];
                [usernameArray writeToFile:localUsername atomically:YES];
                
                NSMutableArray *passwordArray=[NSMutableArray arrayWithArray:  _localPasswordArray];
                [passwordArray removeObjectAtIndex:X];
                [passwordArray addObject:self.cipherText.text];
                [passwordArray writeToFile:localPassword atomically:YES];
                
                NSMutableArray *sign=[[NSMutableArray alloc]initWithArray:_remenberPasswordArray];
                [sign removeObjectAtIndex:X];
                [sign addObject:_passwordSign];
                [sign writeToFile:localRemPassword atomically:YES];
            }
        }
        else{
            if (![_localUsernameArray containsObject:self.nameText.text]) {
                NSMutableArray *usernameArray=[NSMutableArray arrayWithArray:  _localUsernameArray];
                [usernameArray addObject:self.nameText.text];
                [usernameArray writeToFile:localUsername atomically:YES];
                
                NSMutableArray *passwordArray=[NSMutableArray arrayWithArray:  _localPasswordArray];
                [passwordArray addObject:self.cipherText.text];
                [passwordArray writeToFile:localPassword atomically:YES];
                
                NSMutableArray *sign=[NSMutableArray arrayWithArray:_remenberPasswordArray];
                [sign addObject:_passwordSign];
                [sign writeToFile:localRemPassword atomically:YES];
            }
            else{
                NSMutableArray *usernameArray=[NSMutableArray arrayWithArray:  _localUsernameArray];
                NSInteger X=[usernameArray indexOfObject:self.nameText.text];
                [usernameArray removeObjectAtIndex:X];
                [usernameArray addObject:self.nameText.text];
                [usernameArray writeToFile:localUsername atomically:YES];
                
                NSMutableArray *passwordArray=[NSMutableArray arrayWithArray:  _localPasswordArray];
                [passwordArray removeObjectAtIndex:X];
                [passwordArray addObject:self.cipherText.text];
                [passwordArray writeToFile:localPassword atomically:YES];
                
                NSMutableArray *sign=[[NSMutableArray alloc]initWithArray:_remenberPasswordArray];
                [sign removeObjectAtIndex:X];
                [sign addObject:_passwordSign];
                [sign writeToFile:localRemPassword atomically:YES];
            }
        }
        _localUsernameArray=[NSArray arrayWithContentsOfFile:localUsername];
        [_tableView reloadData];
        _localPasswordArray=[NSArray arrayWithContentsOfFile:localPassword];
        _remenberPasswordArray=[NSArray arrayWithContentsOfFile:localRemPassword];
        NSArray *lArray=[NSArray arrayWithObject:_autologonSign];
        [lArray writeToFile:AutologonSign atomically:YES];
        mainViewController *lmainViewController=[[mainViewController alloc]init];
        [self presentViewController:lmainViewController animated:YES completion:nil];
    }
    else{
        UIAlertView *lAlertView=[[UIAlertView alloc]initWithTitle:@"error" message:@"Your Land Is Fail,Please Cheack Your Username and Your Password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [lAlertView show];
    }
}
- (IBAction)logonButton:(UIButton *)sender {
    logonViewController *llogonViewController=[[logonViewController alloc]init];
    [self presentViewController:llogonViewController animated:YES completion:nil];
}

- (IBAction)dragButton:(UIButton *)sender {
    if (!_tableView.hidden) {
        _tableView.hidden=YES;
        [self.dragButton setImage:[UIImage imageNamed:@"login_textfield_more@2x.png"] forState:UIControlStateNormal];
    }
    else{
        _tableView.hidden=NO;
        [self.dragButton setImage:[UIImage imageNamed:@"login_textfield_more_flip@2x.png"] forState:UIControlStateNormal];
    }
}

- (IBAction)cipherSaveButton:(UIButton *)sender {
    if (!_passwordSign.intValue) {
        [sender setImage:signImage forState:UIControlStateNormal];
        _passwordSign=@"1";
    }else{
        [sender setImage:nil forState:UIControlStateNormal];
        _passwordSign=@"0";
        [self.autologonButton setImage:nil forState:UIControlStateNormal];
        _autologonSign=@"0";
    }
}

- (IBAction)autologonButton:(UIButton *)sender {
    if (!_autologonSign.intValue) {
        [self.passwordSaveButton setImage:signImage forState:UIControlStateNormal];
        _passwordSign=@"1";
        [sender setImage:signImage forState:UIControlStateNormal];
        _autologonSign=@"1";
    }
    else{
        [sender setImage:nil forState:UIControlStateNormal];
        _autologonSign=@"0";
    }
}

- (IBAction)backButton:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - tableView的delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%i", _localUsernameArray.count);
    return _localUsernameArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *lCellID=@"CellID";
    UITableViewCell *lCell=[tableView dequeueReusableCellWithIdentifier:lCellID];
    if (lCell==nil) {
        lCell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:lCellID];
    }
    NSInteger row=[indexPath row];
    lCell.textLabel.text=[_localUsernameArray objectAtIndex:_localUsernameArray.count-row-1];
    return lCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _tableView.hidden=YES;
    NSInteger row=[indexPath row];
    
    //反向取出用户信息
    self.nameText.text=[_localUsernameArray objectAtIndex:_localUsernameArray.count-row-1];
    NSString *lString=[_remenberPasswordArray objectAtIndex:_remenberPasswordArray.count-row-1];
    
    if (lString.intValue) {
      
        self.cipherText.text=[_localPasswordArray objectAtIndex:_localUsernameArray.count-row-1];
        [self.passwordSaveButton setImage:signImage forState:UIControlStateNormal];
        _passwordSign=@"1";
          _pLabel.hidden=YES;
    }
    else{
        
        self.cipherText.text=@"";
        [self.passwordSaveButton setImage:nil forState:UIControlStateNormal];
        _passwordSign=@"0";
        _pLabel.hidden=NO;
        
    }
    UIImage *lImage=[UIImage imageNamed:@"login_textfield_more@2x.png"];
    [self.dragButton setImage:lImage forState:UIControlStateNormal];
    _ifDragButtonSpread=NO;
    
}

- (IBAction)exit:(UITextField *)sender {
}
@end
