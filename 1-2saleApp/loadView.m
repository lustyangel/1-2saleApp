//
//  loadView.m
//  1-2saleApp
//
//  Created by TY on 14-1-6.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import "loadView.h"

@implementation loadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _lImageView=[[UIImageView alloc]initWithFrame:CGRectMake(80, 0, 30, 40)];
        _lImageView.image=[UIImage imageNamed:@"loadImage.png"];
        [self addSubview:_lImageView];
        _lImageView.layer.anchorPoint=CGPointMake(0.5, 0.5);
        
        
        _lLabel=[[UILabel alloc]initWithFrame:CGRectMake(110, 10, 150, 20)];
        _lLabel.text=@"向上拖拽加载更多数据";
//        _lLabel.backgroundColor=[UIColor orangeColor];
//        _lLabel.textAlignment=NSTextAlignmentCenter;
        _lLabel.font=[UIFont systemFontOfSize:14];
        [self addSubview:_lLabel];
        
        _flower=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(180, 5, 30, 30)];
        _flower.activityIndicatorViewStyle=UIActivityIndicatorViewStyleGray;
//        _flower.hidesWhenStopped=YES;
        [self addSubview:_flower];
    }
    return self;
}

-(void)xuanzhuan{
    _lLabel.text=@"松开加载数据";
    [UIView beginAnimations:@"123" context:nil];
    _lImageView.layer.affineTransform=CGAffineTransformMakeRotation(M_PI);
    [UIView commitAnimations];
}

-(void)updating{
    _lImageView.hidden=YES;
    _lLabel.text=@"正在加载";
    [_flower startAnimating];
}

-(void)xuanzhuanfanhui{
    _lLabel.text=@"向上拖拽加载更多数据";
    [UIView beginAnimations:@"123" context:nil];
    _lImageView.layer.affineTransform=CGAffineTransformMakeRotation(0);
    [UIView commitAnimations];
    [_flower stopAnimating];
    _lImageView.hidden=NO;
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
