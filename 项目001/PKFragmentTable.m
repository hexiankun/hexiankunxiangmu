//
//  PKTableView.m
//  项目001
//
//  Created by ma c on 16/1/20.
//  Copyright (c) 2016年 观世音. All rights reserved.
//

#import "PKFragmentTable.h"
#import "MJRefresh.h"
#import "MJDIYHeader.h"
#import "MJChiBaoZiHeader.h"
#import "MJChiBaoZiFooter2.h"
#import "PKSTableViewCell.h"

@interface PKFragmentTable() <UITableViewDataSource,UITableViewDelegate>


@end

@implementation PKFragmentTable

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        
        // 添加MJ刷新
        [self addRefreshControl];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

#pragma mark - 实现 add Refresh Control method
- (void)addRefreshControl {
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJChiBaoZiHeader* header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    header.lastUpdatedTimeLabel.hidden = YES;
    // 隐藏状态
    header.stateLabel.hidden = YES;
    self.mj_header.automaticallyChangeAlpha = YES;
    // 马上进入刷新状态
    self.mj_header = header;
      //   隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
      // 设置上啦加载动画
    MJChiBaoZiFooter2* footer = [MJChiBaoZiFooter2 footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    footer.stateLabel.hidden = YES;
    self.mj_footer.automaticallyChangeAlpha = YES;
    self.mj_footer = footer;
    
    
    
   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _cellHeightArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = [[_cellHeightArray [indexPath.row]valueForKey:@"cellHeight"]floatValue];
    //NSLog(@"height %lf",height);
    return height;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* cellId = @"cell";
    PKSTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[PKSTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellId];
    }
    // 传给cell的高度字典
    cell.heightDic = _cellHeightArray[indexPath.row];
    // 传给cell的内容模型
    cell.counterList = _FragmentModel[indexPath.row];
    return cell;
}

// 下拉刷新全部数据
- (void)loadMoreData {
    if (_MoreDataBlock) {
        _MoreDataBlock();
    }
}

// 上拉加载更多数据
- (void)loadNewData {
    if (_NewDataBlock) {
        _NewDataBlock();
    }
}

@end
