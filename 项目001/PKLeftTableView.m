//
//  PKLeftTableView.m
//  项目001
//
//  Created by ma c on 16/1/14.
//  Copyright (c) 2016年 观世音. All rights reserved.
//

#import "PKLeftTableView.h"
#import "PKTableViewCell.h"
@interface PKLeftTableView() <UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic) NSArray* imageArray;
@property (strong,nonatomic) NSArray* titleArray;
@end
@implementation PKLeftTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.delegate = self;
        self.dataSource = self;
        self.bounces = NO;
        self.imageArray = @[@"首页",@"电台",@"阅读",@"社区",@"碎片",@"良品",@"设置"];
        self.titleArray = @[@"首页",@"电台",@"阅读",@"社区",@"碎片",@"良品",@"设置"];
        self.separatorStyle = NO;
        self.backgroundColor =RGB(51, 51, 51);
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *identifier = @"cell";
    PKTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[PKTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    cell.iconImage.image = [UIImage imageNamed:_imageArray[indexPath.row]];
    cell.titleLabel.text = _titleArray[indexPath.row];
  
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55.0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_RowDelegate performSelector:@selector(selectWhichRow:)]) {
        [_RowDelegate selectWhichRow:indexPath.row];
    }

    
    
    
    
    // 发送通知
//    [[NSNotificationCenter defaultCenter] postNotificationName:self.titleArray[indexPath.row] object:nil userInfo:nil];
}
@end
