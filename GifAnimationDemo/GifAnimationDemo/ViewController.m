//
//  ViewController.m
//  GifAnimationDemo
//
//  Created by llbt on 15/12/3.
//  Copyright © 2015年 llbt. All rights reserved.
//

#import "ViewController.h"
#import "MCGIFImageView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"loadingHUDBMJF.gif" ofType:nil];
    NSData * imageData = [NSData dataWithContentsOfFile:filePath];
    MCGIFImageView *gifImageView = [[MCGIFImageView alloc] initWithFrame:CGRectMake(100, 100, 75, 110)];
    [gifImageView setData:imageData];
    [self.view addSubview:gifImageView];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
