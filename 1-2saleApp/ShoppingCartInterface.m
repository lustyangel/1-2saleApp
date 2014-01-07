//
//  ShoppingCartInterface.m
//  ShoppingAPP
//
//  Created by TY on 14-1-6.
//  Copyright (c) 2014年 王懿. All rights reserved.
//

#import "ShoppingCartInterface.h"

@implementation ShoppingCartInterface

// 添加商品到购物车
- (void)addToShoppingCart:(NSDictionary *)goodsInfoDictionary
{
    NSString *goodsId = [goodsInfoDictionary objectForKey:@"goodsid"];
    NSString *customerId = [goodsInfoDictionary objectForKey:@"coustomerid"];
    NSString *goodsCount = [goodsInfoDictionary objectForKey:@"goodscount"];
    
    NSString *lBodyString = [NSString stringWithFormat:@"goodsid=%@&customerid=%@&goodscount=%@",goodsId,customerId,goodsCount];
    NSString *URLString = [NSString stringWithFormat:@"http://%@/shop/addcart.php",kIP];
    NSURL *lURL = [NSURL URLWithString:URLString];
    NSMutableURLRequest *lURLRequest = [NSMutableURLRequest requestWithURL:lURL];
    [lURLRequest setHTTPMethod:@"post"];
    [lURLRequest setHTTPBody:[lBodyString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error = nil;
    NSData *lData = [NSURLConnection sendSynchronousRequest:lURLRequest returningResponse:nil error:&error];
    if (lData == nil)
    {
        NSLog(@"send request failed: %@", error);
    }
    else
    {
        NSString *lString = [[NSString alloc] initWithData:lData encoding:NSUTF8StringEncoding];
        NSLog(@"%@",lString);
    }
}

// 查看购物车
- (NSDictionary *)checkShoppingCart:(NSString *)coustomerId
{
    NSString *lBodyString = [NSString stringWithFormat:@"customerid=%@",coustomerId];

    NSString *URLString = [NSString stringWithFormat:@"http://%@/shop/getcart.php",kIP];
    NSURL *lURL = [NSURL URLWithString:URLString];
    NSMutableURLRequest *lURLRequest = [NSMutableURLRequest requestWithURL:lURL];
    [lURLRequest setHTTPMethod:@"post"];
    [lURLRequest setHTTPBody:[lBodyString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error = nil;
    NSData *lData = [NSURLConnection sendSynchronousRequest:lURLRequest returningResponse:nil error:&error];
    if (lData == nil)
    {
        NSLog(@"send request failed: %@", error);
        NSDictionary *dictionary = [[NSDictionary alloc] init];
        return dictionary;
    }
    else
    {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:lData options:NSJSONReadingAllowFragments error:nil];
        NSDictionary *lDic = [dictionary objectForKey:@"msg"];
        NSLog(@"%@",lDic);
        return lDic;
    }
}



@end
