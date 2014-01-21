//
//  AlerPasswordViewController.m
//  1-2saleApp
//
//  Created by TY on 14-1-10.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import "AlerPasswordViewController.h"

@interface AlerPasswordViewController ()

@end

@implementation AlerPasswordViewController

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
    // Do any additional setup after loading the view from its nib.
    _data=[[NSMutableData alloc]init];
    self.npassword.delegate=self;
    self.oldPassword.delegate=self;
    self.affirmText.delegate=self;
    self.npassword.secureTextEntry=YES;
    self.oldPassword.secureTextEntry=YES;
    self.affirmText.secureTextEntry=YES;
    self.npasswordCheck.hidden=YES;
    self.oldPasswordCheck.hidden=YES;
    self.affirmPasswordCheck.hidden=YES;
    self.npassword.clearButtonMode=UITextFieldViewModeWhileEditing;
    self.affirmText.clearButtonMode=UITextFieldViewModeWhileEditing;
    self.oldPassword.clearButtonMode=UITextFieldViewModeWhileEditing;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    switch (textField.tag) {
        case 1:
            self.npasswordCheck.hidden=YES;
            break;
        case 2:
            self.affirmPasswordCheck.hidden=YES;
            break;
        case 3:
            self.oldPasswordCheck.hidden=YES;
            break;
        default:
            break;
    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag==1&self.npassword.text.length>0) {
        _x=1;
        NSString *lS1=[NSString stringWithFormat:@"http://%@/shop/checkpassword.php?password=",kIP];
        NSString *lS2=[lS1 stringByAppendingString:self.npassword.text];
        NSURL *lURL=[NSURL URLWithString:lS2];
        NSMutableURLRequest *lURLRequest=[NSMutableURLRequest requestWithURL:lURL];
        [lURLRequest setHTTPMethod:@"get"];
        NSURLConnection *lConnection=[NSURLConnection connectionWithRequest:lURLRequest delegate:self];
        [lConnection start];
    }
    if (textField.tag==2&self.affirmText.text.length>0) {
        if (![self.npassword.text isEqualToString:self.affirmText.text]) {
            UIAlertView *lAlertView=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Password is not the same" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [lAlertView show];
            self.affirmText.text=@"";
            self.npassword.text=@"";
            self.affirmPasswordCheck.hidden=YES;
            self.npasswordCheck.hidden=YES;
            return;
       }
    }
    if (textField.tag==3&self.oldPassword.text.length>0) {
        NSArray *lArray=[NSArray arrayWithContentsOfFile:localPassword];
        NSString *lString=[lArray objectAtIndex:lArray.count-1];
        if (![self.oldPassword.text isEqualToString:lString]) {
            UIAlertView *lAlertView=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Wrong Password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [lAlertView show];
            self.oldPassword.text=@"";
            self.oldPasswordCheck.hidden=YES;
        }
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return YES;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.tag==1) {
        _x=3;
        NSString *lS1=[NSString stringWithFormat:@"http://%@/shop/checkpassword.php?password=",kIP];
        NSString *lS2=[lS1 stringByAppendingString:self.npassword.text];
        NSString *lS3;
        if ([string isEqualToString:@""]) {
            lS3=[lS2 substringToIndex:lS2.length-1];
        }
        else{
            lS3=[lS2 stringByAppendingString:string];
        }
        NSURL *lURL=[NSURL URLWithString:lS3];
        NSMutableURLRequest *lURLRequest=[NSMutableURLRequest requestWithURL:lURL];
        [lURLRequest setHTTPMethod:@"get"];
        NSURLConnection *lConnection=[NSURLConnection connectionWithRequest:lURLRequest delegate:self];
        [lConnection start];
    }
    if (textField.tag==2) {
        NSString *lADD;
        if ([string isEqualToString:@""]) {
            lADD=[self.affirmText.text substringToIndex:self.affirmText.text.length-1];
        }
        else{
            lADD=[self.affirmText.text stringByAppendingString:string];
        }
        if ([self.npassword.text isEqualToString:lADD]) {
            self.affirmText.hidden=NO;
            [self.affirmPasswordCheck setImage:[UIImage imageNamed:@"right.png"]];
        }
        else{
            self.affirmPasswordCheck.hidden=NO;
            [self.affirmPasswordCheck setImage:[UIImage imageNamed:@"wrong.png"]];
        }
        if ([lADD isEqualToString:@""]) {
            self.affirmPasswordCheck.hidden=YES;
        }
    }
    if (textField.tag==3) {
        NSArray *lArray=[NSArray arrayWithContentsOfFile:localPassword];
        NSString *lString=[lArray objectAtIndex:lArray.count-1];
        NSString *lADD;
        if ([string isEqualToString:@""]) {
            lADD=[self.oldPassword.text substringToIndex:self.oldPassword.text.length-1];
        }
        else{
            lADD=[self.oldPassword.text stringByAppendingString:string];
        }
        if ([lString isEqualToString:lADD]) {
            self.oldPasswordCheck.hidden=NO;
            [self.oldPasswordCheck setImage:[UIImage imageNamed:@"right.png"]];
        }
        else{
            self.oldPasswordCheck.hidden=NO;
            [self.oldPasswordCheck setImage:[UIImage imageNamed:@"wrong.png"]];
        }
        if ([lADD isEqualToString:@""]) {
            self.oldPasswordCheck.hidden=YES;
        }
    }
   return YES;
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
    NSString *lC=@"{\"error\":0,\"msg\":";
    NSString *lD=@"}";
    NSString *lString=[[NSString alloc]initWithData:_data encoding:NSUTF8StringEncoding];
    NSScanner *lScanner1=[NSScanner scannerWithString:lString];
    NSString *errorString;
    NSString *msgString;
    [lScanner1 scanString:lA intoString:nil];
    [lScanner1 scanUpToString:lB intoString:&errorString];
    NSScanner *lScanner2=[NSScanner scannerWithString:lString];
    [lScanner2 scanString:lC intoString:nil];
    [lScanner2 scanUpToString:lD intoString:&msgString];
    NSLog(@"%@",lString);
    switch (_x) {
        case 1:
        {
            if (![msgString isEqualToString:@"1"]&&![self.npassword.text isEqualToString:@""]) {
                UIAlertView *lAlertView=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Invalid password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [lAlertView show];
                self.npassword.text=@"";
                self.npasswordCheck.hidden=YES;
            }
        }
            break;
        case 2:
        {
            if (![errorString isEqualToString:@"0"]) {
                UIAlertView *lAlertView=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Your change is not successful" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [lAlertView show];
            }
            else{
                UIAlertView *lAlertView=[[UIAlertView alloc]initWithTitle:nil message:@"Your change is successful" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [lAlertView show];
               
               NSMutableArray *lArray=[NSArray arrayWithContentsOfFile:localPassword];
                [lArray removeLastObject];
                [lArray addObject:self.npassword.text];
                [lArray writeToFile:localPassword atomically:YES];
                self.npassword.text=@"";
                self.affirmText.text=@"";
                self.oldPassword.text=@"";
                self.npasswordCheck.hidden=YES;
                self.affirmPasswordCheck.hidden=YES;
                self.oldPasswordCheck.hidden=YES;
            }//修改成功后，把本地密码文件也修正
        }
            break;
            case 3:
        if (![msgString isEqualToString:@"1"]&&![self.npassword.text isEqualToString:@""]) {
            self.npasswordCheck.image=[UIImage imageNamed:@"wrong.png"];
            self.npasswordCheck.hidden=NO;
        }
            if ([msgString isEqualToString:@"1"]) {
                self.npasswordCheck.image=[UIImage imageNamed:@"right.png"];
                self.npasswordCheck.hidden=NO;
            }
            if ([self.npassword.text isEqualToString:@""]) {
                self.npasswordCheck.hidden=YES;
            }
            break;
        default:
            break;
    }
}

