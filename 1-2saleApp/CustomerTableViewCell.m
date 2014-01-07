//
//  CustomerTableViewCell.m
//  ShoppingAPP
//
//  Created by TY on 14-1-3.
//  Copyright (c) 2014年 王懿. All rights reserved.
//

#import "CustomerTableViewCell.h"

@implementation CustomerTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _goodsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
        _goodsImageView.image = [UIImage imageNamed:@"ddefault"];
        
        _goodsNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 160, 50)];
        _goodsNameLabel.numberOfLines = 2;
        _goodsNameLabel.font = [UIFont systemFontOfSize:13];
        _goodsNameLabel.backgroundColor = [UIColor clearColor];
        
        _goodsColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 60, 160, 20)];
        _goodsColorLabel.font = [UIFont systemFontOfSize:11];
        _goodsColorLabel.textColor = [UIColor colorWithHue:1 saturation:0 brightness:0 alpha:0.8];
        _goodsColorLabel.backgroundColor = [UIColor clearColor];
        
        _goodsCountsLabel = [[UILabel alloc] initWithFrame:CGRectMake(130, 90, 60, 15)];
        _goodsCountsLabel.layer.borderWidth = 0.5;
        _goodsCountsLabel.textAlignment = NSTextAlignmentCenter;
        _goodsCountsLabel.font = [UIFont systemFontOfSize:11];
        _goodsCountsLabel.backgroundColor = [UIColor clearColor];
        
        _goodsPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 115, 220, 15)];
        _goodsPriceLabel.textColor = [UIColor redColor];
        _goodsPriceLabel.font = [UIFont systemFontOfSize:15];
        _goodsPriceLabel.backgroundColor = [UIColor clearColor];
        
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteButton.frame = CGRectMake(273, 35, 40, 50);
        [_deleteButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        _deleteButton.titleLabel.font = [UIFont systemFontOfSize:14];
        
        _subdeceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _subdeceButton.frame = CGRectMake(100, 90, 30, 15);
        [_subdeceButton setTitle:@"—" forState:UIControlStateNormal];
        [_subdeceButton setTitleColor:[UIColor colorWithHue:1 saturation:0 brightness:0 alpha:0.6] forState:UIControlStateNormal];
        _subdeceButton.backgroundColor = [UIColor colorWithHue:1 saturation:0 brightness:0 alpha:0.1];
        
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _addButton.frame = CGRectMake(190, 90, 30, 15);
        [_addButton setTitle:@"+" forState:UIControlStateNormal];
        [_addButton setTitleColor:[UIColor colorWithHue:1 saturation:0 brightness:0 alpha:0.7] forState:UIControlStateNormal];
        _addButton.backgroundColor = [UIColor colorWithHue:1 saturation:0 brightness:0 alpha:0.1];
        [_addButton addTarget:self action:@selector(addButton:) forControlEvents:UIControlEventTouchUpInside];
        
        _chooseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _chooseButton.frame = CGRectMake(285, 15, 15, 15);
        _chooseButton.layer.borderWidth = 0.3;
        _chooseButton.layer.borderColor = [[UIColor blueColor] CGColor];
        [_chooseButton addTarget:self action:@selector(chooseButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *lView = [[UIView alloc] initWithFrame:CGRectMake(0, 140, 320, 10)];
        lView.backgroundColor = [UIColor underPageBackgroundColor];
        
        [self.contentView addSubview:_goodsImageView];
        [self.contentView addSubview:_goodsNameLabel];
        [self.contentView addSubview:_goodsColorLabel];
        [self.contentView addSubview:_goodsCountsLabel];
        [self.contentView addSubview:_goodsPriceLabel];
        [self.contentView addSubview:_deleteButton];
        [self.contentView addSubview:_subdeceButton];
        [self.contentView addSubview:_addButton];
        [self.contentView addSubview:_chooseButton];
        [self.contentView addSubview:lView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Private Method
- (void)chooseButtonClick:(UIButton *)sender
{
    if (_isChooseGoods)
    {
        [_chooseButton setImage:nil forState:UIControlStateNormal];
        _chooseButton.layer.borderWidth = 0.3;
        _isChooseGoods = NO;
    }
    else
    {
        [_chooseButton setImage:[UIImage imageNamed:@"chooseGoods.jpg"] forState:UIControlStateNormal];
        _chooseButton.layer.borderWidth = 0;
        _isChooseGoods = YES;
    }
}

- (void)addButton:(UIButton *)sender
{
    self.goodsCounts ++;
}
@end
