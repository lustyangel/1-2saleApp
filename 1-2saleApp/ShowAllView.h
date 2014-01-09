//
//  ShowAllView.h
//  1-2saleApp
//
//  Created by TY on 14-1-7.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLSearchBar.h"
#import "LLTabelViewCell.h"
#import "LLSelectButton.h"
#import "loadView.h"
#import "ASINetworkQueue.h"
@protocol ShowAllViewDelegate;
@interface ShowAllView : UIView<LLSearchBarDelegate,UITableViewDataSource,UITableViewDelegate,NSURLConnectionDataDelegate,LLSelectButtonDelegate>{
    NSMutableData *_lData;
    int _paixu;
    int _updown;
    loadView *_loadView;
    int _loadState;
    UIImageView *_sorryImage;
    UIButton *_backButton;
    BOOL _searchState;  // 0  普通状态, 1  ,2  ,3 正在下载
    UIButton *_FrontView;
    BOOL  _requesting;
}


@property (nonatomic,retain)UITableView *lTabelView;
@property (nonatomic,retain)UIButton *lDeleteButton;
@property (nonatomic,retain)UIButton *lSearchButton;
@property (nonatomic,retain)NSMutableArray *showArray;
@property (nonatomic,retain)LLSearchBar *lSearchBar;
@property (nonatomic,retain)ASINetworkQueue *queue;

//@property (nonatomic,assign)<id>

@end

@protocol ShowAllViewDelegate <NSObject>

-(void)showAllViewDelegate;

@end
