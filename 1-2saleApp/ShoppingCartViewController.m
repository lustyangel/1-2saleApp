//
//  ShoppingCartViewController.m
//  ShoppingAPP
//
//  Created by TY on 14-1-3.
//  Copyright (c) 2014年 王懿. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "DanLi.h"

@interface ShoppingCartViewController ()

@end

@implementation ShoppingCartViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if ([DanLi sharDanli].userInfoDictionary == nil) {
        [self getMenuBar];
            
        UIImageView *lView = [[UIImageView alloc] initWithFrame:CGRectMake(60, 100, 200, 150)];
        lView.image = [UIImage imageNamed:@"smile_go.jpg"];
        [self.view addSubview:lView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 250, 240, 100)];
        label.text = @"请先登陆，亲！如果还没有账号，那快去注册吧!";
        label.font = [UIFont systemFontOfSize:20];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 2;
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor redColor];
        
        [self.view addSubview:label];
        return;
    }
    
    [DanLi sharDanli].myUserID = [[NSString alloc] initWithString:[[DanLi sharDanli].userInfoDictionary objectForKey:@"customerid"]];
    
    // 加载数据
    NSDictionary *lDictionary = [self getShoppingCartInfroDictionary];
    int count = [[lDictionary objectForKey:@"count"] intValue];
    if (count == 0) {
        [self getMenuBar];
        
        UIImageView *lView = [[UIImageView alloc] initWithFrame:CGRectMake(85, 100, 130, 130)];
        lView.image = [UIImage imageNamed:@"smile.jpg"];
        [self.view addSubview:lView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 250, 240, 100)];
        label.text = @"您的购物车还没有商品哦，快去购物吧!";
        label.font = [UIFont systemFontOfSize:20];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 2;
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor redColor];
        [self.view addSubview:label];
        return;
    }
    
    NSArray *infroArray = [lDictionary objectForKey:@"info"];
    for (NSDictionary *getAallCountsDic in infroArray) {
        _allGoodsCounts += [[getAallCountsDic objectForKey:@"goodscount"] intValue];
    }
    _allGoodsArray = [[NSMutableArray alloc] initWithArray:infroArray];
    // 得到所有商品总数
    _isShowGoodsArray = [[NSMutableArray alloc] init];
    for (int i=0; i<_allGoodsArray.count; i++) {
        NSNumber *lNumber = [NSNumber numberWithBool:NO];
        [_isShowGoodsArray addObject:lNumber];
    }
    
    // 加载菜单栏
    [self getMenuBar];
    
    if (_allGoodsArray.count == 0) {
        
    }
    
    // 加载tableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 55, 320, self.view.frame.size.height-55) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 145;             // 设置行高
    _tableView.allowsSelection = NO;        // 禁止选中
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;      // 设置无分割线
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    
    // 加载结算栏
    [self getCastAccountView];
    
    // 添加观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shoppingCartNotificationCenter:) name:@"post" object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Mehtod
