//
//  showCell.m
//  1-2saleApp
//
//  Created by TY on 14-1-6.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import "showCell.h"

@implementation showCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _titleText =[[UILabel alloc]initWithFrame:CGRectMake(5, 10, 100, 20)];
        //_titleText.backgroundColor=[UIColor redColor];
        [_titleText  setFont:[UIFont systemFontOfSize:14]];
        [self.contentView  addSubview:_titleText];
        
        _labelText1 =[[UILabel alloc]initWithFrame:CGRectMake(5, 30, 200, 35)];
        _labelText1.backgroundColor=[UIColor clearColor];
        [_labelText1  setFont:[UIFont systemFontOfSize:14]];
        [self.contentView  addSubview:_labelText1];
        
        _labelText2 =[[UILabel alloc]initWithFrame:CGRectMake(5, 65, 200, 20)];
        _labelText2.backgroundColor=[UIColor clearColor];
        [_labelText2  setFont:[UIFont systemFontOfSize:14]];
        [self.contentView  addSubview:_labelText2];
        
        _labelText3 =[[UILabel alloc]initWithFrame:CGRectMake(5, 85, 200, 20)];
        _labelText3.backgroundColor=[UIColor clearColor];
        [_labelText3  setFont:[UIFont systemFontOfSize:14]];
        [self.contentView  addSubview:_labelText3];
        
        _labelText4 =[[UILabel alloc]initWithFrame:CGRectMake(5, 105, 200, 20)];
        _labelText4.backgroundColor=[UIColor clearColor];
        [_labelText4  setFont:[UIFont systemFontOfSize:14]];
        [self.contentView  addSubview:_labelText4];
       
        
        
        
        _showText1 =[[UILabel alloc]initWithFrame:CGRectMake(105, 30, 200, 35)];
        _showText1.backgroundColor=[UIColor clearColor];
        [_showText1  setNumberOfLines:2];
        [_showText1  setFont:[UIFont systemFontOfSize:14]];
        [self.contentView  addSubview:_showText1];
        
        _showText2 =[[UILabel alloc]initWithFrame:CGRectMake(105, 65, 200, 20)];
        _showText2.backgroundColor=[UIColor clearColor];
         //  [_showText2  setNumberOfLines:2];
        [_showText2  setFont:[UIFont systemFontOfSize:14]];
        [self.contentView  addSubview:_showText2];
        
        _showText3 =[[UILabel alloc]initWithFrame:CGRectMake(105, 85, 200, 20)];
        _showText3.backgroundColor=[UIColor clearColor];
         //  [_showText3  setNumberOfLines:2];
        [_showText3  setFont:[UIFont systemFontOfSize:14]];
        [self.contentView  addSubview:_showText3];
        
        _showText4 =[[UILabel alloc]initWithFrame:CGRectMake(105, 105, 200, 20)];
        _showText4.backgroundColor=[UIColor clearColor];
          // [_showText4  setNumberOfLines:2];
        [_showText4  setFont:[UIFont systemFontOfSize:14]];
        [self.contentView  addSubview:_showText4];
        
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
