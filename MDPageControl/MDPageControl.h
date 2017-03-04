//
//  MDPageControl.h
//  hz17de
//
//  Created by Allen on 2016/12/24.
//  Copyright © 2016年 Allen. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MDPageControlDelegate <NSObject>
@optional
- (void)didSelectMDPageIndex:(NSInteger)pageIndex;
@end

typedef NS_OPTIONS(NSUInteger, MDPointType) {
    MDPointTypePoint    = 1 << 0,
    MDPointTypeBlock    = 1 << 1
};

typedef void (^PageHandler)(NSInteger pageIndex); //pageIndex=currentPage, from 0...

@interface MDPageControl : UIView<UIGestureRecognizerDelegate>

@property (nonatomic) NSInteger pageNum;
@property (nonatomic) NSInteger currentPage; //from 0...[0,1,2....]
@property (nonatomic, strong) NSString *normalImageName;
@property (nonatomic, strong) NSString *selectedImageName;
@property (nonatomic, copy) PageHandler pageHandlerBlock;
@property (nonatomic, weak) id<MDPageControlDelegate> delegate;
@property (nonatomic) float offsetX;
@property (nonatomic, weak) UIScrollView *scrollView;

- (instancetype)initWithPointImagesAndPadding:(UIScrollView *)scrollView normalImage:(NSString *)normalImageName selectedImage:(NSString *)selectedImageName padding:(float)padding;
- (instancetype)initWithPointImages:(UIScrollView *)scrollView normalImage:(NSString *)normalImageName selectedImage:(NSString *)selectedImageName;
- (instancetype)initWithType:(UIScrollView *)scrollView type:(MDPointType)type;
- (instancetype)initWithTypeAndBottomPadding:(UIScrollView *)scrollView type:(MDPointType)type padding:(float)padding;
- (instancetype)initWithScrollView:(UIScrollView *)scrollView;
- (instancetype)initWithBottomPadding:(UIScrollView *)scrollView padding:(float)padding;
- (void)show;
- (void)dismiss;
- (void)didSelectMDPageIndexBlock:(PageHandler)handler;

@end
