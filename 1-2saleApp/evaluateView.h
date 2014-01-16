//
//  evaluateView.h
//  1-2saleApp
//
//  Created by TY on 14-1-13.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface evaluateView : UIView<UITableViewDataSource,UITableViewDelegate>{
    UIImageView *_connectFaileImage;
    NSMutableData *_lData;
}

@property (nonatomic,retain)UIButton *retryButton;
@property (nonatomic,retain)UITableView *lTabelView;

@property (nonatomic,retain)NSMutableArray *ShowArray;

@end
