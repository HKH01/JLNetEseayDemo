//
//  HotViewController.m
//  网易新闻
//
//  Created by xiaomama on 2017/3/16.
//  Copyright © 2017年 lm. All rights reserved.
//

#import "HotViewController.h"

@interface HotViewController ()

@end

@implementation HotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];

    UILabel *lable = [[UILabel alloc] init];
    lable.center = self.view.center;
    lable.bounds = CGRectMake(0, 0, 200, 100);
    lable.text = @"我是热点";
    lable.font = [UIFont systemFontOfSize:40];
    [self.view addSubview:lable];

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
