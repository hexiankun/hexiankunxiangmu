//
//  PKLandingView.m
//  项目001
//
//  Created by ma c on 16/1/15.
//  Copyright (c) 2016年 观世音. All rights reserved.
//

#import "PKLandingView.h"
#import "Masonry.h"
@implementation PKLandingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.lineLabel1];
        [self addSubview:self.lineLabel2];
        [self addSubview:self.lineLabel3];
        [self addSubview:self.lineLabel4];
        [self addSubview:self.emailText];
        [self addSubview:self.passwordText];
        [self addSubview:self.langdingBtn];
        
        
    }
    return self;
}

- (void)layoutSubviews{
    WS(weakSelf);
    [_lineLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).offset(40);
        make.right.equalTo(weakSelf.mas_right).offset(-40);
        make.height.equalTo(0.5);
        make.top.equalTo(weakSelf.mas_top).offset(55);
    }];
    
    [_lineLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).offset(40);
        make.right.equalTo(weakSelf.mas_right).offset(-40);
        make.height.equalTo(0.5);
        make.top.equalTo(_lineLabel1.mas_top).offset(55);
        
    }];
    
    [_lineLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.lineLabel1.mas_left);
        make.size.equalTo(CGSizeMake(35, 13));
        make.bottom.equalTo(weakSelf.lineLabel1.mas_top).offset(-10);
    }];
    
    [_lineLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.lineLabel2.mas_left);
        make.size.equalTo(CGSizeMake(35, 13));
        make.bottom.equalTo(weakSelf.lineLabel2.mas_top).offset(-10);
    }];
    
    [_emailText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.lineLabel3.mas_right).offset(5);
        make.right.equalTo(weakSelf.lineLabel1.mas_right);
        make.height.equalTo(33);
        make.bottom.equalTo(weakSelf.lineLabel1.mas_top);
    }];
    
    [_passwordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.lineLabel4.mas_right).offset(5);
        make.right.equalTo(weakSelf.lineLabel2.mas_right);
        make.height.equalTo(33);
        make.bottom.equalTo(weakSelf.lineLabel2.mas_top);
        
    }];
    
    [_langdingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(30);
        make.left.equalTo(weakSelf.lineLabel1.mas_left);
        make.right.equalTo(weakSelf.lineLabel1.mas_right);
        make.top.equalTo(weakSelf.lineLabel2.mas_bottom).offset(25);
    }];
    
    //总高度170
}

- (UILabel*)lineLabel1{
    if (!_lineLabel1) {
        _lineLabel1 = [[UILabel alloc] init];
        _lineLabel1.backgroundColor = [UIColor lightGrayColor];
        
    }
    return _lineLabel1;
}

- (UILabel*)lineLabel2{
    if (!_lineLabel2) {
        _lineLabel2 = [[UILabel alloc] init];
        _lineLabel2.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineLabel2;
}

- (UILabel*)lineLabel3{
    if (!_lineLabel3) {
        _lineLabel3 = [[UILabel alloc] init];
        _lineLabel3.text = @"邮箱";
        _lineLabel3.textColor = [UIColor blackColor];
        _lineLabel3.textAlignment = NSTextAlignmentLeft;
        _lineLabel3.font = [UIFont systemFontOfSize:13.0];
        
    }
    return _lineLabel3;
}

- (UILabel*)lineLabel4{
    if (!_lineLabel4) {
        _lineLabel4 = [[UILabel alloc] init];
        _lineLabel4.text = @"密码";
        _lineLabel4.textColor = [UIColor blackColor];
        _lineLabel4.textAlignment = NSTextAlignmentLeft;
        _lineLabel4.font = [UIFont systemFontOfSize:13.0];
        
    }
    return _lineLabel4;
}

- (UITextField*)emailText{
    if (!_emailText) {
        _emailText = [[UITextField alloc] init];
        _emailText.textColor = [UIColor blackColor];
        _emailText.delegate = self;
        _emailText.borderStyle = UITextBorderStyleNone;
        
    }
    return _emailText;
}

- (UITextField*)passwordText{
    if (!_passwordText) {
        _passwordText = [[UITextField alloc] init];
        _passwordText.textColor = [UIColor blackColor];
        _passwordText.delegate = self;
        _passwordText.secureTextEntry = YES;
        _passwordText.borderStyle = UITextBorderStyleNone;
    }
    return _passwordText;
}

- (UIButton*)langdingBtn{
    if (!_langdingBtn) {
        _langdingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_langdingBtn setBackgroundColor:RGB(119, 182, 69)];
        [_langdingBtn setTitle:@"登陆" forState:UIControlStateNormal];
    }
    return _langdingBtn;
}

@end