// 菜单栏
- (void)getMenuBar
{
    UIView *menuBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 55)];
    menuBarView.backgroundColor = [UIColor underPageBackgroundColor];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(5, 7, 40, 40);
    [backButton setImage:[UIImage imageNamed:@"title_back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [menuBarView addSubview:backButton];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 110, 55)];
    label1.text = @"我的购物车";
    label1.textColor = [UIColor redColor];
    label1.font = [UIFont systemFontOfSize:17];
    label1.backgroundColor = [UIColor clearColor];
    [menuBarView addSubview:label1];
    
    _showGoodsCountsLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 0, 125, 55)];
    NSString *lString = [NSString stringWithFormat:@"全部商品（%i）",_allGoodsCounts];
    _showGoodsCountsLabel.text = lString;
    _showGoodsCountsLabel.font = [UIFont systemFontOfSize:15];
    _showGoodsCountsLabel.backgroundColor = [UIColor clearColor];
    [menuBarView addSubview:_showGoodsCountsLabel];
    
    _chooseGoodsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _chooseGoodsButton.frame = CGRectMake(285, 20, 15, 15);
    _chooseGoodsButton.layer.borderWidth = 0.3;
    _chooseGoodsButton.layer.borderColor = [[UIColor blueColor] CGColor];
    [_chooseGoodsButton addTarget:self action:@selector(chooseButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [menuBarView addSubview:_chooseGoodsButton];
    
    [self.view addSubview:menuBarView];
}

- (void)backButtonClick:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 选择按钮
- (void)chooseButtonClick:(UIButton *)sender
{
    // 结算前先清空数据
    [DanLi sharDanli].accountAllGoodsPrice = 0;
    if ([DanLi sharDanli].cartIdArray.count > 0) {
        [[DanLi sharDanli].cartIdArray removeAllObjects];
    }
    
    if (_isChooseAllGoods)
    {
        [_chooseGoodsButton setImage:nil forState:UIControlStateNormal];
        _chooseGoodsButton.layer.borderWidth = 0.3;
        _isChooseAllGoods = NO;
        
        for (int i=0; i<_isShowGoodsArray.count; i++)
        {
            NSNumber *lNumber = [NSNumber numberWithBool:NO];
            [_isShowGoodsArray replaceObjectAtIndex:i withObject:lNumber];
        }       
        _castAccountView.hidden = YES;        
    }
    else
    {
        [_chooseGoodsButton setImage:[UIImage imageNamed:@"chooseGoods.jpg"] forState:UIControlStateNormal];
        _chooseGoodsButton.layer.borderWidth = 0;
        _isChooseAllGoods = YES;
        
        for (int i=0; i<_allGoodsArray.count; i++)
        {
            NSDictionary *lDictionary = [_allGoodsArray objectAtIndex:i];
            NSString *priceString = [lDictionary objectForKey:@"amount"];
            [DanLi sharDanli].accountAllGoodsPrice += [priceString floatValue];
            
            NSNumber *lNumber = [NSNumber numberWithBool:YES];
            [_isShowGoodsArray replaceObjectAtIndex:i withObject:lNumber];
            
            // 记录被选中的购物车ID信息
            NSDictionary *lDic = [_allGoodsArray objectAtIndex:i];
            [[DanLi sharDanli].cartIdArray addObject:lDic];
        }
        
       

        _allGoodsPriceLabel.text = [NSString stringWithFormat:@"￥%0.2f",[DanLi sharDanli].accountAllGoodsPrice];
        _castAccountView.hidden = NO;
        _tableView.frame = CGRectMake(0, 55, 320, self.view.frame.size.height-55-54);
    }
    NSLog(@"%@",[DanLi sharDanli].cartIdArray);

    [[NSNotificationCenter defaultCenter] postNotificationName:@"cellPost" object:[NSNumber numberWithBool:_isChooseAllGoods] userInfo:nil];
}

// 结算栏
- (void)getCastAccountView
{
    _castAccountView = [[UIView alloc] initWithFrame:CGRectMake(0, 494, 320, 54)];
    _castAccountView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:0 alpha:1];
    _castAccountView.hidden = YES;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 4, 150, 14)];
    label.text = @"商品总价（不含运费）:";
    label.font = [UIFont systemFontOfSize:14];
    label.backgroundColor = [UIColor clearColor];
    [_castAccountView addSubview:label];
    
    _allGoodsPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 4, 165, 14)];
    _allGoodsPriceLabel.text = [NSString stringWithFormat:@"￥%0.2f",[DanLi sharDanli].accountAllGoodsPrice];
    _allGoodsPriceLabel.textAlignment = NSTextAlignmentRight;
    _allGoodsPriceLabel.textColor = [UIColor redColor];
    _allGoodsPriceLabel.font = [UIFont systemFontOfSize:14];
    _allGoodsPriceLabel.backgroundColor = [UIColor clearColor];
    [_castAccountView addSubview:_allGoodsPriceLabel];
    
    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteButton.frame = CGRectMake(30, 22, 30, 30);
    [deleteButton setImage:[UIImage imageNamed:@"delete.jpg"] forState:UIControlStateNormal];
    [deleteButton addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_castAccountView addSubview:deleteButton];
    
    _castAccountButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _castAccountButton.frame = CGRectMake(215, 22, 100, 30);
    _castAccountButton.backgroundColor = [UIColor redColor];
    [_castAccountButton setTitle:@"结算" forState:UIControlStateNormal];
    _castAccountButton.titleLabel.font = [UIFont systemFontOfSize:15];
    _castAccountButton.layer.cornerRadius = 10;
    [_castAccountButton addTarget:self action:@selector(castAccontButton:) forControlEvents:UIControlEventTouchUpInside];
    [_castAccountView addSubview:_castAccountButton];
    
    [self.view addSubview:_castAccountView];
}

// 结算按钮
- (void)castAccontButton:(UIButton *)sender
{
    
}

