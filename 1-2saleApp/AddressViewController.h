//
//  AddressViewController.h
//  1-2saleApp
//
//  Created by TY on 14-1-6.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressViewController : UIViewController< UITableViewDataSource,UITableViewDelegate,NSURLConnectionDataDelegate,UITextFieldDelegate>{
   NSMutableData  *_data;
    NSMutableArray  *_cityArray;
    UITableView  *_tableView;
    NSMutableString  *_cityString;
    BOOL  _isClick;
    UITextField  *_detailRess;
    UITextField  *_name;
    UITextField  *_telephone;
    UITextField  *_code;
    UIImageView *_verifyView;
    
     
}
- (IBAction)hideKey:(UIControl *)sender;
@end
