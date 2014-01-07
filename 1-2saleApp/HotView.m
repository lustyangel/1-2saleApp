//
//  HotView.m
//  1-2saleApp
//
//  Created by TY on 14-1-7.
//  Copyright (c) 2014年 ljt. All rights reserved.
//

#import "HotView.h"

@implementation HotView

//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        // Initialization code
////        self.frame=CGRectMake(0, 0, 80, 100);
//        self.backgroundColor=[UIColor grayColor];
//    }
//    return self;
//}

-(id)initWithDictionary:(NSDictionary *)dic
{
    self=[super init];
    if (self) {
        self.layer.borderColor=[UIColor blackColor].CGColor;
        self.layer.borderWidth=1;
//        self.backgroundColor=[UIColor grayColor];
        
        
        if ([self judgeLocationImage:[dic objectForKey:@"headerimage"]]!=nil) {
            UIImageView *lImageView=[[UIImageView alloc]initWithImage:[self judgeLocationImage:[dic objectForKey:@"headerimage"]]];
            [self addSubview:lImageView];
        }
    }
    return self;
}

-(UIImage *)judgeLocationImage:(NSString *)imageName{
    NSString *lStr=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *lPath=[lStr stringByAppendingPathComponent:imageName];
    UIImage *lImage=[UIImage imageWithContentsOfFile:lPath];
    if (lImage==nil) {
        [self getHeadImage:imageName];
        return nil;
    }
    else{
        return lImage;
    }
}

-(void)getHeadImage:(NSString *)imageName{
    if (![self queue]) {
        [self setQueue:[[ASINetworkQueue alloc]init]];
        [self queue].maxConcurrentOperationCount=15;
        [[self queue]setShouldCancelAllRequestsOnFailure:NO];
    }
    NSURL *lUrl=[NSURL URLWithString:[NSString stringWithFormat:@"http://%@/shop/goodsimage/%@",kIP,imageName]];
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:lUrl];
    request.delegate=self;
    
    NSString *lStr=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *lPath=[lStr stringByAppendingPathComponent:imageName];
    
    [request setDownloadDestinationPath:lPath];
    [request setDidFinishSelector:@selector(DownloadFinish:)];
    [request setDidFailSelector:@selector(DownloadFailed:)];
    [_queue addOperation:request];
    [_queue go];
}

-(void)DownloadFinish:(ASIHTTPRequest *)sender{
    //    [_lTabelView reloadData];
}
-(void)DownloadFailed:(ASIHTTPRequest *)sender{
    NSLog(@"Error");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
