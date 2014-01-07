//
//  HotView.h
//  1-2saleApp
//
//  Created by TY on 14-1-7.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASINetworkQueue.h"

@interface HotView : UIButton

@property (nonatomic,retain)ASINetworkQueue *queue;


-(id)initWithDictionary:(NSDictionary *)dic;



@end
