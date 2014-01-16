//
//  AddressCell.m
//  1-2saleApp
//
//  Created by TY on 14-1-14.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import "AddressCell.h"

@implementation AddressCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.layer.cornerRadius=10;
                self.layer.borderColor=[UIColor blackColor].CGColor;
               self.layer.borderWidth=1;
              self.alpha=0.5;
        _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 70, 30)];
                _titleLabel.textAlignment=NSTextAlignmentRight;
              _titleLabel.font=[UIFont systemFontOfSize:14];
                 _titleLabel.backgroundColor=[UIColor clearColor];
             [self addSubview:_titleLabel];
         
                 _textField=[[UITextField alloc]initWithFrame:CGRectMake(75,10, 300, 30)];
                _textField.borderStyle=UITextBorderStyleNone;
                 _textField.font=[UIFont systemFontOfSize:14];
                //_textField.backgroundColor=[UIColor purpleColor];
                 [self addSubview:_textField];
    }
    return self;
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
