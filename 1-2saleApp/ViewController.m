//
//  ViewController.m
//  Go Shopping
//
//  Created by TY on 13-11-6.
//  Copyright (c) 2013年 liumengxiang. All rights reserved.
//

#import "ViewController.h"
#import "logonViewController.h"
#import "InfoViewController.h"
#define localUsername [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"UesrnameData"]
#define localPassword [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"PasswordData"]
#define localRemPassword [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"RemPassword"]
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"用户登陆注册界面";
    _passwordSign=@"0";
    _ifDragButtonSpread=NO;
    _data=[[NSMutableData alloc]init];
    
     _localUsernameArray=[NSArray arrayWithContentsOfFile:localUsername];
    _localPasswordArray=[NSArray arrayWithContentsOfFile:localPassword];
    _remenberPasswordArray=[NSArray arrayWithContentsOfFile:localRemPassword];
    NSLog(@"%@ %@",_remenberPasswordArray,_localPasswordArray);
    [self.dragButton setImage:[UIImage imageNamed:@"login_textfield_more@2x.png"] forState:UIControlStateNormal];
    
    //设置光标位置
    self.nameText.leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 0)];
   self.nameText.leftView.userInteractionEnabled = NO;
     self.nameText.leftViewMode = UITextFieldViewModeAlways;
    
    self.cipherText.leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 0)];
    self.cipherText.leftViewMode=UITextFieldViewModeAlways;
    self.cipherText.leftView.userInteractionEnabled=NO;
    
    self.nameText.text=[_localUsernameArray objectAtIndex:_localUsernameArray.count-1];
    NSString *lString=[_remenberPasswordArray objectAtIndex:_localUsernameArray.count-1];
     UIImage *lImage=[UIImage imageNamed:@"check@2x.png"];
    if ([lString isEqualToString:@"1"]) {
        self.cipherText.text=[_localPasswordArray objectAtIndex:_localUsernameArray.count-1];
        [self.passwordSaveButton setImage:lImage forState:UIControlStateNormal];
        _passwordSign=@"1";
    }
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(74,225, 235, 220) style:UITableViewStylePlain];
   _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.hidden=YES;
    
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)cleanUsername{
    self.nameText.text=@"";
}
-(void)cleanCipher{
    self.cipherText.text=@"";
}

- (IBAction)cipherSaveButton:(UIButton *)sender {
    UIImage *lImage=[UIImage imageNamed:@"check@2x.png"];
    if (!_passwordSign.intValue) {
        [sender setImage:lImage forState:UIControlStateNormal];
        _passwordSign=@"1";
    }else{
        [sender setImage:nil forState:UIControlStateNormal];
        _passwordSign=@"0";
    }

}

- (IBAction)autologonButton:(UIButton *)sender {
    
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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
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
    self.nameText.text=[_localUsernameArray objectAtIndex:_localUsernameArray.count-row-1];
    NSString *lString=[_remenberPasswordArray objectAtIndex:_remenberPasswordArray.count-row-1];
     UIImage *lImage=[UIImage imageNamed:@"check@2x.png"];
    NSLog(@"%i",lString.intValue);
    if (lString.intValue) {
        self.cipherText.text=[_localPasswordArray objectAtIndex:_localUsernameArray.count-row-1];
        [self.passwordSaveButton setImage:lImage forState:UIControlStateNormal];
        _passwordSign=@"1";
    }
    else{
        self.cipherText.text=@"";
        [self.passwordSaveButton setImage:nil forState:UIControlStateNormal];
        _passwordSign=@"0";

    }
}
- (IBAction)landButton:(UIButton *)sender {
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
    NSURL *lURL=[NSURL URLWithString:@"http://192.168.1.136/shop/login.php"];
    NSMutableURLRequest *lURLRequest=[NSMutableURLRequest requestWithURL:lURL];
    [lURLRequest setHTTPMethod:@"post"];
    [lURLRequest setHTTPBody:[lBodyString dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLConnection *lConnection=[NSURLConnection connectionWithRequest:lURLRequest delegate:self];
    [lConnection start];
    
}
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
//        NSLog(@"%i",customeridValue);
        
        
        //把用户名密码和密码标记写入本地
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
       
       InfoViewController *lFist=[[InfoViewController alloc]init];
        [self.navigationController pushViewController:lFist animated:YES];
    }
    else{
        UIAlertView *lAlertView=[[UIAlertView alloc]initWithTitle:@"error" message:@"Your Land Is Fail,Please Cheack Your Username and Your Password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [lAlertView show];
    }
    
}
- (IBAction)logonButton:(UIButton *)sender {
    NSLog(@"111");
    logonViewController *llogonViewController=[[logonViewController alloc]init];
    [self.navigationController pushViewController:llogonViewController animated:YES];
}
- (IBAction)textExit:(UITextField *)sender {
}
@end
