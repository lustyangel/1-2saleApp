//
//  logonViewController.m
//  Go Shopping
//
//  Created by TY on 13-11-7.
//  Copyright (c) 2013年 liumengxiang. All rights reserved.
//

#import "logonViewController.h"
@interface logonViewController ()

@end

@implementation logonViewController

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
    self.nameText.delegate=self;
    self.cipherText.delegate=self;
    self.emailText.delegate=self;
    self.affimCipherText.delegate=self;
    self.telephoneText.delegate=self;
    self.cipherText.secureTextEntry = YES;
    self.affimCipherText.secureTextEntry=YES;
    self.usernameCheak.hidden=YES;
    self.passwordCheak.hidden=YES;
    self.affimPasswordCheak.hidden=YES;
    self.emailCheak.hidden=YES;
    self.telephoneCheak.hidden=YES;
//     self.nameText.autocorrectionType = UITextAutocorrectionTypeNo;
    _x=-1;
   }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag==0) {
        _x=0;
        NSString *lS1=[NSString stringWithFormat:@"http://%@/shop/checkname.php?name=",kIP];
        NSString *lS2=[lS1 stringByAppendingString:self.nameText.text];
        NSURL *lURL=[NSURL URLWithString:lS2];
        NSMutableURLRequest *lURLRequest=[NSMutableURLRequest requestWithURL:lURL];
        [lURLRequest setHTTPMethod:@"get"];
       NSURLConnection *lConnection=[NSURLConnection connectionWithRequest:lURLRequest delegate:self];
        [lConnection start];
    }
    if (textField.tag==1) {
         _x=1;
        NSString *lS1=[NSString stringWithFormat:@"http://%@/shop/checkpassword.php?password=",kIP];
        NSString *lS2=[lS1 stringByAppendingString:self.cipherText.text];
        NSURL *lURL=[NSURL URLWithString:lS2];
        NSMutableURLRequest *lURLRequest=[NSMutableURLRequest requestWithURL:lURL];
        [lURLRequest setHTTPMethod:@"get"];
        NSURLConnection *lConnection=[NSURLConnection connectionWithRequest:lURLRequest delegate:self];
        [lConnection start];
    }
    if (textField.tag==2) {
         _x=2;
        NSString *lS1=[NSString stringWithFormat:@"http://%@/shop/checkemail.php?email=",kIP];
        NSString *lS2=[lS1 stringByAppendingString:self.emailText.text];
        NSURL *lURL=[NSURL URLWithString:lS2];
        NSMutableURLRequest *lURLRequest=[NSMutableURLRequest requestWithURL:lURL];
        [lURLRequest setHTTPMethod:@"get"];
        NSURLConnection *lConnection=[NSURLConnection connectionWithRequest:lURLRequest delegate:self];
        [lConnection start];
    }
    if (textField.tag==3) {
        _x=3;
        NSString *lS1=[NSString stringWithFormat:@"http://%@/shop/checktelephone.php?telephone=",kIP];
        NSString *lS2=[lS1 stringByAppendingString:self.telephoneText.text];
        NSURL *lURL=[NSURL URLWithString:lS2];
        NSMutableURLRequest *lURLRequest=[NSMutableURLRequest requestWithURL:lURL];
        [lURLRequest setHTTPMethod:@"get"];
        NSURLConnection *lConnection=[NSURLConnection connectionWithRequest:lURLRequest delegate:self];
        [lConnection start];
    }
    if (textField.tag==4) {
        if (![self.cipherText.text isEqualToString:self.affimCipherText.text]) {
            UIAlertView *lAlertView=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Password is not the same" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [lAlertView show];
            self.cipherText.text=@"";
            self.affimCipherText.text=@"";
            return;
        }
    }
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
      if (textField.tag==0) {
        _x=5;
        NSString *lS1=[NSString stringWithFormat:@"http://%@/shop/checkname.php?name=",kIP];
        NSString *lS2=[lS1 stringByAppendingString:self.nameText.text];
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
    if (textField.tag==1) {
        _x=6;
        NSString *lS1=[NSString stringWithFormat:@"http://%@/shop/checkpassword.php?password=",kIP];
        NSString *lS2=[lS1 stringByAppendingString:self.cipherText.text];
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
        _x=7;
        NSString *lS1=[NSString stringWithFormat:@"http://%@/shop/checkemail.php?email=",kIP];
        NSString *lS2=[lS1 stringByAppendingString:self.emailText.text];
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
    if (textField.tag==3) {
        _x=8;
        NSString *lS1=[NSString stringWithFormat:@"http://%@/shop/checktelephone.php?telephone=",kIP];
        NSString *lS2=[lS1 stringByAppendingString:self.telephoneText.text];
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
    if (textField.tag==4) {
        NSString *lADD;
        if ([string isEqualToString:@""]) {
            lADD=[self.affimCipherText.text substringToIndex:self.affimCipherText.text.length-1];
        }
        else{
        lADD=[self.affimCipherText.text stringByAppendingString:string];
        }
        if ([self.cipherText.text isEqualToString:lADD]) {
            self.affimPasswordCheak.hidden=NO;
            [self.affimPasswordCheak setImage:[UIImage imageNamed:@"right.png"]];
        }
        else{
            self.affimPasswordCheak.hidden=NO;
            [self.affimPasswordCheak setImage:[UIImage imageNamed:@"wrong.png"]];
        }
       if ([lADD isEqualToString:@""]) {
            self.affimPasswordCheak.hidden=YES;
        }
    }
    return YES;
}
- (IBAction)commitButton:(UIButton *)sender {
    if (self.nameText.text==nil||[self.nameText.text isEqualToString:@""]) {
        UIAlertView *lAlertView=[[UIAlertView alloc]initWithTitle:@"Error" message:@"The Name Can Not Be Empty" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [lAlertView show];
        return;
    }
    if (self.cipherText.text==nil||[self.cipherText.text isEqualToString:@""]) {
        UIAlertView *lAlertView=[[UIAlertView alloc]initWithTitle:@"Error" message:@"The Password Can Not Be Empty" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [lAlertView show];
        return;
    }
    if (self.affimCipherText.text==nil||[self.affimCipherText.text isEqualToString:@""]) {
        UIAlertView *lAlertView=[[UIAlertView alloc]initWithTitle:@"Error" message:@"The affimPassword Can Not Be Empty" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [lAlertView show];
        return;
    }
    if (self.emailText.text==nil||[self.emailText.text isEqualToString:@""]) {
        UIAlertView *lAlertView=[[UIAlertView alloc]initWithTitle:@"Error" message:@"The email Can Not Be Empty" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [lAlertView show];
        return;
    }
    if (self.telephoneText.text==nil||[self.telephoneText.text isEqualToString:@""]) {
        UIAlertView *lAlertView=[[UIAlertView alloc]initWithTitle:@"Error" message:@"The telephone Can Not Be Empty" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [lAlertView show];
        return;
    }
    _x=4;
    NSString *lBodyString=[NSString stringWithFormat:@"name=%@&password=%@&email=%@&telephone=%@",self.nameText.text,self.cipherText.text,self.emailText.text,self.telephoneText.text];
    NSURL *lURL=[NSURL URLWithString:[NSString stringWithFormat:@"http://%@/shop/register.php",kIP]];
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
    
//    NSLog(@"%@",lString);
//    NSLog(@"%@ %@",errorString,msgString);
    
    switch (_x) {
        case 0:
            NSLog(@"%@",self.nameText.text);
            if (![msgString isEqualToString:@"1"]&&self.nameText.text!=nil&&![self.nameText.text isEqualToString:@""]) {
                UIAlertView *lAlertView=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Invalid userName" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [lAlertView show];
                self.nameText.text=@"";
                self.usernameCheak.hidden=YES;
            }
            break;
        case 1:
            if (![msgString isEqualToString:@"1"]&&self.cipherText.text!=nil&&![self.cipherText.text isEqualToString:@""]) {
                UIAlertView *lAlertView=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Invalid password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [lAlertView show];
                self.cipherText.text=@"";
                self.passwordCheak.hidden=YES;
            }
            break;
        case 2:
            if (![msgString isEqualToString:@"1"]&&self.emailText.text!=nil&&![self.emailText.text isEqualToString:@""]) {
                UIAlertView *lAlertView=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Invalid email" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [lAlertView show];
                self.emailText.text=@"";
                self.emailCheak.hidden=YES;
            }
            break;
        case 3:
            if (![msgString isEqualToString:@"1"]&&self.telephoneText.text!=nil&&![self.telephoneText.text isEqualToString:@""]) {
                UIAlertView *lAlertView=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Invalid telephonenumber" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [lAlertView show];
                self.telephoneText.text=@"";
                self.telephoneCheak.hidden=YES;
            }
            break;
        case 4:
            if ([errorString isEqualToString:@"0"]) {
                UIAlertView *lAlertView=[[UIAlertView alloc]initWithTitle:nil message:@"Registration Successful" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                lAlertView.delegate=self;
                [lAlertView show];
                self.nameText.text=@"";
                self.cipherText.text=@"";
                self.affimCipherText.text=@"";
                self.emailText.text=@"";
                self.telephoneText.text=@"";
                self.usernameCheak.hidden=YES;
                self.passwordCheak.hidden=YES;
                self.emailCheak.hidden=YES;
                self.telephoneCheak.hidden=YES;
            }
            else{
                UIAlertView *lAlertView=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Wrong Information，Your Signup Failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [lAlertView show];
                self.nameText.text=@"";
                self.cipherText.text=@"";
                self.affimCipherText.text=@"";
                self.emailText.text=@"";
                self.telephoneText.text=@"";
                self.usernameCheak.hidden=YES;
                self.passwordCheak.hidden=YES;
                self.emailCheak.hidden=YES;
                self.telephoneCheak.hidden=YES;
            }
            break;
        case 5:
            if (![msgString isEqualToString:@"1"]&&![self.nameText.text isEqualToString:@""]) {
                self.usernameCheak.image=[UIImage imageNamed:@"wrong.png"];
                self.usernameCheak.hidden=NO;
            }
            if ([msgString isEqualToString:@"1"]) {
                 self.usernameCheak.image=[UIImage imageNamed:@"right.png"];
                 self.usernameCheak.hidden=NO;
            }
            if ([self.nameText.text isEqualToString:@""]) {
                self.usernameCheak.hidden=YES;
            }
            break;
        case 6:
            if (![msgString isEqualToString:@"1"]&&![self.cipherText.text isEqualToString:@""]) {
                self.passwordCheak.image=[UIImage imageNamed:@"wrong.png"];
                self.passwordCheak.hidden=NO;
            }
            if ([msgString isEqualToString:@"1"]) {
                self.passwordCheak.image=[UIImage imageNamed:@"right.png"];
                self.passwordCheak.hidden=NO;
            }
            if ([self.cipherText.text isEqualToString:@""]) {
                self.passwordCheak.hidden=YES;
            }
            break;
        case 7:
            if (![msgString isEqualToString:@"1"]&&![self.emailText.text isEqualToString:@""]) {
                self.emailCheak.image=[UIImage imageNamed:@"wrong.png"];
                self.emailCheak.hidden=NO;
            }
            if ([msgString isEqualToString:@"1"]) {
                self.emailCheak.image=[UIImage imageNamed:@"right.png"];
                self.emailCheak.hidden=NO;
            }
            if ([self.emailText.text isEqualToString:@""]) {
                self.emailCheak.hidden=YES;
            }
            break;
        case 8:
            if (![msgString isEqualToString:@"1"]&&![self.telephoneText.text isEqualToString:@""]) {
                self.telephoneCheak.image=[UIImage imageNamed:@"wrong.png"];
                self.telephoneCheak.hidden=NO;
            }
            if ([msgString isEqualToString:@"1"]) {
                self.telephoneCheak.image=[UIImage imageNamed:@"right.png"];
                self.telephoneCheak.hidden=NO;
            }
            if ([self.telephoneText.text isEqualToString:@""]) {
                self.telephoneCheak.hidden=YES;
            }
            break;
        default:
            break;
    }
     _x=-1;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)backButton:(UIButton *)sender {
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)textExit:(UITextField *)sender {
    
}

@end
