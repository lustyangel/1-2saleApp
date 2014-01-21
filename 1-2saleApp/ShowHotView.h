//
//  ShowHotView.h
//  1-2saleApp
//
//  Created by TY on 14-1-7.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ShowHotViewDelegate;

@interface ShowHotView : UIView<NSURLConnectionDataDelegate,UIScrollViewDelegate,HotViewDelegate>{
    NSMutableData *_lData;
    NSMutableArray *_showArray;
    UIImageView *_connectFaileImage;
}

@property (nonatomic,retain) UIScrollView *lScrollView;
@property (nonatomic,retain)UIButton *retryButton;
@property (nonatomic,assign)id<ShowHotViewDelegate>LLDelegate;

-(void)reloadView;

@end

@protocol ShowHotViewDelegate <NSObject>

-(void)ShowHotViewClick;

@end
