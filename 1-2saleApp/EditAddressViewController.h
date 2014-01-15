//
//  EditAddressViewController.h
//  1-2saleApp
//
//  Created by TY on 14-1-8.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressCell.h"
@interface EditAddressViewController : UIViewController{
    AddressCell  *_name;
    AddressCell  *_telephone;
    AddressCell   *_code;
    AddressCell   *_detailAddress;
    NSMutableData *_data;
    BOOL  _isSubmit;
    BOOL  _setAddress;
}
@property(nonatomic,retain)NSDictionary *dictionary;
- (IBAction)hideKey:(UIControl *)sender;
@end
