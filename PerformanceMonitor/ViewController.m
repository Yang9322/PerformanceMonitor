//
//  ViewController.m
//  PerformanceMonitor
//
//  Created by tanhao on 15/11/13.
//  Copyright © 2015年 Tencent. All rights reserved.
//

#import "ViewController.h"
#import "PerformanceMonitor.h"
#import "SecondViewController.h"
#include "LearnC.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
}
@property (nonatomic,copy)    NSString *testStr;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    [[PerformanceMonitor sharedInstance] start];
    
//    void **skills =  calloc(3, sizeof(char *));
//    char * learn = "learn";
//    skills[0] = learn;
//    char *piano = "piano";
//    skills[1] = piano;
//    Student *student = initStudent(23, skills);
//    
//    printf("%s\n", student->skills[0]);
//    printf("%s\n", student->skills[1]);
//    printf("%s", student->skills[2]);
    
//    
//    [self setValue:@"123" forKey:@"_testStr"];
//    
//    NSLog(@" begin---%@---end",self.testStr);


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)createMapTable{

}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    NSString *cellText = nil;
    if (indexPath.row%10 == 0)
    {
        usleep(150*1000);
        cellText = @"我需要一些时间";
    }else
    {
        cellText = [NSString stringWithFormat:@"cell%ld",indexPath.row];
    }
    
    cell.textLabel.text = cellText;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SecondViewController *secondViewController = [[SecondViewController alloc] init];
    [self presentViewController:secondViewController animated:YES completion:nil];
}

@end
