//
//  mainViewController.h
//  1-2saleApp
//
//  Created by TY on 14-1-2.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLToolbar.h"
#import "RightViewController.h"
#import "ShowHotView.h"
#import "ShowAllView.h"
#import "GoodsIngoViewController.h"
#import "HotView.h"

@interface mainViewController : UIViewController<LLToolbarDelegate,RightViewDelegate,ShowHotViewDelegate>{
    UIButton *_FrontView;
    
}
@property(nonatomic,retain)RightViewController *lRightViewController;
@property(nonatomic,retain)GoodsIngoViewController *lGoodsIngoViewController;
@property (nonatomic,retain)UIView *mainView;
@property (nonatomic,retain)UIView *rightView;

@property (nonatomic,retain)ShowHotView *HotView;
@property (nonatomic,retain)ShowAllView *AllView;



@end
