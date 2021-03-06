//
//  PKBaseViewController.m
//  iOSPianKe
//
//  Created by 赵金鹏 on 16/1/14.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "PKBaseViewController.h"

@interface PKBaseViewController ()

@end

@implementation PKBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)AddBackItemBtn{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithNormalIcon:@"菜单" highlightedIcon:@"菜单" target:self action:@selector(backView)];
    
    

    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)backView{
    
    
    [self.navigationController popViewControllerAnimated:YES];
}

// 网络GET方法
- (void)GETHttpRequest:(NSString *)url
                   dic:(NSDictionary *)dic
          successBalck:(HttpSuccessBlock)RequestSuccess
            errorBlock:(HttpErrorBlock)RequestError{
    WS(weakSelf);
    // 等待动画
    [JPRefreshView showJPRefreshFromView:self.view];
    [ZJPBaseHttpTool getWithPath:url params:dic success:^(id JSON) {
        if (RequestSuccess) {
            RequestSuccess(JSON);
        }
    // 移除等待动画
        [JPRefreshView removeJPRefreshFromView:weakSelf.view];
    } failure:^(NSError *error) {
        if (RequestError) {
            RequestError(error);
        }
        [JPRefreshView removeJPRefreshFromView:weakSelf.view];
    }];
}
// 网络POST方法
- (void)POSTHttpRequest:(NSString *)url
                    dic:(NSDictionary *)dic
           successBalck:(HttpSuccessBlock)RequestSuccess
             errorBlock:(HttpErrorBlock)RequestError
{   WS(weakSelf);
    // 显示等待动画
    [JPRefreshView showJPRefreshFromView:self.view];
    [ZJPBaseHttpTool postWithPath:url params:dic success:^(id JSON) {
        if (RequestSuccess) {
            RequestSuccess(JSON);
        }
        //移除等待动画
        [JPRefreshView removeJPRefreshFromView:weakSelf.view];
    } failure:^(NSError *error) {
        if (RequestError) {
            RequestError(error);
        }
        [JPRefreshView removeJPRefreshFromView:weakSelf.view];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end





