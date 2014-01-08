//
//  DanLi.m
//  1-2saleApp
//
//  Created by TY on 14-1-7.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import "DanLi.h"
static DanLi *SellDali=nil;
@implementation DanLi

+(DanLi *)sharDanli{
    @synchronized(self){
        if (SellDali==nil) {
            SellDali=[[DanLi alloc]init];
        }
    }
    return SellDali;
}

-(id)init{
    self=[super init];
    if (self) {
        ;
    }
    return self;
}

@end
