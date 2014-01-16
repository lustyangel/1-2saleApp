//
//  EditAddressViewController.h
//  1-2saleApp
//
//  Created by TY on 14-1-8.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditAddressViewController : UIViewController{
    UITextField  *_name;
    UITextField  *_telephone;
    UITextField   *_code;
    UITextField   *_detailAddress;
    NSMutableData *_data;
}
@property(nonatomic,retain)NSDictionary *dictionary;
- (IBAction)hideKey:(UIControl *)sender;
@end
