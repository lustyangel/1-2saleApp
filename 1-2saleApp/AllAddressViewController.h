//
//  AllAddressViewController.h
//  1-2saleApp
//
//  Created by TY on 14-1-8.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllAddressViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSURLConnectionDataDelegate>{
    UITableView  *_tableView;
    NSMutableData  *_data;
    NSArray *_addressArray;
     
}

@end
