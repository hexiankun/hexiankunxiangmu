//
//  LiangPinViewController.m
//  项目001
//
//  Created by ma c on 16/1/19.
//  Copyright (c) 2016年 观世音. All rights reserved.
//

#import "PKGoodProductsViewController.h"
#import "PKGoodProductsCell.h"
#import "MJChiBaoZiHeader.h"
#import "MJChiBaoZiFooter2.h"
#import "MJRefresh.h"
#import "PKGoodProductsInfoController.h"
static NSString *identigier = @"cell";

@interface PKGoodProductsViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic)  UITableView *goodProductTableView;
@property (strong,nonatomic)  NSArray *goodProductArray;

@end

@implementation PKGoodProductsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.goodProductTableView = [[UITableView alloc]initWithFrame:self.view.frame style:(UITableViewStylePlain)];
    _goodProductTableView.delegate = self;
    _goodProductTableView.dataSource = self;
    _goodProductTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.goodProductTableView registerClass:[PKGoodProductsCell class] forCellReuseIdentifier:identigier];
    [self.view addSubview:self.goodProductTableView];
    [self addRefreshControl];
    [self reloadGoodPraductsData:0];
    [self navigationItemAction];

}
- (void)addRefreshControl{
    MJChiBaoZiHeader *header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    //影藏事件
    header.lastUpdatedTimeLabel.hidden = YES;
    //隐藏状态
    header.stateLabel.hidden = YES;
    // 马上进入刷新状态
    self.goodProductTableView.mj_header = header;
    //设置上拉加载的动画
    MJChiBaoZiFooter2 *footer = [MJChiBaoZiFooter2 footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    //隐藏状态
    footer.stateLabel.hidden = YES;
    
    //透明度
    self.goodProductTableView.mj_footer.automaticallyChangeAlpha = YES;
    //马上刷新
    self.goodProductTableView.mj_footer = footer;
    
}
//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return _goodProductArray.count;
}
//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    return 220.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //系统
//    PKGoodProductsCell *cell = [tableView dequeueReusableCellWithIdentifier:identigier];
//    if (!cell) {
//        cell = [[PKGoodProductsCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identigier];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//    }
    
    //自定义cell
    PKGoodProductsCell *cell = [tableView dequeueReusableCellWithIdentifier:identigier forIndexPath:indexPath];
    
    
    
    
    
    NSDictionary *dataDic = _goodProductArray[indexPath.row];
    // 加载网络图片的方法 （UIImageView+SDWedImage中)

    [cell.contentImage downloadImage:dataDic[@"coverimg"]];
     cell.contentLabel.text = dataDic[@"title"];

    
    
    return cell;
}




- (void)reloadGoodPraductsData:(NSInteger)start {
    //制作请求参数
    NSDictionary *requestDic = @{@"auth":@"W8c8Fivl9flDCsJzH8HukzJxQMrm3N7KP9Wc5WTFjcWP229VKTBRU7vI",
                                 @"client":@"1",
                                 @"deviceid":@"A55AF7DB-88C8-408D-B983-D0B9C9CA0B36",
                                 @"limit":@"10",
                                 @"start":[NSString stringWithFormat:@"%li",start],
                                 @"version":@"3.0.6"};
    
    WS(weakSelf);
    [self POSTHttpRequest:@"http://api2.pianke.me/pub/shop" dic:requestDic successBalck:^(id JSON) {
        
        
        NSDictionary *dataDic = JSON;
        if ([dataDic[@"result"] integerValue] == 1) {
            weakSelf.goodProductArray = [dataDic[@"data"] valueForKey:@"list"];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [weakSelf.goodProductTableView reloadData];
            });
            
            
        }
        
        
    } errorBlock:^(NSError *error) {
        NSLog(@"%@",error);
        
    }];
    
    
    
    
}
//得到跟多数据
- (void)loadMoreData{
    [self reloadGoodPraductsData:10];
}
//重新加载数据
- (void)loadNewData{
    [self reloadGoodPraductsData:0];
}

//选择后页面跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PKGoodProductsInfoController *info = [[PKGoodProductsInfoController alloc]init];
    
    info.contentID = [self.goodProductArray[indexPath.row] valueForKey:@"contentid"];
    
    [self.navigationController pushViewController:info animated:YES];
}

-(void)navigationItemAction{
    
    UIBarButtonItem *leftBtn1 = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"菜单"] style:(UIBarButtonItemStyleDone) target:self action:@selector(leftBtnAction)];
    
    self.navigationItem.leftBarButtonItem = leftBtn1;
}
-(void)leftBtnAction{
    
    [self.sideMenuViewController presentLeftMenuViewController];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
