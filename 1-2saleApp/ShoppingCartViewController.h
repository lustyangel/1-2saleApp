//
//  ShoppingCartViewController.h
//  ShoppingAPP
//
//  Created by TY on 14-1-3.
//  Copyright (c) 2014年 王懿. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerTableViewCell.h"
#import "ShoppingCartInterface.h"

@interface ShoppingCartViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    int             _allGoodsCounts;                                    // 购物车中商品总数
    UIButton       *_chooseGoodsButton;                           // 购物车菜单栏右侧选择按钮
    UILabel        *_showGoodsCountsLabel;                         // 显示商品总数
    BOOL            _isChooseAllGoods;                                 // 用于判断是否选择了所有商品
    
    UITableView    *_tableView;
    NSMutableArray *_allGoodsArray;                         // 显示购物车中所有商品
    NSMutableArray *_isShowGoodsArray;                      // 判断购物车按钮是否选中的数组
    
    UIView         *_castAccountView;                               // 结算栏
    
    UILabel        *_allGoodsPriceLabel;                           // 显示所有商品总价
}

@end
