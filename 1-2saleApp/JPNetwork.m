//
//  JPNetwork.m
//  yyqpush
//
//  Created by YYQ on 13-12-26.
//  Copyright (c) 2013年 YYQ. All rights reserved.
//

#import "JPNetwork.h"
#import "Reachability.h"

@implementation JPNetwork

static JPNetwork *g_instance = nil;


- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


/**
 * @brief           Whether there are single instance
 * @return          the result
 */
+ (BOOL)sharedInstanceExists
{
    return (nil != g_instance);
}

/**
 * @brief           get the signalton engine object
 * @return          the engine object
 */
+ (JPNetwork *)sharedInstance
{
    @synchronized(self) {
        if ( g_instance == nil ) {
            g_instance = [[[self  class] alloc] init];
            //any other specail init as required
        }
    }
    return g_instance;
}


/**
 * @brief           get the network statue
 */
- (BOOL)isNetworkReachable
{
    BOOL isReachable = NO;
    Reachability *reachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch ([reachability currentReachabilityStatus]) {
        case NotReachable:{
            isReachable = NO;
        }
            break;
        case ReachableViaWWAN:{
            isReachable = YES;
        }
            break;
        case ReachableViaWiFi:{
            isReachable = YES;
        }
            break;
        default:
            isReachable = NO;
            break;
    }
    return isReachable;
}

/**
 * @brief           Judgment wifi is connected
 */
- (BOOL)isEnableWIFI
{
    return ([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] != NotReachable);
}

/**
 * @brief           To judge whether the 3G connection
 */
- (BOOL)isEnable3G
{
    return ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable);
}


+ (BOOL)isNetworkContected
{
    return  [[JPNetwork sharedInstance] isNetworkReachable];
}

+ (void)networkBreak
{
    UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"哎呦喂、网络不给力啊" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alter show];
}


@end
