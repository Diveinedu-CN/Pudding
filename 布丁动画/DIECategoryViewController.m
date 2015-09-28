//
//  DIECategoryViewController.m
//  布丁动画
//
//  Created by Cheetah on 15/9/28.
//  Copyright © 2015年 diveinedu. All rights reserved.
//

#import "DIECategoryViewController.h"
#import "DIECategoryCell.h"
#import "UIImageView+WebCache.h"
const static CGFloat kMinimumInteritemSpacing = 10.f;
const static CGFloat kMinimumLineSpacing = 0.f;
@interface DIECategoryViewController ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_categoryCollectionView;
    NSArray *_categoryInfoArray;
}
@end

@implementation DIECategoryViewController
- (void)viewDidLoad
{
    [super viewDidLoad];

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumInteritemSpacing = kMinimumInteritemSpacing;
    flowLayout.minimumLineSpacing = kMinimumLineSpacing;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;

    _categoryCollectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    _categoryCollectionView.backgroundColor = [UIColor whiteColor];

    [_categoryCollectionView registerClass:[DIECategoryCell class] forCellWithReuseIdentifier:@"cell"];
    [_categoryCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [_categoryCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    
    _categoryCollectionView.dataSource = self;
    _categoryCollectionView.delegate = self;
    
    
    [self.view addSubview:_categoryCollectionView];
    [self parseCategoryInfo];
}

#pragma mark parse category infomation array

- (void)parseCategoryInfo
{
    NSData *categoryData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"category" ofType:@"json"]];
    id info = [NSJSONSerialization JSONObjectWithData:categoryData options:NSJSONReadingAllowFragments error:nil];
    if ([info isKindOfClass:[NSArray class]]) {
        _categoryInfoArray = info;
    }else{
        _categoryInfoArray = @[];
    }
    [_categoryCollectionView reloadData];
}


#pragma mark UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger number;
    switch (section) {
        case 0:
            number = [_categoryInfoArray count];
            break;
        default:
            number = 4;
            break;
    }
    return number;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DIECategoryCell *cell;
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    NSDictionary *cellInfo = _categoryInfoArray[indexPath.item];
    NSURL *imgURL = [NSURL URLWithString:cellInfo[@"image"][@"url"]];
    [cell.imageView sd_setImageWithURL:imgURL placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cell.textLabel.text = cellInfo[@"name"];
    return cell;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        //应该子类化header的,我这里偷个懒,尽量还是自定义
        [reusableView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        CGSize size = reusableView.bounds.size;
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height/2)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"少年!想要看下面是要付出代价的哟><";
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"把布丁分享给小伙伴就能解锁全部分类啦~" forState:UIControlStateNormal];
        button.backgroundColor = [UIColor orangeColor];
        button.frame = CGRectMake(10, size.height/2, size.width-20, size.height/2);
        button.layer.cornerRadius = 5;
        button.layer.masksToBounds = YES;
        [reusableView addSubview:label];
        [reusableView addSubview:button];
        
        
    }
    else {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        //应该子类化footer的，我这里偷个懒
        [reusableView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        CGSize size = reusableView.bounds.size;
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height/2)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"————  布丁动画  ————";
        label.textColor = [UIColor grayColor];
        [reusableView addSubview:label];

    }
    if (indexPath.section == 0) {
        reusableView.frame = CGRectZero;
    }
    return reusableView;
}



#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = self.view.bounds.size;
    CGFloat cellWidth = size.width/3 - kMinimumInteritemSpacing*2;
    return CGSizeMake(cellWidth, cellWidth*4/3);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeZero;
    }else
    {
        return  CGSizeMake(100, 100);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeZero;
    }else
    {
        return  CGSizeMake(100, 50);
    }
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        return UIEdgeInsetsMake(74, 10, 0, 10);;
    }else
    {
        return UIEdgeInsetsMake(10, 10, 10, 10);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    DIECategoryCell *cell = (DIECategoryCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NSLog(@"点击了:%@",cell.textLabel.text);
}
@end
