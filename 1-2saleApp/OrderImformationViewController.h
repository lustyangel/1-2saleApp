//
//  OrderImformationViewController.h
//  1-2saleApp
//
//  Created by TY on 14-1-3.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderImformationViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    NSArray *_array;
}
@property(nonatomic,retain)NSDictionary *dictionary;
 

@end
