//
//  PKLangdingViewController.m
//  项目001
//
//  Created by ma c on 16/1/15.
//  Copyright (c) 2016年 观世音. All rights reserved.
//

#import "PKLangdingViewController.h"
#import "PKThirdLandingView.h" // 底部View
#import "PKLandingView.h" // 邮箱正常登陆
#import "Masonry.h"
#import "PKloginViewController.h"
@interface PKLangdingViewController ()<UITextFieldDelegate>
@property (strong,nonatomic)      PKThirdLandingView* thirdView;
@property (strong,nonatomic)        PKLandingView* langding;
@property (strong,nonatomic)        UIButton* registry;
@property (strong,nonatomic)        UIButton* returnn;
@property (strong,nonatomic)        UIImageView* imageView;

@end

@implementation PKLangdingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.registry];
    [self.view addSubview:self.returnn];
    [self.view addSubview:self.thirdView];
    
    WS(weakSelf);
    [_thirdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(150);
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.bottom.equalTo(weakSelf.view.mas_bottom);
        
    }];
    
    [self.view addSubview:self.langding];
    
    [_langding mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.thirdView.mas_top).offset(-50);
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.height.equalTo(170);
        
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(100, 50));
            make.centerX.equalTo(weakSelf.view.mas_centerX);
            make.centerY.equalTo(weakSelf.view.mas_centerY).offset(-100);
        }];
        
        [_registry mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.view.mas_top).offset(40);
            make.right.equalTo(weakSelf.view.mas_right).offset(-20);
            make.size.equalTo(CGSizeMake(40, 20));
        }];
        
        [_returnn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(40, 20));
            make.top.equalTo(weakSelf.view.mas_top).offset(40);
            make.left.equalTo(weakSelf.view.mas_left).offset(20);
        }];

    }];
    
}

// 底部第三方登陆View
- (PKThirdLandingView*)thirdView{
    if (!_thirdView) {
        _thirdView = [[PKThirdLandingView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    }
    return _thirdView;
}

// 邮箱登陆
- (PKLandingView*)langding{
    if (!_langding) {
        _langding = [[PKLandingView alloc] init];
        [_langding.langdingBtn addTarget:self action:@selector(dismissAction) forControlEvents:(UIControlEventTouchUpInside)];
        
    }
    return _langding;
}

- (void)dismissAction {
    [self disMissKeyboard];
    
    // 判断邮箱是否为空
    if ([_langding.emailText.text isEmptyString]) {
        [self.view makeToast:@"邮箱不能为空" duration:1 position:@"center"];
    }
    if ([_langding.passwordText.text isEmptyString]) {
        [self.view makeToast:@"密码不能为空" duration:1 position:@"center"];
    }
    else{
        // 开始进行网络请求
        WS(weakSelf);
        [JPRefreshView showJPRefreshFromView:self.view];
        [ZJPBaseHttpTool postWithPath:@"http://api2.pianke.me/user/login" params:[self makeLoginRequestDic] success:^(id JSON) {
            NSDictionary* returnDic = JSON;
            if ([returnDic[@"result"]integerValue] == 1) {
                [JPRefreshView removeJPRefreshFromView:weakSelf.view];
                [weakSelf.view makeToast:@"登陆成功" duration:1 position:@"center"];
            }else{
                [JPRefreshView removeJPRefreshFromView:weakSelf.view];
                [weakSelf.view makeToast:[returnDic[@"data"]valueForKey:@"msg"]duration:1 position:@"center"];
            }
        } failure:^(NSError *error) {
            [weakSelf.view makeToast:@"登录失败" duration:1 position:@"center"];
            [JPRefreshView removeJPRefreshFromView:weakSelf.view];
        }];
    }
}
- (NSDictionary*)makeLoginRequestDic{
    NSDictionary *dic = @{@"client":@"1",
                          @"deviceid":@"A55AF7DB-88C8-408D-B983-D0B9C9CA0B36",
                          @"email":_langding.emailText.text,
                          @"passwd":_langding.passwordText.text,
                          @"version":@"3.0.6",
                          @"auth":@"",
                          };
    return dic;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// 上部View的属性
- (UIImageView*)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"片刻LOGO"]];
    }
    return _imageView;
}

- (UIButton*)registry{
    if (!_registry) {
        _registry= [UIButton buttonWithType:UIButtonTypeCustom];
        [_registry setTitle:@"注册" forState:UIControlStateNormal];
        [_registry setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
       
        [_registry addTarget:self action:@selector(registryView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registry;
}

- (UIButton*)returnn{
    if (!_returnn) {
        _returnn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_returnn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
        [_returnn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
         [_returnn addTarget:self action:@selector(returnViewMethod) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _returnn;
}
- (void)returnViewMethod{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    WS(weakSelf);
    if (textField == _langding.emailText) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect = weakSelf.view.bounds;
            rect.origin.y = 50;
            weakSelf.view.bounds = rect;
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect = weakSelf.view.bounds;
            rect.origin.y = 100;
            weakSelf.view.bounds = rect;
        }];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_langding.emailText resignFirstResponder];
    [_langding.passwordText resignFirstResponder];
    WS(weakSelf);
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = weakSelf.view.bounds;
        rect.origin.y = 0;
        weakSelf.view.bounds = rect;
    }];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_langding.emailText resignFirstResponder];
    [_langding.passwordText resignFirstResponder];
    WS(weakSelf);
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = weakSelf.view.bounds;
        rect.origin.y = 0;
        weakSelf.view.bounds = rect;
    }];
}
- (void)disMissKeyboard{
    [_langding.emailText resignFirstResponder];
    [_langding.passwordText resignFirstResponder];
    
}


- (void)registryView{
    PKloginViewController* langding = [[PKloginViewController alloc] init];
    
    [self presentViewController:langding animated:YES completion:nil];

    
}
@end
