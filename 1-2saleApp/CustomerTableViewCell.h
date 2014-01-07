//
//  CustomerTableViewCell.h
//  ShoppingAPP
//
//  Created by TY on 14-1-3.
//  Copyright (c) 2014年 王懿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomerTableViewCell : UITableViewCell

@property (nonatomic, assign)int goodsCounts;               // 购物车中商品数量
@property (nonatomic, assign)BOOL isChooseGoods;            // 是否选中商品

@property (nonatomic, retain)UIImageView *goodsImageView;   // 商品图片
@property (nonatomic, retain)UILabel *goodsNameLabel;       // 商品名称
@property (nonatomic, retain)UILabel *goodsColorLabel;      // 商品颜色
@property (nonatomic, retain)UILabel *goodsCountsLabel;     // 商品数量
@property (nonatomic, retain)UILabel *goodsPriceLabel;           // 商品价值

@property (nonatomic, retain)UIButton *deleteButton;        // 删除购物车
@property (nonatomic, retain)UIButton *subdeceButton;       // 减少商品数量
@property (nonatomic, retain)UIButton *addButton;           // 增加商品数量
@property (nonatomic, retain)UIButton *chooseButton;        // 选择按钮
@end
