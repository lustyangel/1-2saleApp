//
//  ViewController.h
//  GG
//
//  Created by TY on 14-1-20.
//  Copyright (c) 2014年 liumengxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface landViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,NSURLConnectionDataDelegate,UITextFieldDelegate>{
    NSMutableData *_data;
    UITableView *_tableView;
    BOOL _ifDragButtonSpread;
    NSArray *_localUsernameArray;
    NSArray *_localPasswordArray;
    NSArray *_remenberPasswordArray;
    NSString *_passwordSign;
    NSString *_autologonSign;
    UILabel *_uLabel;
    UILabel *_pLabel;

}
- (IBAction)exit:(UITextField *)sender;
@property (weak, nonatomic) IBOutlet UIButton *passwordSaveButton;
@property (weak, nonatomic) IBOutlet UIButton *autologonButton;
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UIButton *dragButton;
@property (weak, nonatomic) IBOutlet UITextField *cipherText;
- (IBAction)landButton:(UIButton *)sender;
- (IBAction)logonButton:(UIButton *)sender;
- (IBAction)dragButton:(UIButton *)sender;
- (IBAction)cipherSaveButton:(UIButton *)sender;
- (IBAction)autologonButton:(UIButton *)sender;
- (IBAction)backButton:(UIButton *)sender;


@end
