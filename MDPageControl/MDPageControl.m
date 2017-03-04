//
//  MDPageControl.m
//  hz17de
//
//  Created by Allen on 2016/12/24.
//  Copyright © 2016年 Allen. All rights reserved.
//

#import "MDPageControl.h"

@implementation MDPageControl

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.opaque = NO;
        self.pageNum = 0;
        self.currentPage = 0;
        [self addObserver:self forKeyPath:PAGENUM options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        [self addObserver:self forKeyPath:CURRENTPAGE options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        [self addObserver:self forKeyPath:CONTENTOFFSET options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (instancetype)initWithPointImagesAndPadding:(UIScrollView *)scrollView normalImage:(NSString *)normalImageName selectedImage:(NSString *)selectedImageName padding:(float)padding {
    self.normalImageName = normalImageName;
    self.selectedImageName = selectedImageName;
    self.scrollView = scrollView;
    return [self initWithFrame:CGRectMake(0, CGRectGetHeight(scrollView.frame) - padding, CGRectGetWidth(scrollView.frame), 20.f)];
}

- (instancetype)initWithPointImages:(UIScrollView *)scrollView normalImage:(NSString *)normalImageName selectedImage:(NSString *)selectedImageName {
    return [self initWithPointImagesAndPadding:scrollView normalImage:normalImageName selectedImage:selectedImageName padding:PADDING];
}

- (instancetype)initWithType:(UIScrollView *)scrollView type:(MDPointType)type {
    if (type == MDPointTypePoint) {
        return [self initWithPointImages:scrollView normalImage:POINT_NORMAL selectedImage:POINT_SELECTED];
    } else {
        return [self initWithPointImages:scrollView normalImage:POINT_BLOCK_NORMAL selectedImage:POINT_BLOCK_SELECTED];
    }
}

- (instancetype)initWithScrollView:(UIScrollView *)scrollView {
    return [self initWithPointImages:scrollView normalImage:POINT_NORMAL selectedImage:POINT_SELECTED];
}

- (instancetype)initWithTypeAndBottomPadding:(UIScrollView *)scrollView type:(MDPointType)type padding:(float)padding {
    if (type == MDPointTypePoint) {
        return [self initWithPointImagesAndPadding:scrollView normalImage:POINT_NORMAL selectedImage:POINT_SELECTED padding:padding];
    } else {
        return [self initWithPointImagesAndPadding:scrollView normalImage:POINT_BLOCK_NORMAL selectedImage:POINT_BLOCK_SELECTED padding:padding];
    }
}

- (instancetype)initWithBottomPadding:(UIScrollView *)scrollView padding:(float)padding {
    return [self initWithPointImagesAndPadding:scrollView normalImage:POINT_NORMAL selectedImage:POINT_SELECTED padding:padding];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    float width = CGRectGetWidth(self.frame);
    float height = CGRectGetHeight(self.frame);
    
    UIImage *selectedImage = [UIImage imageNamed:self.selectedImageName];
    
    UIImage *normalImage = [UIImage imageNamed:self.normalImageName];
    
    float x = (width - (self.pageNum - 1)*normalImage.size.width - selectedImage.size.height - (self.pageNum - 1.f)*POINT_DISTANCE)/2.f;
    if ([keyPath isEqualToString:PAGENUM]) {
        if (self.pageNum < 1) {
            return;
        }
        float nextPointX = x;
        for (int i = 0; i < self.pageNum; i++) {
            UIImageView *pointImage = [[UIImageView alloc] initWithFrame:CGRectMake(nextPointX, (height - normalImage.size.height) / 2.f, normalImage.size.width, normalImage.size.height)];
            [pointImage setTag:(i + 1)*10];
            if (i == self.currentPage) {
                [pointImage setImage:[UIImage imageNamed:self.selectedImageName]];
                [pointImage setFrame:CGRectMake(nextPointX, (height - selectedImage.size.height) / 2.f, selectedImage.size.width, selectedImage.size.height)];
                nextPointX+=(selectedImage.size.width + POINT_DISTANCE);
            } else {
                [pointImage setImage:[UIImage imageNamed:self.normalImageName]];
                nextPointX+=(normalImage.size.width + POINT_DISTANCE);
            }
            UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pageAction:)];
            [pointImage addGestureRecognizer:tapGestureRecognizer];
            pointImage.multipleTouchEnabled = YES;//设置属性使得uiimageview可以响应屏幕事件
            pointImage.userInteractionEnabled = YES;
            [self addSubview:pointImage];
        }
    } else if([keyPath isEqualToString:CURRENTPAGE]) {
        NSInteger oldPage = [[change objectForKey:@"old"] integerValue];
        UIImageView *oldSelectPointView = [self viewWithTag:(10 * (oldPage + 1))];
        float oldPointX = oldSelectPointView.frame.origin.x;
        if (oldPage > self.currentPage) {
            oldPointX = oldPointX + (selectedImage.size.width - normalImage.size.width);
        }
        [oldSelectPointView setImage:[UIImage imageNamed:self.normalImageName]];
        [oldSelectPointView setFrame:CGRectMake(oldPointX, (height - normalImage.size.height) / 2.f, normalImage.size.width, normalImage.size.height)];
        
        UIImageView *currentSelectPointView = [self viewWithTag:(10 * (self.currentPage + 1))];
        float currentPointX = currentSelectPointView.frame.origin.x;
        if (oldPage < self.currentPage) {
            currentPointX = currentPointX - (selectedImage.size.width - normalImage.size.width);
        }
        [currentSelectPointView setImage:[UIImage imageNamed:self.selectedImageName]];
        [currentSelectPointView setFrame:CGRectMake(currentPointX, (height - selectedImage.size.height) / 2.f, selectedImage.size.width, selectedImage.size.height)];
    } else if([keyPath isEqualToString:CONTENTOFFSET]) {
        NSValue *point = (NSValue *)[change objectForKey:@"new"];
        CGPoint contentOffset = [point CGPointValue];
        [self setFrame:CGRectMake(contentOffset.x, self.frame.origin.y, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        int current = contentOffset.x/(self.scrollView.contentSize.width/self.pageNum);
        
        //根据scrollView 的位置对page 的当前页赋值
        self.currentPage = current;
    }
}

- (void)show {
    [self.scrollView addSubview:self];
}

- (void)dismiss {
    [self removeFromSuperview];
}

- (void)pageAction:(UIGestureRecognizer *)gestureRecognizer {
    NSInteger tag = gestureRecognizer.view.tag;
    
    if ([self.delegate respondsToSelector:@selector(didSelectMDPageIndex:)]) {
        self.currentPage = tag/10 - 1;
        [self.delegate didSelectMDPageIndex:self.currentPage];
    }
    if (self.pageHandlerBlock != nil) {
        self.currentPage = tag/10 - 1;
        self.pageHandlerBlock(self.currentPage);
    }
}

- (void)didSelectMDPageIndexBlock:(PageHandler)handler {
    self.pageHandlerBlock = handler;
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:PAGENUM];
    [self removeObserver:self forKeyPath:CURRENTPAGE];
    [self removeObserver:self forKeyPath:CONTENTOFFSET];
}


@end
