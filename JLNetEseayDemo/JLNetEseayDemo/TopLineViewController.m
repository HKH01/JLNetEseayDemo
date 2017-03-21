//
//  TopLineViewController.m
//  网易新闻
//
//  Created by xiaomama on 2017/3/16.
//  Copyright © 2017年 lm. All rights reserved.
//

#import "TopLineViewController.h"

@interface TopLineViewController ()

@end

@implementation TopLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    UILabel *lable = [[UILabel alloc] init];
    lable.center = self.view.center;
    lable.bounds = CGRectMake(0, 0, 200, 100);
    lable.text = @"我是头条";
    lable.font = [UIFont systemFontOfSize:40];
    [self.view addSubview:lable];
    
    // Do any additional setup after loading the view.

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
