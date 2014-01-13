//
//  AllOrderViewController.h
//  1-2saleApp
//
//  Created by TY on 14-1-3.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderCell.h"
#import "UIScrollView+PullLoad.h"
@interface AllOrderViewController : UIViewController<NSURLConnectionDataDelegate,UITableViewDataSource,UITableViewDelegate,OrderCellDelegate,PullDelegate>
{
    NSMutableData   *_data;
    NSArray *_array;
    UITableView  *_tableView;
    int  _showcount;
}
@end
