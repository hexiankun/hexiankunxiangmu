//
//  PKTopView.m
//  项目001
//
//  Created by ma c on 16/1/18.
//  Copyright (c) 2016年 观世音. All rights reserved.
//

#import "PKTopView.h"
#import "Masonry.h"
@implementation PKTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.imageView];
        [self addSubview:self.registry];
        [self addSubview:self.returnn];
    }
    return self;
}

- (void)layoutSubviews{
    WS(weakSelf);
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(100, 50));
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.centerY.equalTo(weakSelf.mas_centerY).offset(-100);
    }];
    
    [_registry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(40);
        make.right.equalTo(weakSelf.mas_right).offset(-20);
        make.size.equalTo(CGSizeMake(40, 20));
    }];
    
    [_returnn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(40, 20));
        make.top.equalTo(weakSelf.mas_top).offset(20);
        make.left.equalTo(weakSelf.mas_left).offset(40);
    }];
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
        [_registry setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _registry;
}

- (UIButton*)returnn{
    if (!_returnn) {
        _returnn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_returnn setTitle:@"返回" forState:UIControlStateNormal];
    }
    return _returnn;
}


@end
