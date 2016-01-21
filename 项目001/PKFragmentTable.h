//
//  PKTableView.h
//  项目001
//
//  Created by ma c on 16/1/20.
//  Copyright (c) 2016年 观世音. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^loadNewDataBlock)(); // 加载新数据
typedef void (^loadMoreDataBlock)(); // 加载更多数据

@interface PKFragmentTable : UITableView

@property (strong, nonatomic)       NSArray* FragmentModel; // 碎片数据
@property (strong, nonatomic)       NSArray* cellHeightArray; // 高度数组
@property (copy, nonatomic)         loadNewDataBlock NewDataBlock;
@property (copy, nonatomic)         loadMoreDataBlock MoreDataBlock;

@end
