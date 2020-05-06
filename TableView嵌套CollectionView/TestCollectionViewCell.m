//
//  TestCollectionViewCell.m
//  TableView嵌套CollectionView
//
//  Created by melo on 2020/5/4.
//  Copyright © 2020 陈诚. All rights reserved.
//

#import "TestCollectionViewCell.h"
#import "Masonry.h"
@interface TestCollectionViewCell ()

@end

@implementation TestCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    _label = [UILabel new];
    _label.textColor = [UIColor blackColor];
    _label.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_label];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
}

@end
