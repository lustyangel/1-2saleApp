//
//  AffirmOrderViewController.h
//  1-2saleApp
//
//  Created by TY on 14-1-14.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AffirmOrderViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_lTabelView;
}
@property(nonatomic,retain)NSDictionary *cartInfo;
@end
