//
//  ViewController.m
//  JXCustomAlertView
//
//  Created by mac on 17/7/19.
//  Copyright © 2017年 JXIcon. All rights reserved.
//

#import "ViewController.h"
#import "JXCustomAlertView.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, assign) NSInteger selectCellIndex;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:0.8f green:0.8f blue:0.8f alpha:1.0f]];
    
    UIButton *launchDialog = [UIButton buttonWithType:UIButtonTypeCustom];
    [launchDialog setFrame:CGRectMake(10, 30, self.view.bounds.size.width-20, 50)];
    [launchDialog addTarget:self action:@selector(launchDialog:) forControlEvents:UIControlEventTouchDown];
    [launchDialog setTitle:@"showAlertView" forState:UIControlStateNormal];
    [launchDialog setBackgroundColor:[UIColor whiteColor]];
    [launchDialog setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [launchDialog.layer setBorderWidth:0];
    [launchDialog.layer setCornerRadius:5];
    [self.view addSubview:launchDialog];
    
    _selectCellIndex = -1;
}

- (IBAction)launchDialog:(id)sender
{
    
    JXCustomAlertView *alertView = [[JXCustomAlertView alloc] init];
    
    [alertView setContainerView:[self createDemoView]];
    
    
    [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"关闭", @"确定", nil]];
    alertView.buttonTitleColors = @[[UIColor redColor]];
    
    alertView.closeOnTouchUpOutside = YES;
    alertView.useMotionEffects = YES;
    
    
    
    [alertView setOnButtonTouchUpInside:^(JXCustomAlertView *alertView, int buttonIndex) {
        NSLog(@"点击button == %d  alertView == %d", buttonIndex, (int)[alertView tag]);
        [alertView close];
    }];


    [alertView show];
}


- (UIView *)createDemoView
{
    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 290, 200)];
    
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:demoView.bounds style:UITableViewStylePlain];
    
    tableView.layer.cornerRadius = 7;
    tableView.layer.masksToBounds = YES;
    tableView.delegate = self;
    tableView.dataSource = self;
    [demoView addSubview:tableView];
    
    
    return demoView;
    
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"row == %ld",indexPath.row];
    
     indexPath.row == _selectCellIndex ? (cell.accessoryType =UITableViewCellAccessoryCheckmark) : (cell.accessoryType = UITableViewCellAccessoryNone);
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _selectCellIndex = indexPath.row;
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType =UITableViewCellAccessoryCheckmark;
    
}


-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType =UITableViewCellAccessoryNone ;
    
}

@end
