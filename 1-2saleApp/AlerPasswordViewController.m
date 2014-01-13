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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
            return;
       }
    }
    if (textField.tag==3&self.oldPassword.text.length>0) {
        NSArray *lArray=[NSArray arrayWithContentsOfFile:localPassword];
        NSString *lString=[lArray objectAtIndex:lArray.count-1];
        if (![self.oldPassword.text isEqualToString:lString]) {
            UIAlertView *lAlertView=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Wrong Password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [lAlertView show];
        }
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
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
            if ([msgString isEqualToString:@"0"]&&self.npassword.text!=nil) {
                UIAlertView *lAlertView=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Invalid password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [lAlertView show];
                self.npassword.text=@"";
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
                self.npassword.text=nil;
                self.affirmText.text=nil;
                self.oldPassword.text=nil;
            }
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
    if (self.npassword==nil) {
        UIAlertView *lAlertView=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Password can not be nil" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [lAlertView show];
        return;
    }
    if (self.affirmText==nil) {
        UIAlertView *lAlertView=[[UIAlertView alloc]initWithTitle:@"Error" message:@"AffirmPassword can not be nil" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [lAlertView show];
        return;
    }
    if (self.oldPassword==nil) {
        UIAlertView *lAlertView=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Old password can not be nil" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [lAlertView show];
        return;
    }
    NSLog(@"%@",[DanLi sharDanli].userInfoDictionary);
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