// 删除购物车按钮
- (void)deleteButtonClick:(UIButton *)sender
{
    NSMutableArray *lArray = [[NSMutableArray alloc] init];
    
    for (int i=0; i<[DanLi sharDanli].cartIdArray.count; i++)
    {
        NSDictionary *lDictionary = [[DanLi sharDanli].cartIdArray objectAtIndex:i];
        NSString *cartId = [lDictionary objectForKey:@"cartid"];
        [lArray addObject:cartId];
    }
    
    ShoppingCartInterface *lShoppingCartInterface = [[ShoppingCartInterface alloc] init];
    NSDictionary *lDictionary = [lShoppingCartInterface deleteShoppingCart:lArray];
    
    int count = [[lDictionary objectForKey:@"count"] intValue];
    if (count == 0) {
        [self getMenuBar];
        _showGoodsCountsLabel.text = @"全部商品（0）";
        
        UIImageView *lView = [[UIImageView alloc] initWithFrame:CGRectMake(85, 100, 130, 130)];
        lView.image = [UIImage imageNamed:@"smile.jpg"];
        [self.view addSubview:lView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 250, 240, self.view.frame.size.height-55)];
        label.text = @"您的购物车还没有商品哦，快去购物吧!";
        label.font = [UIFont systemFontOfSize:20];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 2;
        label.backgroundColor = [UIColor underPageBackgroundColor];
        label.textColor = [UIColor redColor];
        [self.view addSubview:label];
        return;
    }

    
    NSArray *lInfoArray  = [lDictionary objectForKey:@"info"];
    [_allGoodsArray setArray:lInfoArray];
    _isShowGoodsArray = [[NSMutableArray alloc] init];
    for (int i=0; i<_allGoodsArray.count; i++) {
        [_isShowGoodsArray addObject:[NSNumber numberWithBool:NO]];
    }
    
    [_tableView reloadData];
    [self emtpyViewData];
}

// 得到数据
- (NSDictionary *)getShoppingCartInfroDictionary
{
    ShoppingCartInterface *lShoppingCartInterface = [[ShoppingCartInterface alloc] init];
    NSDictionary *lDictionary = [lShoppingCartInterface checkShoppingCart];
    return lDictionary;
}

// 接收通知
- (void)shoppingCartNotificationCenter:(NSNotification *)sender
{
    NSDictionary *lDictionary = sender.userInfo;
    CustomerTableViewCell *lCell = sender.object;
    
    // 增减购物车商品数量
    if ([[lDictionary objectForKey:@"event"] isEqual:@"addOrSubtract"]) {
        NSArray *lArray  = [lDictionary objectForKey:@"info"];
        
        // 重置菜单栏商品总数
        _allGoodsCounts = 0;
        for (NSDictionary *getAallCountsDic in lArray) {
            _allGoodsCounts += [[getAallCountsDic objectForKey:@"goodscount"] intValue];
        }
        NSString *lString = [NSString stringWithFormat:@"全部商品（%i）",_allGoodsCounts];
        _showGoodsCountsLabel.text = lString;
        
        [_allGoodsArray setArray:lArray];
        [_tableView reloadData];
        
        [self emtpyViewData];
        
    }
    
    // 显示结算栏
    if ([[lDictionary objectForKey:@"event"] isEqual:@"accountGoods"])
    {            
        BOOL isShowChooseButton = lCell.isChooseGoods;
        NSNumber *lNumber = [NSNumber numberWithBool:isShowChooseButton];
        [_isShowGoodsArray replaceObjectAtIndex:lCell.tag-100 withObject:lNumber];
        
        NSDictionary *lDictionary = [_allGoodsArray objectAtIndex:lCell.tag-100];
        NSString *priceString = [lDictionary objectForKey:@"amount"];
        if (isShowChooseButton) {            
            [DanLi sharDanli].accountAllGoodsPrice += [priceString floatValue];
        } else {
            [DanLi sharDanli].accountAllGoodsPrice -= [priceString floatValue];
        }
        _allGoodsPriceLabel.text = [NSString stringWithFormat:@"￥%0.2f",[DanLi sharDanli].accountAllGoodsPrice];
        
        // 是否显示结算栏
        for (int i=0; i<_isShowGoodsArray.count; i++) {
            BOOL lBool = [[_isShowGoodsArray objectAtIndex:i] boolValue];
            if (lBool) {
                _castAccountView.hidden = NO;
                _tableView.frame = CGRectMake(0, 55, 320, self.view.frame.size.height-55-54);
                break;
            } 
            
            if ((i == _isShowGoodsArray.count-1) && (lBool == NO)) {
                _castAccountView.hidden = YES;
                _tableView.frame = CGRectMake(0, 55, 320, self.view.frame.size.height-55);
            }
        }
        
        // 是否显示菜单栏选择按钮
        for (int i=0; i<_isShowGoodsArray.count; i++)
        {
            BOOL lBool = [[_isShowGoodsArray objectAtIndex:i] boolValue];
            if (lBool == NO) {
                [_chooseGoodsButton setImage:nil forState:UIControlStateNormal];
                _chooseGoodsButton.layer.borderWidth = 0.3;
                _isChooseAllGoods = NO;
                break;
            }
            
            if ((i == _isShowGoodsArray.count-1) && lBool) {
                [_chooseGoodsButton setImage:[UIImage imageNamed:@"chooseGoods.jpg"] forState:UIControlStateNormal];
                _chooseGoodsButton.layer.borderWidth = 0;
                _isChooseAllGoods = YES;
            }
        }
    }
        
        
    // 得到所有被选择了的购物车    
    if ([[lDictionary objectForKey:@"event"] isEqual:@"forCartIdArray"])
    {
        if (lCell.isChooseGoods)
        {
            NSDictionary *lDictionary = [_allGoodsArray objectAtIndex:lCell.tag-100];
            NSString *cartid = [lDictionary objectForKey:@"cartid"];
            
            for (int i=0; i<[DanLi sharDanli].cartIdArray.count; i++) {
                NSDictionary *lDic = [[DanLi sharDanli].cartIdArray objectAtIndex:i];
                NSString *cartID = [lDic objectForKey:@"cartid"];
                if ([cartid isEqualToString:cartID]) {
                    [[DanLi sharDanli].cartIdArray removeObjectAtIndex:i];
                    break;
                }
            }
        }
        else
        {
            NSDictionary *lDictionary = [_allGoodsArray objectAtIndex:lCell.tag-100];
            [[DanLi sharDanli].cartIdArray addObject:lDictionary];
        }
        NSLog(@"%@",[DanLi sharDanli].cartIdArray);
    }

    
    
}

