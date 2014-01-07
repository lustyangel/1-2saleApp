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
- (NSDictionary *)checkShoppingCart:(NSString *)coustomerId;                    // 查看购物车

@end
