//
//  PKLeftTableView.h
//  项目001
//
//  Created by ma c on 16/1/14.
//  Copyright (c) 2016年 观世音. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PKLeftTableViewSelectRow <NSObject>
- (void)selectWhichRow:(NSInteger)row;

@end

@interface PKLeftTableView : UITableView

@property (weak, nonatomic)         id<PKLeftTableViewSelectRow>RowDelegate;


@end