- (IBAction)backButton:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)confirmAler:(UIButton *)sender {
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
    if (self.npassword.text==nil&&[self.npassword.text isEqualToString:@""]) {
        UIAlertView *lAlertView=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Password can not be nil" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [lAlertView show];
        return;
    }
    if (self.affirmText.text==nil&&[self.affirmText.text isEqualToString:@""]) {
        UIAlertView *lAlertView=[[UIAlertView alloc]initWithTitle:@"Error" message:@"AffirmPassword can not be nil" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [lAlertView show];
        return;
    }
    if (self.oldPassword.text==nil&&[self.oldPassword.text isEqualToString:@""]) {
        UIAlertView *lAlertView=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Old password can not be nil" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [lAlertView show];
        return;
    }

    _x=2;
    NSString *lBodyString=[NSString stringWithFormat:@"name=%@&newpassword=%@&oldpassword=%@",[[DanLi sharDanli].userInfoDictionary objectForKey:@"name"],self.npassword.text,self.oldPassword.text];
    NSURL *lURL=[NSURL URLWithString:[NSString stringWithFormat:@"http://%@/shop/changepassword.php",kIP]];
    NSMutableURLRequest *lURLRequest=[NSMutableURLRequest requestWithURL:lURL];
    [lURLRequest setHTTPMethod:@"post"];
    [lURLRequest setHTTPBody:[lBodyString dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLConnection *lConnection=[NSURLConnection connectionWithRequest:lURLRequest delegate:self];
    [lConnection start];
}
- (IBAction)toMain:(UIButton *)sender {
    mainViewController *lmainViewController=[[mainViewController alloc]init];
    [self presentViewController:lmainViewController animated:YES completion:nil];
}

- (IBAction)exit:(UITextField *)sender {
}
@end
