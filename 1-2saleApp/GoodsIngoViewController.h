//
//  GoodsIngoViewController.h
//  1-2saleApp
//
//  Created by TY on 14-1-8.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailInfoViewController.h"
#import "evaluateView.h"

@interface GoodsIngoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    NSMutableData *_lData;
    UIImageView *_connectFaileImage;
    BOOL _lBoolDetailInfo;
}

@property (nonatomic,retain)UIButton *retryButton;
@property (nonatomic,retain)NSDictionary *lDic;
@property (nonatomic,retain)UITextField *lNumber;
@property (nonatomic,retain)UIScrollView *lScrollView;
@property (nonatomic,retain)UIWebView *lWebView;
@property (nonatomic,retain)UILabel *titleLabel;

@end
