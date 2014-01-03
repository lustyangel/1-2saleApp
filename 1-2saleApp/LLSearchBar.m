//
//  LLSearchBar.m
//  1-2saleApp
//
//  Created by TY on 14-1-2.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import "LLSearchBar.h"

@implementation LLSearchBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"searchImage.png"]];
        
        UITextField *lField=[[UITextField alloc]initWithFrame:CGRectMake(10, 5, self.frame.size.width-40, self.frame.size.height)];
        lField.delegate=self;
        lField.placeholder=@"请输入搜索关键字";
        [self addSubview:lField];
        
//        _lDeleteButton=[[UIButton alloc]initWithFrame:CGRectMake(225, 8, 15, 15)];
//        _lDeleteButton.tag=101;
//        _lDeleteButton.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"delete.png"]];
//        _lDeleteButton.hidden=YES;
//        [self addSubview:_lDeleteButton];
    }
    return self;
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return [_LLDelegate LLtextField:textField shouldChangeCharactersInRange:range replacementString:string];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.placeholder=@"";
    [_LLDelegate LLtextFieldDidBeginEditing:textField];
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

