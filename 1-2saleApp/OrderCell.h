//
//  OrderCell.h
//  1-2saleApp
//
//  Created by TY on 14-1-3.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol OrderCellDelegate;
@interface OrderCell : UITableViewCell
@property(nonatomic,retain)UIImageView *imageview;
@property(nonatomic,retain)UILabel *tradeState;
@property(nonatomic,retain)UILabel *name;
@property(nonatomic,retain)UILabel *price;
@property(nonatomic,retain)UILabel *count;
@property(nonatomic,retain)UIButton *stateButton;
@property(nonatomic,assign)id<OrderCellDelegate>delegate;

@end

@protocol OrderCellDelegate <NSObject>
-(void)stateButton:(UIButton*)sender  String:(NSString *)string;

@end
