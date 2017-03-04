//
//  ViewController.m
//  MDPageControlExample
//
//  Created by Allen Wang on 2017/3/4.
//  Copyright © 2017年 Allen Wang. All rights reserved.
//

#import "ViewController.h"

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
    
    //选中的图片是点
//    self.pageControl = [[MDPageControl alloc] initWithType:self.scrollView type:MDPointTypePoint];
    //选中的图片是块
    self.pageControl = [[MDPageControl alloc] initWithType:self.scrollView type:MDPointTypeBlock];
    //默认选中的图片是点
//    self.pageControl = [[MDPageControl alloc] initWithScrollView:self.scrollView];
    //默认选中的图片是点, 并且设置pageControllView离scrollView底部的距离，默认为25
//    self.pageControl = [[MDPageControl alloc] initWithBottomPadding:self.scrollView padding:25];
    //设置选中的图片是点或者块, 并且设置pageControllView离scrollView底部的距离，默认为25
//    self.pageControl = [[MDPageControl alloc] initWithTypeAndBottomPadding:self.scrollView type:MDPointTypeBlock padding:25];
    //设置自定义图片，图片大小可参照我提供的图片大小 2x(14x14) 1x(7x7) 3x(21x21)
//    self.pageControl = [[MDPageControl alloc] initWithPointImages:self.scrollView normalImage:@"point_normal" selectedImage:@"point_selected"];
    //设置自定义图片，并设置pageControllView离scrollView底部的距离，默认为25
//    self.pageControl = [[MDPageControl alloc] initWithPointImagesAndPadding:self.scrollView normalImage:@"point_normal" selectedImage:@"point_selected" padding:25];
    //设置分页数
    [self.pageControl setPageNum:3];
    //显示pageControllView
    [self.pageControl show];
    
    //点击小点block
    [self.pageControl didSelectMDPageIndexBlock:^(NSInteger pageIndex) {
        [self.scrollView scrollRectToVisible:CGRectMake(pageIndex*SCREEN_WIDTH, 0, SCREEN_WIDTH, 175.f) animated:YES];
    }];
    
    //也可以设置delegate，当点击小点时，执行delegate方法
//    self.pageControl.delegate = self;
}

//MDPageControlDelegate 方法
//- (void)didSelectMDPageIndex:(NSInteger)pageIndex {
//    [self.scrollView scrollRectToVisible:CGRectMake(pageIndex*SCREEN_WIDTH, 0, SCREEN_WIDTH, 175.f) animated:YES];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