// 更新页面数据时，清空页面数据和单例数据
- (void)emtpyViewData
{
    [_chooseGoodsButton setImage:nil forState:UIControlStateNormal];
    _chooseGoodsButton.layer.borderWidth = 0.3;
    _isChooseAllGoods = NO;
    
    [DanLi sharDanli].accountAllGoodsPrice = 0;
    
    _castAccountView.hidden = YES;
}

-(void)getImage{
    
    
}

#pragma mark - UITableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _allGoodsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellID = @"CellID";
    CustomerTableViewCell *lCell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (lCell == nil) {
        lCell = [[CustomerTableViewCell alloc] init];
    }
    
    NSInteger row = indexPath.row;
    NSDictionary *lDictionary = [_allGoodsArray objectAtIndex:row];
    lCell.tag = 100 + row;
    
    NSString *goodsCount = [lDictionary objectForKey:@"goodscount"];
    NSString *imageName = [lDictionary objectForKey:@"headerimage"];
    NSString *goodsName = [lDictionary objectForKey:@"name"];
    NSString *goodsColor = [lDictionary objectForKey:@"color"];
    NSString *goodsSize = [lDictionary objectForKey:@"size"];
    NSString *goosPrice = [lDictionary objectForKey:@"amount"];// 总价
    
    lCell.goodsCounts = [goodsCount intValue];
    
    lCell.goodsNameLabel.text = goodsName;
    lCell.goodsColorLabel.text = [NSString stringWithFormat:@"颜色:%@  型号:%@",goodsColor,goodsSize];
    lCell.goodsCountsLabel.text = [NSString stringWithFormat:@"%i",lCell.goodsCounts];
    lCell.goodsPriceLabel.text = [NSString stringWithFormat:@"￥%@",goosPrice];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *lURL=[NSURL URLWithString:[NSString stringWithFormat:@"http://%@/shop/goodsimage/%@",kIP,imageName]];
        NSData *lData=[NSData dataWithContentsOfURL:lURL];
        UIImage *lImage=[[UIImage alloc]initWithData:lData];
        dispatch_sync(dispatch_get_main_queue(), ^{            
            lCell.goodsImageView.image = lImage;
        });
    });
    
    BOOL isShowChooseButton = [[_isShowGoodsArray objectAtIndex:row] boolValue];
    if (isShowChooseButton) {
        [lCell.chooseButton setImage:[UIImage imageNamed:@"chooseGoods.jpg"] forState:UIControlStateNormal];
        lCell.chooseButton.layer.borderWidth = 0;
    }
    
    if ([goodsCount isEqualToString:@"1"]) {
        lCell.subdeceButton.hidden = YES;
    }
    
    if (_isChooseAllGoods) {
        lCell.isChooseGoods = YES;
    }
    
    
    return lCell;
}


@end
