//
//  shareManager.h
//  6. UICollectionView的选中与删除
//
//  Created by TY on 13-11-13.
//  Copyright (c) 2013年 王懿. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface shareManager : NSObject
@property (nonatomic, assign)float accountAllGoodsPrice;         // 结算所有商品金额
@property (nonatomic, assign)int isShowAccountView;              // 是否显示结算栏

+ (shareManager *)defaultManager;

@end
