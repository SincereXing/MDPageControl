//
//  ViewController.h
//  MDPageControlExample
//
//  Created by Allen Wang on 2017/3/4.
//  Copyright © 2017年 Allen Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDPageControl.h"

@interface ViewController : UIViewController<UIScrollViewDelegate>
//@interface ViewController : UIViewController<UIScrollViewDelegate, MDPageControlDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) MDPageControl *pageControl;


@end

