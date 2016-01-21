//
//  PKLandingView.h
//  项目001
//
//  Created by ma c on 16/1/15.
//  Copyright (c) 2016年 观世音. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PKLandingView : UIView<UITextFieldDelegate>
@property (strong, nonatomic)       UILabel* lineLabel1;
@property (strong, nonatomic)       UILabel* lineLabel2;
@property (strong, nonatomic)       UILabel* lineLabel3;
@property (strong, nonatomic)       UILabel* lineLabel4;

@property (strong, nonatomic)       UITextField* emailText;
@property (strong, nonatomic)       UITextField* passwordText;

@property (strong, nonatomic)       UIButton* langdingBtn;


@end
