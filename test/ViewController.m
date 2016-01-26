//
//  ViewController.m
//  代码创建UICollectionView
//
//  Created by 陈家庆 on 15-2-6.
//  Copyright (c) 2015年 shikee_Chan. All rights reserved.
//

#import "ViewController.h"
#import "filterView.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];//不能放init处
    
    filterView *filter = [[filterView alloc] init];
    [filter setFrame:CGRectMake(50, 0, CGRectGetWidth(self.view.frame)-50, CGRectGetHeight(self.view.frame))];
    filter.selectBlock = ^(NSIndexPath *indexPath){
        NSLog(@"%@",indexPath);
    };
    [self.view addSubview:filter];
    
}

@end
