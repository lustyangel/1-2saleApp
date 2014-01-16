//
//  loadView.h
//  1-2saleApp
//
//  Created by TY on 14-1-6.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface loadView : UIView{
    UIImageView *_lImageView;
    UILabel *_lLabel;
    UIActivityIndicatorView *_flower;
    
}


-(void)xuanzhuan;
-(void)xuanzhuanfanhui;
-(void)updating;

@end
