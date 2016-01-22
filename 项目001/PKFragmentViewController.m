//
//  suipianViewController.m
//  项目001
//
//  Created by ma c on 16/1/19.
//  Copyright (c) 2016年 观世音. All rights reserved.
//

#import "PKFragmentViewController.h"
#import "PKFragmentTable.h"
#import "MJRefresh.h"
#import "PKFragmentModel.h"
#import "NSArray+PKFragmentCellHeight.h"
#import "PKLeftMenuViewController.h"
#import "RESideMenu.h"
@interface PKFragmentViewController ()
@property (strong,nonatomic)            PKFragmentTable* fragmentTable;
@property (strong,nonatomic)            PKFragmentModel* FragmentModel;

@end

@implementation PKFragmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self navigationItemAction];
    
    
    [self.view addSubview:self.fragmentTable];
    [self addAutoLayout];
    [self reloadFragmentTabelData:0];
}


- (void)addAutoLayout{
    WS(weakSelf);
    [_fragmentTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (PKFragmentTable *)fragmentTable{
    if (!_fragmentTable) {
        _fragmentTable = [[PKFragmentTable alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:(UITableViewStylePlain)];
        WS(weakSelf);
        //上拉加载的block回调方法
        _fragmentTable.MoreDataBlock = ^(){
            // 隐藏当前的上拉刷新控件
            [weakSelf reloadFragmentTabelData:0];
        };
        //下拉加载的block回调方法
        _fragmentTable.NewDataBlock = ^(){
            [weakSelf reloadFragmentTabelData:10];
        };
    }
    return _fragmentTable;
}


- (void)reloadFragmentTabelData:(NSInteger)start{
    //制作请求参数
    NSDictionary *requestDic = @{@"auth":@"W8c8Fivl9flDCsJzH8HukzJxQMrm3N7KP9Wc5WTFjcWP229VKTBRU7vI",
                                 @"client":@"1",
                                 @"deviceid":@"A55AF7DB-88C8-408D-B983-D0B9C9CA0B36",
                                 @"limit":@"10",
                                 @"start":[NSString stringWithFormat:@"%li",start],
                                 @"version":@"3.0.6"};
    WS(weakSelf);
    //开始网络请求
    [self POSTHttpRequest:@"http://api2.pianke.me/timeline/list" dic:requestDic successBalck:^(id JSON) {
        
        NSDictionary *returnDic = JSON;
        if ([returnDic[@"result"]integerValue] == 1) {
            //将得到的模型转换成model
            weakSelf.FragmentModel = [[PKFragmentModel alloc]initWithDictionary:returnDic];
            NSArray *heightArray = [NSArray countCellHeight:weakSelf.FragmentModel.data.list];
            
            //tableview用来存储数据的数组
            weakSelf.fragmentTable.FragmentModel = weakSelf.FragmentModel.data.list;
            //给tableviewcell高度的数组赋值
            weakSelf.fragmentTable.cellHeightArray = heightArray;
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.fragmentTable reloadData];
            });
            
        }
        //结束刷新状态
        [weakSelf.fragmentTable.mj_footer endRefreshing];
        [weakSelf.fragmentTable.mj_header endRefreshing];
    } errorBlock:^(NSError *error) {
        NSLog(@"-----------%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)navigationItemAction{
            UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
            [imageView setImage:[UIImage imageNamed:@"碎片"]];
            [self.navigationItem setTitleView:imageView];
    
//        UIBarButtonItem *leftBtn1 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:(UIBarButtonSystemItemBookmarks) target:self action:@selector(leftAction1:)];
    UIBarButtonItem* leftBtn1 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"菜单"] style:UIBarButtonItemStyleDone target:self action:@selector(leftAction1:)];

    
         UIBarButtonItem* leftBtn2 = [[UIBarButtonItem alloc] initWithTitle:@"碎片" style:UIBarButtonItemStyleDone target:self action:@selector(leftAction2:)];
    
    
        self.navigationItem.leftBarButtonItems = @[leftBtn1,leftBtn2];
        UIBarButtonItem *rightBtn1 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:(UIBarButtonSystemItemFastForward) target:self action:@selector(rightAction1:)];
    
     //添加图片
        UIBarButtonItem* rightBtn2 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"碎片"] style:UIBarButtonItemStyleDone target:self action:@selector(rightAction2:)];
    
    //
        self.navigationItem.rightBarButtonItems = @[rightBtn1,rightBtn2];
        

    
    
}

- (void)leftAction1:(id)sender {
    PKLeftMenuViewController *baseVC = [[PKLeftMenuViewController alloc]init];
    
    [self presentViewController:baseVC animated:YES completion:nil];
    
}
- (void)leftAction2:(id)sender {
    
}

-(void)rightAction1:(id)sender {
    
    
    
}
-(void)rightAction2:(id)sender {
    
    
    
}


@end
