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
@property (nonatomic,assign)int goodsCount;
<<<<<<< HEAD
@property (nonatomic,retain)NSDictionary *userInfoDictionary;
=======
@property (nonatomic,retain)NSDictionary *address;
>>>>>>> 8fef0b2833f596c929c17962bfe6e46bd0add858

+(DanLi *)sharDanli;


// 购物车
@property (nonatomic, assign)float           accountAllGoodsPrice;        // 结算所有商品金额
@property (nonatomic, copy)NSString         *myUserID;                    // 用户ID
@property (nonatomic, retain)NSMutableArray *cartIdArray;                 // 购物车数组
@end
