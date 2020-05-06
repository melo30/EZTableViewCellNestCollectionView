//
//  TestTableViewCell.m
//  TableView嵌套CollectionView
//
//  Created by melo on 2020/5/4.
//  Copyright © 2020 陈诚. All rights reserved.
//

#import "TestTableViewCell.h"
#import "Masonry.h"
#import "TestCollectionViewCell.h"
@interface TestTableViewCell () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation TestTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor redColor];
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    [self.contentView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.left.top.equalTo(@0);//用collectionView把tableViewCell撑起来
//        make.height.mas_equalTo(@1).priorityLow();//设置一个高度，以便赋值后更新。。。其实这句不要也行
    }];
}

- (void)setDataModel:(NSArray *)dataModel {
    _dataModel = dataModel;
    
    [self.collectionView reloadData];
    [self.collectionView layoutIfNeeded];
    
#pragma mark - 方式1：直接计算高度然后更新collectionView的高度
    //1.这一行是点睛之笔，经测试，在iphone6 plus 以上如果不加这行的话，高度就会偏大一些。
    self.collectionView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44);
    
    //2.获取collectionview高度
    CGFloat height = self.collectionView.collectionViewLayout.collectionViewContentSize.height;
    NSLog(@"height = %lf",height);
    
    //3.更新collectionView
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
         make.height.mas_equalTo(@(height));

    }];
}

#pragma mark - 方式2：通过重写systemLayoutSizeFittingSize方法计算此时cell的高度并返回
//- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority
//{
//    // 1.同样，这一句很关键，否则计算就不准确
//    self.collectionView.frame = CGRectMake(0, 0, targetSize.width, 44);
//
//    // 2.获取collectionview高度
//    CGSize collectionSize = self.collectionView.collectionViewLayout.collectionViewContentSize;
//    CGFloat cotentViewH = collectionSize.height;
//
//    // 3.返回当前cell的高度
//    return CGSizeMake([UIScreen mainScreen].bounds.size.width, cotentViewH);
//}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataModel.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TestCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TestCollectionViewCell class]) forIndexPath:indexPath];
    cell.label.text = _dataModel[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake([UIScreen mainScreen].bounds.size.width / 2, 50);
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[TestCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([TestCollectionViewCell class])];
    }
    return _collectionView;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
