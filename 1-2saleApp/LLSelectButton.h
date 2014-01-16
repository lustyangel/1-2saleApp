//
//  LLSelectButton.h
//  1-2saleApp
//
//  Created by TY on 14-1-3.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LLSelectButtonDelegate;

typedef struct LLSelectValue{
    int value1;
    int value2;
}LLSelectValue;

LLSelectValue LLSelectValueMake(int value1,int value2);

@interface LLSelectButton : UIView{
    UIView *_lView1;
    UIView *_lView2;
    UIButton *_priceButton;
    UIButton *_sellcountButton;
    UIButton *_UpButton;
    UIButton *_DownButton;
}


@property (nonatomic,assign)id<LLSelectButtonDelegate> LLDelegate;

@end

@protocol LLSelectButtonDelegate <NSObject>

-(void)buttonValueChange:(LLSelectValue)SelectValue;

@end
