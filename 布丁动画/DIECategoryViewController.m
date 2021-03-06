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
#import "DIECategoryModel.h"
#import "DIEDataManager.h"
#import "DIENotificationConfig.h"
#import "DIEAnimeViewController.h"
const static CGFloat kMinimumInteritemSpacing = 10.f;
const static CGFloat kMinimumLineSpacing = 0.f;
@interface DIECategoryViewController ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_categoryCollectionView;
//    NSArray<DIECategoryModel *> *_categoryInfoArray;
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
    DIEAddObserver(self, @selector(didUpdate:), kDIECategoryUpdateNotif, nil);
    [[DIEDataManager sharedManager] updateCategory];
}

- (void)dealloc {
    DIERemoveObserver(self, kDIECategoryUpdateNotif, nil);
}

- (void)didUpdate:(id)sender
{
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
            number = [[DIEDataManager sharedManager].categoriesArray count];
            break;
        default:
            number = 0;
            break;
    }
    return number;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DIECategoryCell *cell;
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    DIECategoryModel *cellModel = [DIEDataManager sharedManager].categoriesArray[indexPath.item];

    [cell.imageView sd_setImageWithURL:cellModel.url placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cell.textLabel.text = cellModel.name;
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
    NSString *categoryId = [DIEDataManager sharedManager].categoriesArray[indexPath.item].categoryId;
    DIEAnimeViewController *animeViewController = [DIEAnimeViewController new];
    animeViewController.categoryId = categoryId;
    animeViewController.title = cell.textLabel.text;
    [[DIEDataManager sharedManager].animeArray removeAllObjects];
    [self.navigationController pushViewController:animeViewController animated:YES];
}
@end
