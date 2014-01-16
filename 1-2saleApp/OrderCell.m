//
//  OrderCell.m
//  1-2saleApp
//
//  Created by TY on 14-1-3.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import "OrderCell.h"
 
@implementation OrderCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
       _imageview=[[UIImageView alloc]initWithFrame:CGRectMake(5, 10, 80, 80)];
        _imageview.backgroundColor=[UIColor  grayColor];
        [self.contentView addSubview:_imageview];
        
         int  width=self.frame.size.width-10;
        int   imageheight=_imageview.frame.size.height;
         int   imagewidth=_imageview.frame.size.width;
        
      
        _tradeState=[[UILabel alloc]initWithFrame:CGRectMake(5,imageheight-10, 80, 20)];
      // [_tradeState setText:@"交易关闭"];
        _tradeState .backgroundColor=[UIColor clearColor];
         _tradeState.font=[UIFont systemFontOfSize:12];
        [_tradeState setTextColor:[UIColor whiteColor]];
        _tradeState.textAlignment=NSTextAlignmentCenter;
        [self.contentView addSubview:_tradeState];
        
        _name=[[UILabel alloc]initWithFrame:CGRectMake(10+imagewidth, 10, width-imagewidth, imageheight/2)];
        _name.numberOfLines=2;
        _name.font=[UIFont systemFontOfSize:14];
        [self.contentView addSubview:_name];
        
        _count=[[UILabel alloc]initWithFrame:CGRectMake(10+imagewidth, 10+imageheight/2, (width-imagewidth)/2, imageheight/4)];
          _count.font=[UIFont systemFontOfSize:14];
          _count.textAlignment=NSTextAlignmentCenter;
        [_count setTextColor:[UIColor grayColor]];
        [self.contentView addSubview:_count];

        
        _price=[[UILabel alloc]initWithFrame:CGRectMake( width-100, 10+imageheight/2,100,imageheight/4)];
        _price.font=[UIFont systemFontOfSize:14];
        _price.textAlignment=NSTextAlignmentCenter;
        [_price setTextColor:[UIColor redColor]];
         [self.contentView addSubview:_price];
     
        
        _stateButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _stateButton.backgroundColor=[UIColor redColor];
        [_stateButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _stateButton.frame=CGRectMake( width-90, 10+imageheight/2+_price .frame.size.height, 80, imageheight/4+5);
        [self.contentView addSubview:_stateButton];
        
    }
    return self;
}
-(void)buttonClick:(UIButton*)sender{
    [_delegate  stateButton:sender String:_count.text];
}


 

@end
