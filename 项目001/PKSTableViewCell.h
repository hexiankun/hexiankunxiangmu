//
//  PKSTableViewCell.h
//  项目001
//
//  Created by ma c on 16/1/20.
//  Copyright (c) 2016年 观世音. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PKFragmentModel.h"
@interface PKSTableViewCell : UITableViewCell

@property (strong, nonatomic)               PKFragmentList *counterList;
@property (strong, nonatomic)               NSDictionary *heightDic;


@end
