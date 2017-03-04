# MDPageControl
## Usage
```objective-c
//选中的图片是点
    self.pageControl = [[MDPageControl alloc] initWithType:self.scrollView type:MDPointTypePoint];
    //选中的图片是块
//    self.pageControl = [[MDPageControl alloc] initWithType:self.scrollView type:MDPointTypeBlock];
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
```
```objective-c
//点击小点block
    [self.pageControl didSelectMDPageIndexBlock:^(NSInteger pageIndex) {
        [self.scrollView scrollRectToVisible:CGRectMake(pageIndex*SCREEN_WIDTH, 0, SCREEN_WIDTH, 175.f) animated:YES];
    }];
    
    //也可以设置delegate，当点击小点时，执行delegate方法
    self.pageControl.delegate = self;
```
```objective-c
//MDPageControlDelegate 方法
- (void)didSelectMDPageIndex:(NSInteger)pageIndex {
    [self.scrollView scrollRectToVisible:CGRectMake(pageIndex*SCREEN_WIDTH, 0, SCREEN_WIDTH, 175.f) animated:YES];
}
```
