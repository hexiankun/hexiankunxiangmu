//
//  PKLeftViewController.m
//  项目001
//
//  Created by ma c on 16/1/14.
//  Copyright (c) 2016年 观世音. All rights reserved.
//

#import "PKLeftMenuViewController.h"
#import "PKLeftHeadView.h"  //  头部View
#import "PKLeftTableView.h"  // 列表选项
#import "PKLeftMusicView.h" // 底部音乐播放器
#import "PKLangdingViewController.h" // 登陆界面
#import "ZJPNavigationController.h" // 导航
#import "PKFragmentViewController.h" // 碎片
#import "PKSettingViewController.h"   // 设置
#import "PKGoodProductsViewController.h" //良品
#import "PKCommunityViewController.h"  //社区
#import "PKReadViewController.h" //阅读
#import "PKRadioViewController.h" //电台
#import "PKHomeViewController.h"// 首页
@interface PKLeftMenuViewController ()<PKLeftTableViewSelectRow>

@property (strong,nonatomic) PKLeftHeadView* leftheadView;
@property (strong,nonatomic) PKLeftTableView* lefttableView;
@property (strong,nonatomic) PKLeftMusicView* leftMusicView;
@end

@implementation PKLeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    // 监听左侧菜单
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterSuiPianVC) name:@"碎片" object:nil];
    
    self.view.backgroundColor = RGB(51, 51, 51);
    [self.view addSubview:self.leftheadView];
    WS(weakSelf);
    [_leftheadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top);
        make.height.equalTo(190);
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right).offset(-45);
    }];
    [self.view addSubview:self.lefttableView];
    [_lefttableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.leftheadView.mas_bottom);
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.bottom.equalTo(weakSelf.view.mas_bottom).offset(-60);
    }];
    [self.view addSubview:self.leftMusicView];
    [_leftMusicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.bottom.equalTo(weakSelf.view.mas_bottom);
        make.height.equalTo(@60);
    }];
}


// 侧边顶部信息 View
- (PKLeftHeadView *)leftheadView{
    if (!_leftheadView) {
        _leftheadView = [[PKLeftHeadView alloc]init];
        
        
        // 跳转至登陆界面
        
        [_leftheadView.icomImageBtn addTarget:self action:@selector(pushToLandingViewController) forControlEvents:UIControlEventTouchUpInside];
        [_leftheadView.userNameBtn addTarget:self action:@selector(pushToLandingViewController) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return _leftheadView;
}
// 中间切换视图的的列表
- (PKLeftTableView*)lefttableView{
    if (!_lefttableView) {
        _lefttableView = [[PKLeftTableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
        _lefttableView.RowDelegate = self;
    }
    return _lefttableView;
}

// 底部播放器
- (PKLeftMusicView*)leftMusicView{
    if (!_leftMusicView) {
        _leftMusicView = [[PKLeftMusicView alloc] init];
    }
    return _leftMusicView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
             /*************************/



// 跳转方法
- (void)pushToLandingViewController{
    PKLangdingViewController* landing = [[PKLangdingViewController alloc] init];
    
    [self presentViewController:landing animated:YES completion:nil];
}
//- (void)enterSuiPianVC {
//
//    suipianViewController *suiPianVC = [[suipianViewController alloc] init];
//    [self presentViewController:suiPianVC animated:YES completion:^{
//        NSLog(@"进入碎片页面");
//    }];
//}

#pragma mark - RowDelegate
// 执行跳转的代理方法
- (void)selectWhichRow:(NSInteger)row{
    switch (row) {
        case 0:
        {
            // 初始化页面
            PKHomeViewController* homeController = [[PKHomeViewController alloc] init];
            homeController.title = @"首页";
            // 设置根视图
            ZJPNavigationController* homeNav = [[ZJPNavigationController alloc] initWithRootViewController:homeController];
            //进行页面跳转
            [self.sideMenuViewController setContentViewController:homeNav animated:YES];
            //隐藏侧面边栏
            [self.sideMenuViewController hideMenuViewController];
            
        }
            break;
           case 1:
        {
            PKRadioViewController* diantaiController = [[PKRadioViewController alloc] init];
            diantaiController.title = @"电台";
            ZJPNavigationController* diantaiNav = [[ZJPNavigationController alloc] initWithRootViewController:diantaiController];
            [self.sideMenuViewController setContentViewController:diantaiNav animated:YES];
            [self.sideMenuViewController hideMenuViewController];
        }
            break;
            case 2:
        {
            PKReadViewController* readController = [[PKReadViewController alloc] init];
            readController.title = @"阅读";
            ZJPNavigationController* readNav = [[ZJPNavigationController alloc] initWithRootViewController:readController];
            [self.sideMenuViewController setContentViewController:readNav animated:YES];
            [self.sideMenuViewController hideMenuViewController];
        }
            break;
            case 3:
        {
            PKCommunityViewController* shequController = [[PKCommunityViewController alloc] init];
            shequController.title = @"社区";
            ZJPNavigationController* shequNav = [[ZJPNavigationController alloc] initWithRootViewController:shequController];
            [self.sideMenuViewController setContentViewController:shequNav animated:YES];
            [self.sideMenuViewController hideMenuViewController];
        }
            break;
            case 4:
        {
            PKFragmentViewController* suiPianController = [[PKFragmentViewController alloc] init];
            suiPianController.title = @"碎片";
            ZJPNavigationController* suipianNav = [[ZJPNavigationController alloc] initWithRootViewController:suiPianController];
            [self.sideMenuViewController setContentViewController:suipianNav animated:YES];
            [self.sideMenuViewController hideMenuViewController];
        }
            break;
            case 5:
        {
            PKGoodProductsViewController* liangpinController = [[PKGoodProductsViewController alloc] init];
            liangpinController.title = @"良品";
            ZJPNavigationController* liangpinNav = [[ZJPNavigationController alloc] initWithRootViewController:liangpinController];
            [self.sideMenuViewController setContentViewController:liangpinNav animated:YES];
            [self.sideMenuViewController hideMenuViewController];
        }
            break;
            case 6:
        {
            PKSettingViewController* shezhiController = [[PKSettingViewController alloc] init];
            shezhiController.title = @"设置";
            ZJPNavigationController* shezhiNav = [[ZJPNavigationController alloc] initWithRootViewController:shezhiController];
            [self.sideMenuViewController setContentViewController:shezhiNav animated:YES];
            [self.sideMenuViewController hideMenuViewController];
        }
            break;
        default:
            break;
    }
}



@end
