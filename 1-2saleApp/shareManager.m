//
//  shareManager.m
//  6. UICollectionView的选中与删除
//
//  Created by TY on 13-11-13.
//  Copyright (c) 2013年 王懿. All rights reserved.
//

#import "shareManager.h"

static shareManager *shareManagerData = nil;
@implementation shareManager

+ (shareManager *)defaultManager
{
    @synchronized(self)
    {
        if (shareManagerData == nil) {
            shareManagerData = [[shareManager alloc] init];
        }
        
        return shareManagerData;
    }
}

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

@end
