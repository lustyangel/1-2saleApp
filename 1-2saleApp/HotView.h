//
//  HotView.h
//  1-2saleApp
//
//  Created by TY on 14-1-7.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASINetworkQueue.h"
@protocol HotViewDelegate;

@interface HotView : UIButton{
    NSString *_imageName;
    NSTimer *lTimer;
}

@property (nonatomic,retain)NSDictionary *lDic;
@property (nonatomic,retain)UIImageView *lImageView;
@property (nonatomic,retain)ASINetworkQueue *queue;
@property (nonatomic,assign)id<HotViewDelegate>LLDelegate;


-(id)initWithDictionary:(NSDictionary *)dic;

@end

@protocol HotViewDelegate <NSObject>

-(void)HotViewClick;

@end
