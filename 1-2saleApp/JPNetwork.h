//
//  JPNetwork.h
//  yyqpush
//
//  Created by YYQ on 13-12-26.
//  Copyright (c) 2013年 YYQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JPNetwork : NSObject

/**
 * @brief           get the signalton engine object
 * @return          the engine object
 */
+ (JPNetwork *)sharedInstance;

/**
 * @brief           get the network statue
 */
- (BOOL)isNetworkReachable;

/**
 * @brief           Judgment wifi is connected
 */
- (BOOL)isEnableWIFI;

/**
 * @brief           To judge whether the 3G connection
 */
- (BOOL)isEnable3G;

+ (BOOL)isNetworkContected;

+ (void)networkBreak;

@end
