//
//  WEITitleVIew.m
//  puTing
//
//  Created by apple on 15/9/22.
//  Copyright (c) 2015年 Weizh. All rights reserved.
//

#import "WEITitleView.h"

@interface WEITitleView ()
{
    NSMutableArray *_titleButtonArray;
    NSMutableArray *_titleViewArray;
}
@end

@implementation WEITitleView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _titleButtonArray = [NSMutableArray array];
        _titleViewArray = [NSMutableArray array];
    }
    return self;
}

- (void)setTitleArray:(NSArray *)titleArray{
    _titleArray = titleArray;
    
    for (UIButton *button in _titleButtonArray) {
        [button removeFromSuperview];
    }
    [_titleButtonArray removeAllObjects];
    for (UIView *view in _titleViewArray) {
        [view removeFromSuperview];
    }
    [_titleViewArray removeAllObjects];
    
    CGFloat iWidth = self.frame.size.width/titleArray.count;
    CGFloat buttonHeight = self.frame.size.height - 5;
    CGFloat lineHeight = 5;
    for (int i=0; i<titleArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(iWidth*i, 0, iWidth, buttonHeight);
        [button setTitle:_titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        button.tag = 1000+i;
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [_titleButtonArray addObject:button];
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(iWidth*i, buttonHeight, iWidth, lineHeight)];
        lineView.backgroundColor = [UIColor clearColor];
        [self addSubview:lineView];
        [_titleViewArray addObject:lineView];
    }
    self.selectedIndex = 0;
}

- (void)buttonClicked:(UIButton *)sender{
    self.selectedIndex= sender.tag-1000;
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)setSelectedIndex:(NSUInteger)selectIndex{
    _selectedIndex = selectIndex;
    for (UIButton *button in _titleButtonArray) {
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    for (UIView *view in _titleViewArray) {
        view.backgroundColor = [UIColor clearColor];
    }
    UIButton *button = _titleButtonArray[_selectedIndex];
    UIView *view = _titleViewArray[_selectedIndex];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    view.backgroundColor = [UIColor orangeColor];

}

@end














