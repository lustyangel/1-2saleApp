//
//  NetManager.m
//  1-2saleApp
//
//  Created by TY on 14-1-14.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import "NetManager.h"
static NetManager *netmanager=nil;
@implementation NetManager
+(NetManager *)sharNet{
    @synchronized(self){
        if (netmanager==nil) {
            netmanager=[[NetManager alloc]init];
        }
    }
    return netmanager;
}
-(BOOL)connectedToNetwork{
    struct  sockaddr  zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    
    zeroAddress.sa_len = sizeof(zeroAddress);
    zeroAddress.sa_family = AF_INET;
    
    SCNetworkReachabilityRef  defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    //获得连接的标志
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    //如果不能获取连接标志，则不能连接网络，直接返回
    if (!didRetrieveFlags)
    {
        NSLog(@"不能连接网络");
        return NO;
        
    }
    //根据获得的连接标志进行判断
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    if (isReachable && !needsConnection) {
        NSLog(@"连接网络yes");
        return YES;
        
    }else{
        NSLog(@"不能连接网络");
        return NO;
        
    }
}

@end
