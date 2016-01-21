//
//  PKThirdLandingView.m
//  项目001
//
//  Created by ma c on 16/1/15.
//  Copyright (c) 2016年 观世音. All rights reserved.
//

#import "PKThirdLandingView.h"
#import "Masonry.h"
@implementation PKThirdLandingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.xinlang];
        [self addSubview:self.renren];
        [self addSubview:self.douban];
        [self addSubview:self.tengxun];
        [self addSubview:self.xiantiao];
        [self addSubview:self.wenzi];
        
    }
    return self;
}

- (void)layoutSubviews{
    WS(weakSelf);
    CGFloat width = (VIEW_WIDTH-100.0)/5.0;
    [_xinlang mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).offset(width);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-50);
        make.size.equalTo(CGSizeMake(25, 25));
        
    }];
    
    [_renren mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(25, 25));
        make.left.equalTo(_xinlang.mas_right).offset(width);
        make.centerY.equalTo(_xinlang.mas_centerY);
        
    }];
    
    [_douban mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(25, 25));
        make.left.equalTo(_renren.mas_right).offset(width);
        make.centerY.equalTo(_xinlang.mas_centerY);
    }];
    
    [_tengxun mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(25, 25));
        make.left.equalTo(_douban.mas_right).offset(width);
        make.centerY.equalTo(_xinlang.mas_centerY);
    }];
    
    [_xiantiao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).offset(width);
        make.right.equalTo(weakSelf.mas_right).offset(-width);
        make.height.equalTo(0.5);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-130);
    }];
    [_wenzi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.xiantiao.mas_centerY);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.size.equalTo(CGSizeMake(125, 24));
    }];
    
}




- (UIImageView*)xinlang{
    if (!_xinlang) {
        _xinlang = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"新浪"]];
    }
    return _xinlang;
}

- (UIImageView*)renren{
    if (!_renren) {
        _renren = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"人人"]];
    }
    return _renren;
}

- (UIImageView*)douban{
    if (!_douban) {
        _douban = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"豆瓣"]];
    }
    return _douban;
}

- (UIImageView*)tengxun{
    if (!_tengxun) {
        _tengxun = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"QQ"]];
    }
    return _tengxun;
}

- (UILabel*)xiantiao{
    if (!_xiantiao) {
        _xiantiao = [[UILabel alloc] init];
        _xiantiao.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    }
    return _xiantiao;
}

- (UILabel*)wenzi{
    if (!_wenzi) {
        _wenzi = [[UILabel alloc] init];
        _wenzi.text = @"合作伙伴登陆片刻";
        _wenzi.font = [UIFont systemFontOfSize:13.0];
        _wenzi.textAlignment = NSTextAlignmentCenter;
        _wenzi.backgroundColor = [UIColor whiteColor];
    }
    return _wenzi;
}
@end
