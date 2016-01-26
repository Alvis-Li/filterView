//
//  filterView.m
//  test
//
//  Created by simple on 16/1/25.
//  Copyright © 2016年 levy.com. All rights reserved.
//

#import "filterView.h"
#import "CollectionViewCell.h"

#define fDeviceWidth ([UIScreen mainScreen].bounds.size.width/496.0)

@interface filterView()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong)UICollectionView *collectionView;

@property (strong,nonatomic) NSIndexPath *sortIndexPath;
@property (strong,nonatomic) NSIndexPath *typeIndexPath;
@property (strong,nonatomic) NSIndexPath *areaIndexPath;

@end

@implementation filterView

-(void)dealloc{
    _selectBlock = nil;
    _dataArray = nil;
    _sortIndexPath = nil;
    _typeIndexPath = nil;
    _areaIndexPath = nil;
    _collectionView.delegate = nil;
    _collectionView.dataSource = nil;
    _collectionView = nil;
}

-(void)setSelectBlock:(selectItem)selectBlock{
    if (selectBlock) {
        _selectBlock = selectBlock;
    }
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    
    if (!_dataArray) {
        self.dataArray = @[@{@"排序":@[@"按热度",@"按最新",@"按评分"]},@{@"类型":@[@"全部",@"全部",@"全部",@"全部",@"全部",@"全部",@"全部",@"全部",@"全部",@"全部",@"全部",@"全部",@"全部",@"全部",@"全部",@"全部",@"全部",@"全部",@"全部",@"全部",@"全部",@"全部",@"全部",@"全部",@"全部",@"全部",@"全部",@"全部",@"全部"]},@{@"地区":@[@"全部",@"全部",@"全部",@"全部",@"全部",@"全部",@"全部",@"全部",@"全部",@"全部",@"全部",@"全部",@"全部"]}];
    }
    
    self.sortIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    self.typeIndexPath = [NSIndexPath indexPathForItem:0 inSection:1];
    self.areaIndexPath = [NSIndexPath indexPathForItem:0 inSection:2];
    
    
    float AD_height = 44;//广告栏高度
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.headerReferenceSize = CGSizeMake(fDeviceWidth, AD_height);//头部
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) collectionViewLayout:flowLayout];
    
    //设置代理
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self addSubview:self.collectionView];
    
    
    self.collectionView.backgroundColor = [UIColor whiteColor];

    //注册cell和ReusableView（相当于头部）
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
}
#pragma mark -- UICollectionViewDataSource

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSDictionary *dic = self.dataArray[section];
    NSArray *values = dic.allValues.firstObject;
    return values.count;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataArray.count;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identify = [NSString stringWithFormat:@"cell"];
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    
    if (!cell) {
        NSLog(@"无法创建CollectionViewCell时打印，自定义的cell就不可能进来了。");
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = self.dataArray[indexPath.section];
    NSArray *values = dic.allValues.firstObject;
    if ([indexPath compare:_areaIndexPath] == NSOrderedSame|| [indexPath compare:_typeIndexPath]== NSOrderedSame || [indexPath compare:_sortIndexPath] == NSOrderedSame) {
        [(CollectionViewCell *)cell setCellSelected:YES];
    }else{
        [(CollectionViewCell *)cell setCellSelected:NO];
    }
    ((CollectionViewCell *)cell).text.text = [NSString stringWithFormat:@"%@",values[indexPath.item]];
}

-(void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{

    UIView *tempView = [UIView new];
    [tempView setFrame:CGRectMake(fDeviceWidth*26, 11, 6, 22)];
    tempView.backgroundColor = [UIColor redColor];
    [view addSubview:tempView];
    
    UILabel *label = [UILabel new];
    [label setFrame:CGRectMake(fDeviceWidth*26+6+5, 11, 50, 22)];
    [view addSubview:label];
    
    NSDictionary *dic = self.dataArray[indexPath.section];
    [label setText:[NSString stringWithFormat:@"%@",dic.allKeys.firstObject]];
}
//头部显示的内容
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:
                                            UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView" forIndexPath:indexPath];
    return headerView;
}

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0 ){
        return CGSizeMake(fDeviceWidth*104, fDeviceWidth*48);
    }
    return CGSizeMake(fDeviceWidth*83, fDeviceWidth*48);
}

//定义每个UICollectionView 的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, fDeviceWidth*26, 5, fDeviceWidth*26);
}
//定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *tempIndexPath;
    switch (indexPath.section) {
        case 0:
        {
            if ([indexPath compare:_areaIndexPath] != NSOrderedSame) {
                tempIndexPath = [self.sortIndexPath copy];
                self.sortIndexPath = indexPath;
                
            }
            
        }
            break;
        case 1:
        {
            if ([indexPath compare:_typeIndexPath] != NSOrderedSame) {
                
                tempIndexPath = [self.typeIndexPath copy];
                self.typeIndexPath = indexPath;
                
            }
        }
            break;
        case 2:
        {
            if ([indexPath compare:_areaIndexPath] != NSOrderedSame) {
                tempIndexPath = [self.areaIndexPath copy];
                self.areaIndexPath = indexPath;
                
                
            }
        }
            break;
            
        default:
            break;
    }
    

    [self.collectionView reloadItemsAtIndexPaths:@[indexPath,tempIndexPath]];
    if (_selectBlock) {
        self.selectBlock(indexPath);
    }
    
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
@end
