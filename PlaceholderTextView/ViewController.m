//
//  ViewController.m
//  PlaceholderTextView
//
//  Created by gitBurning on 14/12/8.
//  Copyright (c) 2014年 gitBurning. All rights reserved.
//

#import "ViewController.h"
#import "PlaceholderTextView.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define kRGB(R,G,B)       [UIColor colorWithRed:R/255.f green:G/255.f blue:254/255.f alpha:1];



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor=kRGB(32, 152, 237);
    PlaceholderTextView *view=[[PlaceholderTextView alloc] initWithFrame:CGRectMake(10, 100, ScreenWidth -10*2, 80)];
    view.placeholder=@"请输入xxxx:";
    view.font=[UIFont boldSystemFontOfSize:14];
    view.placeholderFont=[UIFont boldSystemFontOfSize:13];
    view.layer.borderWidth=0.5;
    view.layer.borderColor=[UIColor lightGrayColor].CGColor;
    view.placeholderColor=[UIColor redColor];
    [self.view addSubview:view];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
