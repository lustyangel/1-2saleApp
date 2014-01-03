//
//  LLToolbar.h
//  1-2saleApp
//
//  Created by TY on 14-1-2.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LLToolbarDelegate;
@interface LLToolbar : UIView{
    BOOL _Select;
}

@property (nonatomic,retain)id<LLToolbarDelegate>LLDelegate;

@end

@protocol LLToolbarDelegate <NSObject>

-(void)actionViewSelect:(int)selectNumber;
-(void)buttonItemSelect:(int)selectNumber;

@end