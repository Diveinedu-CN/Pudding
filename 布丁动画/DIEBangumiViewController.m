//
//  DIEBangumiViewController.m
//  布丁动画
//
//  Created by Cheetah on 15/9/21.
//  Copyright © 2015年 diveinedu. All rights reserved.
//

#import "DIEBangumiViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "UIImage+Additions.h"
#import "WEITitleView.h"
@interface DIEBangumiViewController ()<UIPageViewControllerDataSource, UIPageViewControllerDelegate>
{
    NSArray *_pageArray;
    NSInteger _currentIndex;
    WEITitleView *_titleView;
}

@end

@implementation DIEBangumiViewController

- (instancetype)init
{
    return [self initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
}


- (instancetype)initWithTransitionStyle:(UIPageViewControllerTransitionStyle)style navigationOrientation:(UIPageViewControllerNavigationOrientation)navigationOrientation options:(NSDictionary<NSString *,id> *)options
{
    if (self = [super initWithTransitionStyle:style navigationOrientation:navigationOrientation options:options]) {
        self.dataSource = self;
        self.delegate = self;
        //init the page array
        [self createPageControllers];
        [self setViewControllers:@[[_pageArray firstObject]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }
    return  self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImage *leftItemImage;
    leftItemImage = [UIImage imageWithCGImage:[UIImage imageNamed:@"default_avatar"].CGImage scale:4 orientation:UIImageOrientationUp];
    leftItemImage = [leftItemImage add_imageWithRoundedBounds];
    leftItemImage = [leftItemImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:leftItemImage style:UIBarButtonItemStylePlain target:self action:@selector(toggleSideBar:)];
    _titleView = [[WEITitleView alloc]initWithFrame:CGRectMake(0, 0, 120, 44)];
    [_titleView addTarget:self action:@selector(titleViewValueChanged:) forControlEvents:UIControlEventValueChanged];
    _titleView.titleArray = @[@"番组",@"分类"];
    self.navigationItem.titleView = _titleView;
    
    
    //hack&search the scrollView and observe it.
    for (UIView *v in self.view.subviews) {
        if ([v isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollView = (UIScrollView *)v;
            v.superview.backgroundColor = [UIColor whiteColor];
            [scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:NULL];
        }
    }

}

- (void)toggleSideBar:(id)sender
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)titleViewValueChanged:(WEITitleView *)sender
{
    if (sender.selectedIndex == 0) {
        [self setViewControllers:@[[_pageArray objectAtIndex:sender.selectedIndex]] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    }else{
        [self setViewControllers:@[[_pageArray objectAtIndex:sender.selectedIndex]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }
}



#pragma mark  create pageviews
- (void)createPageControllers {
    UIViewController *recommendViewController = [UIViewController new];
    recommendViewController.view.backgroundColor = [UIColor redColor];
    UIViewController *categoryViewController = [UIViewController new];
    categoryViewController.view.backgroundColor = [UIColor greenColor];
    //需要显示的页面，当页面比较多的时候，可以考虑动态创建
    _pageArray = @[recommendViewController, categoryViewController];
}



#pragma mark UIPageViewController DataSource
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    //获取当前页面的位置
    if ([_pageArray indexOfObject:viewController]) {
        return _pageArray[0];
    }
    else {
        return nil;
    }
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    if ([_pageArray indexOfObject:viewController]) {
        return nil;
    }
    else {
        return _pageArray[1];
    }
}

#pragma mark UIPageViewController Delegate
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    UIViewController *currentViewController = [pageViewController.viewControllers firstObject];
    _currentIndex =  [_pageArray indexOfObject:currentViewController];
    _titleView.selectedIndex = _currentIndex;
}

//翻页位置（左、中、右）
- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation {
    return UIPageViewControllerSpineLocationMin;
}

//如果为滚动翻页，实现下面两个方法后，会显示UIPageControl指示页面
//总页数
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return 2;
}
//当前页号
- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return [_pageArray indexOfObject:pageViewController.viewControllers.firstObject];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    UIScrollView *scrollView = (UIScrollView *)object;
    
    NSValue *value = change[NSKeyValueChangeNewKey];
    CGPoint v = value.CGPointValue;
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    //UIPageViewController机制使用了三个页面，当前页处于中间
    //当显示第0页，并且继续右拖时，中断scrollView上手势的识别
    if (_currentIndex == 0 && v.x <= width) {
        scrollView.panGestureRecognizer.enabled = NO;
        scrollView.panGestureRecognizer.enabled = YES;
    }
    else {
        self.mm_drawerController.panGestureRecognizer.enabled = NO;
        self.mm_drawerController.tapGestureRecognizer.enabled = NO;
        self.mm_drawerController.panGestureRecognizer.enabled = YES;
        self.mm_drawerController.tapGestureRecognizer.enabled = YES;
    }
}
@end
