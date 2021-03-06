//
//  ShoppingCartInterface.h
//  ShoppingAPP
//
//  Created by TY on 14-1-6.
//  Copyright (c) 2014年 王懿. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingCartInterface : NSObject

- (void)addToShoppingCart:(NSDictionary *)goodsInfoDictionary;                  // 添加到购物车
- (NSDictionary *)checkShoppingCart;                                            // 查看购物车
- (NSDictionary *)resetShoppingCart:(NSDictionary *)goodsInfoDictionary;        // 修改购物车
- (NSDictionary *)deleteShoppingCart:(NSArray *)cartIdArray;                    // 删除购物车
@end
