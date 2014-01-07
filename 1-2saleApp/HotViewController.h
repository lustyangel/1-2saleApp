//
//  HotViewController.h
//  1-2saleApp
//
//  Created by TY on 14-1-7.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotView.h"
#import "ASINetworkQueue.h"

@interface HotViewController : UIViewController<NSURLConnectionDataDelegate>{
    NSMutableData *_lData;
    NSMutableArray *_showArray;
}


@end
