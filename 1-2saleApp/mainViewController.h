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
#import "LLSelectButton.h"
#import "ASINetworkQueue.h"
#import "loadView.h"
#import "RightViewController.h"

@interface mainViewController : UIViewController<LLSearchBarDelegate,UITableViewDataSource,UITableViewDelegate,NSURLConnectionDataDelegate,LLSelectButtonDelegate,LLToolbarDelegate,RightViewDelegate>{
    NSMutableData *_lData;
    int _paixu;
    int _updown;
    loadView *_loadView;
    int _loadState;
    UIImageView *_sorryImage;
    UIButton *_backButton;
    BOOL _searchState;
    
//    UIView *_mainView;
//    UIView *_rightView;
}
@property(nonatomic,retain)RightViewController *lRightView;
@property (nonatomic,retain)UIView *mainView;
@property (nonatomic,retain)UIView *rightView;

@property (nonatomic,retain)UITableView *lTabelView;
@property (nonatomic,retain)UIButton *lDeleteButton;
@property (nonatomic,retain)UIButton *lSearchButton;
@property (nonatomic,retain)NSMutableArray *showArray;
@property (nonatomic,retain)LLSearchBar *lSearchBar;

@property (nonatomic,retain)ASINetworkQueue *queue;

@end
