//
//  FirstViewController.m
//  ReactiveObjCDemo
//
//  Created by bp on 2016/10/30.
//  Copyright © 2016年 PPS. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@property (nonatomic,weak) IBOutlet UITextField *name;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.name.placeholder = @"姓名";
    [self.name.rac_textSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"input (%@)",x);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
