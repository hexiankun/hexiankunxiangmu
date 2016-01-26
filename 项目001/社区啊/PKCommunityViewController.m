//
//  SheQuViewController.m
//  项目001
//
//  Created by ma c on 16/1/19.
//  Copyright (c) 2016年 观世音. All rights reserved.
//

#import "PKCommunityViewController.h"

@interface PKCommunityViewController ()

@end

@implementation PKCommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self navigationItemAction];
    // Do any additional setup after loading the view.
}
-(void)navigationItemAction{
    
    UIBarButtonItem *leftBtn1 = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"菜单"] style:(UIBarButtonItemStyleDone) target:self action:@selector(leftBtnAction)];
    
    self.navigationItem.leftBarButtonItem = leftBtn1;
}
-(void)leftBtnAction{
    
    [self.sideMenuViewController presentLeftMenuViewController];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
