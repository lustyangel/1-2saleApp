//
//  DanLi.h
//  1-2saleApp
//
//  Created by TY on 14-1-7.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DanLi : NSObject

@property (nonatomic,assign)int userID;
@property (nonatomic,assign)int goodsID;

+(DanLi *)sharDanli;


// 购物车
@property (nonatomic, assign)float accountAllGoodsPrice;         // 结算所有商品金额
@property (nonatomic, assign)int isShowAccountView;              // 是否显示结算栏
@end
