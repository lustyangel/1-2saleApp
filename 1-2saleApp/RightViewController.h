//
//  RightViewController.h
//  1-2saleApp
//
//  Created by TY on 14-1-7.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RightViewDelegate;
@interface RightViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    NSArray *_lArray;
}

@property (nonatomic,retain)UITableView *lTabelView;
@property (nonatomic,assign)id<RightViewDelegate>delegate;

@end

@protocol RightViewDelegate <NSObject>
-(void)rightViewTabelViewClick:(int)num;

@end
