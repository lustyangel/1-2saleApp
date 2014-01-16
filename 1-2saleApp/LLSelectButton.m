//
//  LLSelectButton.m
//  1-2saleApp
//
//  Created by TY on 14-1-3.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import "LLSelectButton.h"
#define kOrange [UIColor colorWithRed:1 green:0.2 blue:0 alpha:1]

LLSelectValue LLSelectValueMake(int value1,int value2)
{
    LLSelectValue Value;
    Value.value1=value1;
    Value.value2=value2;
    return Value;
}

@implementation LLSelectButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //25
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 24, 320, 1)];
        lineView.backgroundColor=[UIColor lightGrayColor];
        [self addSubview:lineView];
        
//        self.backgroundColor=[UIColor lightGrayColor];

        _priceButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
        [_priceButton setTitle:@"价格" forState:UIControlStateNormal];
        [_priceButton setTitleColor:kOrange forState:UIControlStateNormal];
        _priceButton.titleLabel.font=[UIFont systemFontOfSize:14];
        [_priceButton addTarget:self action:@selector(priceButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [_priceButton addTarget:self action:@selector(priceButtonTouchCancel:) forControlEvents:UIControlEventTouchCancel];
        [self addSubview:_priceButton];
        
        _sellcountButton=[[UIButton alloc]initWithFrame:CGRectMake(60, 0, 60, 20)];
        [_sellcountButton setTitle:@"销量" forState:UIControlStateNormal];
        [_sellcountButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _sellcountButton.titleLabel.font=[UIFont systemFontOfSize:14];
        [_sellcountButton addTarget:self action:@selector(sellButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [_sellcountButton addTarget:self action:@selector(sellButtonTouchCancel:) forControlEvents:UIControlEventTouchCancel];
        [self addSubview:_sellcountButton];
        
        _UpButton=[[UIButton alloc]initWithFrame:CGRectMake(200, 0, 60, 20)];
        [_UpButton setTitle:@"升序" forState:UIControlStateNormal];
        [_UpButton setTitleColor:kOrange forState:UIControlStateNormal];
        _UpButton.titleLabel.font=[UIFont systemFontOfSize:14];
        [_UpButton addTarget:self action:@selector(UpButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [_UpButton addTarget:self action:@selector(UpButtonTouchCancel:) forControlEvents:UIControlEventTouchCancel];
        [self addSubview:_UpButton];
        
        _DownButton=[[UIButton alloc]initWithFrame:CGRectMake(260, 0, 60, 20)];
        [_DownButton setTitle:@"降序" forState:UIControlStateNormal];
        [_DownButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _DownButton.titleLabel.font=[UIFont systemFontOfSize:14];
        [_DownButton addTarget:self action:@selector(DownButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [_DownButton addTarget:self action:@selector(DownButtonTouchCancel:) forControlEvents:UIControlEventTouchCancel];
        [self addSubview:_DownButton];
        
        _lView1=[[UIView alloc]initWithFrame:CGRectMake(14, 22, 32, 2)];
        _lView1.backgroundColor=[UIColor colorWithRed:1 green:0.3 blue:0 alpha:1];
        [self addSubview:_lView1];
        
        _lView2=[[UIView alloc]initWithFrame:CGRectMake(214, 22, 32, 2)];
        _lView2.backgroundColor=[UIColor colorWithRed:1 green:0.3 blue:0 alpha:1];
        [self addSubview:_lView2];
    }
    return self;
}


-(void)priceButtonTouchUpInside:(UIButton *)sender{
    [sender setTitleColor:kOrange forState:UIControlStateNormal];
    [_sellcountButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [UIView beginAnimations:@"123" context:nil];
    _lView1.center=CGPointMake(30, 23);
    [UIView commitAnimations];
    [_LLDelegate buttonValueChange:LLSelectValueMake(0, 2)];
}
-(void)priceButtonTouchCancel:(UIButton *)sender{
    return;
}



-(void)sellButtonTouchUpInside:(UIButton *)sender{
    [sender setTitleColor:kOrange forState:UIControlStateNormal];
    [_priceButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [UIView beginAnimations:@"123" context:nil];
    _lView1.center=CGPointMake(90, 23);
    [UIView commitAnimations];
    [_LLDelegate buttonValueChange:LLSelectValueMake(1, 2)];
}
-(void)sellButtonTouchCancel:(UIButton *)sender{
    return;
}



-(void)UpButtonTouchUpInside:(UIButton *)sender{
    [sender setTitleColor:kOrange forState:UIControlStateNormal];
    [_DownButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [UIView beginAnimations:@"123" context:nil];
    _lView2.center=CGPointMake(230, 23);
    [UIView commitAnimations];
    [_LLDelegate buttonValueChange:LLSelectValueMake(2, 0)];
}
-(void)UpButtonTouchCancel:(UIButton *)sender{
    return;
}



-(void)DownButtonTouchUpInside:(UIButton *)sender{
    [sender setTitleColor:kOrange forState:UIControlStateNormal];
    [_UpButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [UIView beginAnimations:@"123" context:nil];
    _lView2.center=CGPointMake(290, 23);
    [UIView commitAnimations];
    [_LLDelegate buttonValueChange:LLSelectValueMake(2, 1)];
}
-(void)DownButtonTouchCancel:(UIButton *)sender{
    return;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
