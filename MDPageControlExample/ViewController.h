//
//  ViewController.h
//  MDPageControlExample
//
//  Created by Allen Wang on 2017/3/4.
//  Copyright © 2017年 Allen Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MDPageControl;

@interface ViewController : UIViewController<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) MDPageControl *pageControl;


@end

