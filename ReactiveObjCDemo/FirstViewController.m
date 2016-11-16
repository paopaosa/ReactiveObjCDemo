//
//  FirstViewController.m
//  ReactiveObjCDemo
//
//  Created by bp on 2016/10/30.
//  Copyright © 2016年 PPS. All rights reserved.
//

#import "FirstViewController.h"

@interface ViewModel : NSObject

@property (nonatomic,strong) NSMutableArray *a;

@end

@implementation ViewModel

@end

@interface FirstViewController ()

@property (nonatomic,weak) IBOutlet UITextField *name;
@property (nonatomic,strong) NSMutableArray *children;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    @weakify(self);
    self.children = [[NSMutableArray alloc] init];
    self.name.placeholder = @"姓名";
    [self.name.rac_textSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"input (%@)",x);
        @strongify(self);
        [self.children addObject:x];
    }];
    
    NSMutableArray *contents = [self mutableArrayValueForKey:@keypath(self, children)];
    [RACObserve(self, children) subscribeNext:^(id  _Nullable x) {
        NSLog(@"children changed!");
    }];
    
    [self.children addObject:@""];
//
    [self willChangeValueForKey:@"children"];
    [self.children addObject:@1];
    [self didChangeValueForKey:@"children"];
    [contents addObject:@1];

    [RACObserve(self, children) subscribeNext:^(id  _Nullable x) {
        NSLog(@"children is %@", self.children);
    }];
    
    ViewModel *vm = [ViewModel new];
    vm.a = [@[] mutableCopy];
    RACSignal *changeSignal = [vm rac_valuesAndChangesForKeyPath:@keypath(vm,a) options: NSKeyValueObservingOptionNew| NSKeyValueObservingOptionOld observer:nil];
    [changeSignal subscribeNext:^(RACTuple *x){
        //        NSArray *wholeArray = x.first;
        //        NSDictionary *changeDictionary = x.second;
        NSLog(@"a changed...");
    }];
    [vm.a addObject:@2];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
