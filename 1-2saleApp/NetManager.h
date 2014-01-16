//
//  NetManager.h
//  1-2saleApp
//
//  Created by TY on 14-1-14.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetManager : NSObject
+(NetManager *)sharNet;
-(BOOL)connectedToNetwork;
@end
