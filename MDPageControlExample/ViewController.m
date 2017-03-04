//
//  ViewController.m
//  MDPageControlExample
//
//  Created by Allen Wang on 2017/3/4.
//  Copyright © 2017年 Allen Wang. All rights reserved.
//

#import "ViewController.h"
#import "MDPageControl.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 175.f)];
    [image1 setImage:[UIImage imageNamed:@"1.jpg"]];
    [self.scrollView addSubview:image1];
    
    UIImageView *image2 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, 175.f)];
    [image2 setImage:[UIImage imageNamed:@"2.jpg"]];
    [self.scrollView addSubview:image2];
    
    UIImageView *image3 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 2, 0, SCREEN_WIDTH, 175.f)];
    [image3 setImage:[UIImage imageNamed:@"3.jpg"]];
    [self.scrollView addSubview:image3];
    
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self.scrollView setShowsVerticalScrollIndicator:NO];
    [self.scrollView setPagingEnabled:YES];
    [self.scrollView setContentSize:CGSizeMake(SCREEN_WIDTH*3.f, 175.f)];
    NSLog(@"%.f", CGRectGetWidth(self.scrollView.frame));
    
    self.pageControl = [[MDPageControl alloc] initWithType:self.scrollView type:MDPointTypePoint];
    [self.pageControl setPageNum:3];
    [self.pageControl show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
