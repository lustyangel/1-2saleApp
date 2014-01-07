//
//  ViewController.h
//  Go Shopping
//
//  Created by TY on 13-11-6.
//  Copyright (c) 2013年 liumengxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,NSURLConnectionDataDelegate>{
    NSMutableData *_data;
    UITableView *_tableView;
    BOOL _ifDragButtonSpread;
    NSArray *_localUsernameArray;
    NSArray *_localPasswordArray;
    NSArray *_remenberPasswordArray;
    NSString *_passwordSign;
}
- (IBAction)textExit:(UITextField *)sender;
@property (retain, nonatomic) IBOutlet UITextField *nameText;
@property (retain, nonatomic) IBOutlet UITextField *cipherText;
@property (weak, nonatomic) IBOutlet UIButton *passwordSaveButton;
- (IBAction)cipherSaveButton:(UIButton *)sender;
- (IBAction)autologonButton:(UIButton *)sender;
- (IBAction)dragButton:(UIButton *)sender;
- (IBAction)landButton:(UIButton *)sender;
- (IBAction)logonButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *dragButton;
-(void)cleanUsername;
-(void)cleanCipher;

@end
