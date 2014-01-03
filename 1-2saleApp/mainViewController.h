//
//  mainViewController.h
//  1-2saleApp
//
//  Created by TY on 14-1-2.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLSearchBar.h"
#import "LLToolbar.h"
#import "LLTabelViewCell.h"

@interface mainViewController : UIViewController<LLSearchBarDelegate,UITableViewDataSource,UITableViewDelegate,NSURLConnectionDataDelegate>{
    NSMutableData *_lData;
}

@property (nonatomic,retain)UITableView *lTabelView;
@property (nonatomic,retain)UIButton *lDeleteButton;
@property (nonatomic,retain)UIButton *lSearchButton;
@property (nonatomic,retain)NSMutableArray *showArray;

@end
