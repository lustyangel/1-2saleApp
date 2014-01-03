//
//  LLSearchBar.h
//  1-2saleApp
//
//  Created by TY on 14-1-2.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LLSearchBarDelegate;
@interface LLSearchBar : UIView<UITextFieldDelegate>

@property (nonatomic,retain)UIButton *lDeleteButton;
@property (nonatomic,assign)id<LLSearchBarDelegate> LLDelegate;

@end

@protocol LLSearchBarDelegate <NSObject>

-(BOOL)LLtextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
-(void)LLtextFieldDidBeginEditing:(UITextField *)textField;

@end
