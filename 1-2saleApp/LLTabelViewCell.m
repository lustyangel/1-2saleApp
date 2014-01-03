//
//  LLTabelViewCell.m
//  1-2saleApp
//
//  Created by TY on 14-1-3.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import "LLTabelViewCell.h"

@implementation LLTabelViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _lImageView=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 70, 70)];
        _lImageView.image=[UIImage imageNamed:@"product.png"];
        [self addSubview:_lImageView];
        // Initialization code
        _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(80, 0, 235, 40)];
        _nameLabel.font=[UIFont systemFontOfSize:13];
        _nameLabel.numberOfLines=2;
        _nameLabel.backgroundColor=[UIColor clearColor];
        [self addSubview:_nameLabel];
        
        _priceLabel=[[UILabel alloc]initWithFrame:CGRectMake(80, 40, 235, 20)];
        _priceLabel.font=[UIFont systemFontOfSize:10];
        _priceLabel.backgroundColor=[UIColor clearColor];
        _priceLabel.textColor=[UIColor redColor];
        [self addSubview:_priceLabel];
        
        _sellCount=[[UILabel alloc]initWithFrame:CGRectMake(80,60 , 235, 20)];
        _sellCount.font=[UIFont systemFontOfSize:10];
        _sellCount.backgroundColor=[UIColor clearColor];
        [self addSubview:_sellCount];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
