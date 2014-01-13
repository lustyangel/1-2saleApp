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

+(DanLi *)sharDanli;

@end
