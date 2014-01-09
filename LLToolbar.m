//
//  LLToolbar.m
//  1-2saleApp
//
//  Created by TY on 14-1-2.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import "LLToolbar.h"

@implementation LLToolbar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _Select=YES;
        // Initialization code
        self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"toolbar.png"]];
        self.layer.shadowColor=[UIColor darkGrayColor].CGColor;
        self.layer.shadowOffset=CGSizeMake(0, 1);
        
        UIButton *leftButton=[[UIButton alloc]initWithFrame:CGRectMake(5, 5, 34, 34)];
        [leftButton setImage:[UIImage imageNamed:@"leftButton.png"] forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(leftButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [leftButton addTarget:self action:@selector(leftButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
        [leftButton addTarget:self action:@selector(leftButtonTouchCancel:) forControlEvents:UIControlEventTouchUpOutside];
        [leftButton addTarget:self action:@selector(leftButtonTouchCancel:) forControlEvents:UIControlEventTouchCancel];
        [self addSubview:leftButton];
        
        UIButton *rightButton=[[UIButton alloc]initWithFrame:CGRectMake(280, 5, 34, 34)];
        [rightButton setImage:[UIImage imageNamed:@"fangzi.png"] forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(rightButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [rightButton addTarget:self action:@selector(rightButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
        [rightButton addTarget:self action:@selector(rightButtonTouchCancel:) forControlEvents:UIControlEventTouchUpOutside];
        [rightButton addTarget:self action:@selector(rightButtonTouchCancel:) forControlEvents:UIControlEventTouchCancel];
        [self addSubview:rightButton];
        
        UIButton *lSeletButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 180, 34)];
        lSeletButton.center=CGPointMake(self.center.x, 22);
        lSeletButton.layer.cornerRadius=5;
        lSeletButton.backgroundColor=[UIColor colorWithRed:0.48 green:0.86 blue:0.2 alpha:1];
        lSeletButton.layer.borderColor=[UIColor blackColor].CGColor;
        lSeletButton.layer.borderWidth=1;
        [lSeletButton addTarget:self action:@selector(actionViewTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:lSeletButton];
        
        _actionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 88, 32)];
        _actionView.center=CGPointMake(115, 22);
        _actionView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"actionView.png"]];
        _actionView.layer.cornerRadius=3;
        [self addSubview:_actionView];
        
        UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 88, 32)];
        label1.center=CGPointMake(115, 22);
        label1.backgroundColor=[UIColor clearColor];
        label1.text=@"热门商品";
        label1.textColor=[UIColor whiteColor];
        [label1 setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:label1];
        
        UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 88, 32)];
        label2.center=CGPointMake(205, 22);
        label2.backgroundColor=[UIColor clearColor];
        label2.text=@"全部商品";
        label2.textColor=[UIColor whiteColor];
        [label2 setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:label2];
    }
    return self;
}

-(void)actionViewTouchUpInside:(UIButton *)sender{
    if (_Select) {
        [UIView beginAnimations:@"123" context:nil];
        _actionView.center=CGPointMake(205, 22);
        [UIView commitAnimations];
        _Select=NO;
        [_LLDelegate actionViewSelect:1];
    }
    else{
        [UIView beginAnimations:@"123" context:nil];
        _actionView.center=CGPointMake(115, 22);
        [UIView commitAnimations];
        _Select=YES;
        [_LLDelegate actionViewSelect:0];
    }
    
}
-(void)leftButtonTouchUpInside:(UIButton *)sender{
    [_LLDelegate buttonItemSelect:0];
}
-(void)leftButtonTouchDown:(UIButton *)sender{
    
}
-(void)leftButtonTouchCancel:(UIButton *)sender{
    
}


-(void)rightButtonTouchUpInside:(UIButton *)sender{
    [_LLDelegate buttonItemSelect:1];
}
-(void)rightButtonTouchDown:(UIButton *)sender{
    
}
-(void)rightButtonTouchCancel:(UIButton *)sender{
    
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
