//
//  SecondViewController.m
//  PerformanceMonitor
//
//  Created by He yang on 2016/12/20.
//  Copyright © 2016年 Tencent. All rights reserved.
//

#import "SecondViewController.h"
#import "TestView.h"
#import "PerformanceMonitor.h"
@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TestView *testView = [[TestView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    testView.backgroundColor = [UIColor redColor];
    [self.view addSubview:testView];
    [[PerformanceMonitor sharedInstance].mapTable setObject:testView forKey:@"testView"];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)click:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)dealloc{
    NSLog(@" begin---%@---end",@"SecondViewController is deallocted" );

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
