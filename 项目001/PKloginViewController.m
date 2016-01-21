//
//  PKloginViewController.m
//  项目001
//
//  Created by ma c on 16/1/18.
//  Copyright (c) 2016年 观世音. All rights reserved.
//

#import "PKloginViewController.h"
#import "PKLoginView.h"

@interface PKloginViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>@property (strong,nonatomic)        PKLoginView* loginView;

@property (strong,nonatomic)        UIButton* returnBtn; // 头像按钮
@property (strong,nonatomic)        UIButton* imageBtn;  // 返回箭头
@property (copy,nonatomic)          NSString* imageFiled;

@end

@implementation PKloginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.loginView];
    
    WS(weakSelf);
    [_loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.bottom.equalTo(weakSelf.view.mas_bottom).offset(-35);
        make.height.equalTo(320);
    }];
    [self.view addSubview:self.returnBtn];
    [_returnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top).offset(40);
        make.left.equalTo(weakSelf.view.mas_left).offset(20);
        make.size.equalTo(CGSizeMake(40, 20));
    }];
    [self.view addSubview:self.imageBtn];
    [_imageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.centerY.equalTo(weakSelf.view.mas_centerY).offset(-200);
        make.size.equalTo(CGSizeMake(60, 60));
    }];
}

- (PKLoginView*)loginView{
    if (!_loginView) {
        _loginView = [[PKLoginView alloc] init];
        _loginView.passText.delegate = self;
        _loginView.userNameText.delegate = self;
        _loginView.emailText.delegate =self;
        [_loginView.okBtn addTarget:self action:@selector(loginHttpRequest) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _loginView;
}

//loginHttpRequest 实现方法
- (void)loginHttpRequest{
    // 点击完成的时候隐藏键盘
    [self disMissKeyboard];
    
    // 判断用户名是否为空，isEmptyString方法是NSString + helper中的
    if ([_loginView.userNameText.text isEmptyString]) {
        [self.view makeToast:@"用户名不能为空" duration:1 position:@"center"];
    }
   // 判断密码是否为空，isEmptyString方法是NSString + helper中的
    if ([_loginView.passText.text isEmptyString]) {
        [self.view makeToast:@"密码不能为空" duration:1 position:@"center"];
    }
  // 判断邮箱名是否为空，isEmptyString方法是NSString + helper中的
        if ([_loginView.emailText.text isEmptyString]) {
            [self.view makeToast:@"邮箱不能为空" duration:1 position:@"center"];
        }
  // 判断头像是否为空，isEqual方法是NSString + helper中的
    if ([_imageBtn.currentImage isEqual:[UIImage imageNamed:@"注册头像"]]) {
        [self.view makeToast:@"头像不能为空"duration:1 position:@"center"];
}
    else {
        //开始进行网络请求，上传头像到服务器
        WS(weakSelf);
        [JPRefreshView showJPRefreshFromView:self.view];
        [ZJPBaseHttpTool postImagePath:@"http://api2.pianke.me/user/reg" params:[self makeLoginRequestDic] image:_imageFiled success:^(id JSON) {
            NSDictionary *returnDic = JSON;
            //判断是否成功，如果result为 1 ，注册成功，result为0，查看返回字典中data字段中msg的错误原因
                        if ([returnDic[@"result"] integerValue] == 1) {
                            [JPRefreshView removeJPRefreshFromView:weakSelf.view];
                //成功后的提示框，方法在 UIView+Toast 中，第一个参数是提示的内容，第二个是显示时间，第三个是显示位置，一共有三个
                [weakSelf.view makeToast:@"注册成功" duration:1 position:@"center"];
            }else{
                [JPRefreshView removeJPRefreshFromView:weakSelf.view];
                [weakSelf.view makeToast:[returnDic[@"data"] valueForKey:@"msg"] duration:1 position:@"center"];
            }
            
        } failure:^(NSError *error) {
            [JPRefreshView removeJPRefreshFromView:weakSelf.view];
            [weakSelf.view makeToast:@"注册失败" duration:1 position:@"center"];
            NSLog(@"error : %@",error);
         
        }];
    }
}

// 制作请求参数
- (NSDictionary*)makeLoginRequestDic{
    NSDictionary *dic = @{@"client":@"1",
                          @"deviceid":@"A55AF7DB-88C8-408D-B983-D0B9C9CA0B36",
                          @"email":_loginView.emailText.text,
                          @"gender":@"1",
                          @"passwd":_loginView.passText.text,
                          @"uname":_loginView.userNameText.text,
                          @"version":@"3.0.6",
                          @"auth":@"",
                          @"iconfile":_imageFiled};
    return dic;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIButton*)returnBtn{
    if (!_returnBtn) {
        _returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_returnBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
        [_returnBtn addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _returnBtn;
}

// 隐藏键盘的方法
- (void)disMissKeyboard{
    [_loginView.emailText resignFirstResponder];
    [_loginView.passText resignFirstResponder];
    [_loginView.userNameText resignFirstResponder];
}
// 返回
- (void)dismissView {
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (UIButton*)imageBtn{
    if (!_imageBtn) {
        _imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_imageBtn setImage:[UIImage imageNamed:@"注册头像"] forState:UIControlStateNormal];
        [_imageBtn addTarget:self action:@selector(imageBtnMethod) forControlEvents:(UIControlEventTouchUpInside)];
        _imageBtn.layer.cornerRadius = 30;
        _imageBtn.layer.masksToBounds = YES;

    }
    return _imageBtn;
}
//判断是从相册还是相机获取图片
- (void)imageBtnMethod{
    UIActionSheet* sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册中选择", nil];
    // 设置那一个显示红色文字显示
    sheet.destructiveButtonIndex = -1;
    [sheet showInView:self.view];
}
// actionSheet代理方法，每一个buttenindex的点击事件
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        //相机拍照
        UIImagePickerController* imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }else if(buttonIndex == 1){
        // 相册选择
        UIImagePickerController* imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    // 获得图片
    UIImage* editedImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    // 获取沙盒目录
    NSString* homePath = [NSHomeDirectory() stringByAppendingString:@"/Documents"];
    NSLog(@"---------%@",homePath);
    // 将图片名字拼接到路径后面
    NSString* imageViews = [homePath stringByAppendingFormat:@"/%d.png",arc4random_uniform(10000000)];
    // 将图片写入沙盒
    [UIImageJPEGRepresentation(editedImage, 1.0f)writeToFile:imageViews atomically:YES];
    // 将图片的路径保存下来，因为在上传图片的时候会用到
    self.imageFiled = imageViews;
    // 更新imageBtn的图片
    [_imageBtn setImage:editedImage forState:(UIControlStateNormal)];
    // 关闭相册界面
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 键盘上移方法
// 开始编辑的时候屏幕上移
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    WS(weakSelf);
    if (textField == _loginView.userNameText) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect = weakSelf.view.bounds;
            rect.origin.y = 50;
            weakSelf.view.bounds = rect;
        }];
    }else if(textField == _loginView.emailText){
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect = weakSelf.view.bounds;
            rect.origin.y = 100;
            weakSelf.view.bounds = rect;
        }];
        
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect = weakSelf.view.bounds;
            rect.origin.y = 150;
            weakSelf.view.bounds = rect;
        }];
    }
    return YES;
}
// 点击return隐藏键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self disMissKeyboard];
    WS(weakSelf);
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = weakSelf.view.bounds;
        rect.origin.y = 0;
        weakSelf.view.bounds = rect;
    }];
    return YES;
}
// 点击屏幕键盘消失
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self disMissKeyboard];
    WS(weakSelf);
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = weakSelf.view.bounds;
        rect.origin.y = 0;
        weakSelf.view.bounds = rect;
    }];
}


@end
