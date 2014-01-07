//
//  ShoppingCartViewController.m
//  ShoppingAPP
//
//  Created by TY on 14-1-3.
//  Copyright (c) 2014年 王懿. All rights reserved.
//

#import "ShoppingCartViewController.h"

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
    self.view.backgroundColor = [UIColor colorWithWhite:255 alpha:1];
    
    // 加载数据
    _allGoodsArray = [[NSMutableArray alloc] initWithArray:[self getShoppingCartInfroArray]];
    
    // 加载菜单栏
    [self getMenuBar];
    
    // 加载tableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 55, 320, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 145;             // 设置行高
    _tableView.allowsSelection = NO;        // 禁止选中
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;      // 设置无分割线
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    
    // 加载结算栏
    [self getCastAccountView];
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

- (void)chooseButtonClick:(UIButton *)sender
{
    if (_isChooseAllGoods)
    {
        [_chooseGoodsButton setImage:nil forState:UIControlStateNormal];
        _chooseGoodsButton.layer.borderWidth = 0.3;
        _isChooseAllGoods = NO;
    }
    else
    {
        [_chooseGoodsButton setImage:[UIImage imageNamed:@"chooseGoods.jpg"] forState:UIControlStateNormal];
        _chooseGoodsButton.layer.borderWidth = 0;
        _isChooseAllGoods = YES;
    }
}

// 结算栏
- (void)getCastAccountView
{
    _castAccountView = [[UIView alloc] initWithFrame:CGRectMake(0, 494, 320, 54)];
    _castAccountView.backgroundColor = [UIColor colorWithHue:1 saturation:0 brightness:0 alpha:0.1];
    _castAccountView.hidden = YES;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 4, 150, 14)];
    label.text = @"商品总价（不含运费）:";
    label.font = [UIFont systemFontOfSize:14];
    label.backgroundColor = [UIColor clearColor];
    [_castAccountView addSubview:label];
    
    _allGoodsPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 4, 165, 14)];
    _allGoodsPriceLabel.text = [NSString stringWithFormat:@"￥%0.2f",_allGoodsPrice];
    _allGoodsPriceLabel.textAlignment = NSTextAlignmentRight;
    _allGoodsPriceLabel.textColor = [UIColor redColor];
    _allGoodsPriceLabel.font = [UIFont systemFontOfSize:14];
    _allGoodsPriceLabel.backgroundColor = [UIColor clearColor];
    [_castAccountView addSubview:_allGoodsPriceLabel];
    
    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteButton.frame = CGRectMake(30, 22, 30, 30);
    [deleteButton setImage:[UIImage imageNamed:@"delete.jpg"] forState:UIControlStateNormal];
    [_castAccountView addSubview:deleteButton];
    
    UIButton *castAccountButton = [UIButton buttonWithType:UIButtonTypeCustom];
    castAccountButton.frame = CGRectMake(215, 22, 100, 30);
    castAccountButton.backgroundColor = [UIColor redColor];
    [castAccountButton setTitle:@"结算" forState:UIControlStateNormal];
    castAccountButton.titleLabel.font = [UIFont systemFontOfSize:15];
    castAccountButton.layer.cornerRadius = 10;
    [_castAccountView addSubview:castAccountButton];
    
    [self.view addSubview:_castAccountView];
}

// 得到数据
- (NSArray *)getShoppingCartInfroArray
{
    ShoppingCartInterface *lShoppingCartInterface = [[ShoppingCartInterface alloc] init];
    NSDictionary *lDictionary = [lShoppingCartInterface checkShoppingCart:@"4"];
    NSArray *lArray  = [lDictionary objectForKey:@"info"];
    return lArray;
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
    
    NSString *goodsCount = [lDictionary objectForKey:@"goodscount"];
    NSString *imageName = [lDictionary objectForKey:@"headerimage"];
    NSString *goodsName = [lDictionary objectForKey:@"name"];
    NSString *goodsColor = [lDictionary objectForKey:@"color"];
    NSString *goodsSize = [lDictionary objectForKey:@"size"];
    NSString *goosPrice = [lDictionary objectForKey:@"amount"];// 总价
    
    lCell.goodsCounts = [goodsCount intValue];
//    lCell.goodsImageView.image = [UIImage imageNamed:imageName];
    lCell.goodsNameLabel.text = goodsName;
    lCell.goodsColorLabel.text = [NSString stringWithFormat:@"颜色:%@  型号:%@",goodsColor,goodsSize];
    lCell.goodsCountsLabel.text = [NSString stringWithFormat:@"%i",lCell.goodsCounts];
    lCell.goodsPriceLabel.text = [NSString stringWithFormat:@"￥%@",goosPrice];
    return lCell;
}


@end
