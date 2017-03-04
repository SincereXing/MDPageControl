# MDPageControl
When I want to use the paging component of `UIScrollView`, I found that there is no suitable. So I wrote a custom paging components, it is very convenient to use very simple. Now she shared to everyone, everyone in the use of the process can also give me valuable advice, thank you for using!!!
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
###Block
```objective-c
    //点击小点block
    [self.pageControl didSelectMDPageIndexBlock:^(NSInteger pageIndex) {
        [self.scrollView scrollRectToVisible:CGRectMake(pageIndex*SCREEN_WIDTH, 0, SCREEN_WIDTH, 175.f) animated:YES];
    }];
```
###Delegate
```objective-c
    //可以设置delegate，当点击小点时，执行delegate方法
    self.pageControl.delegate = self;

//MDPageControlDelegate 方法
- (void)didSelectMDPageIndex:(NSInteger)pageIndex {
    [self.scrollView scrollRectToVisible:CGRectMake(pageIndex*SCREEN_WIDTH, 0, SCREEN_WIDTH, 175.f) animated:YES];
}
```
###Other
If you want to change the distance between points, you can modify the MDPageControl.h file
```objective-c
//distance between points
//圆点之间的间距
#define POINT_DISTANCE 10.f
```
###Point
![(分页控件展示-圆点)](https://github.com/SincereXing/MDPageControl/blob/master/MDPageControlExample/1.gif)
###Block
![(分页控件展示-块)](https://github.com/SincereXing/MDPageControl/blob/master/MDPageControlExample/2.gif)

