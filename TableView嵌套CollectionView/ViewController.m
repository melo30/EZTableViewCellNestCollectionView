//
//  ViewController.m
//  TableView嵌套CollectionView
//
//  Created by melo on 2020/5/4.
//  Copyright © 2020 陈诚. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "TestTableViewCell.h"
@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TestTableViewCell class])];
    cell.dataModel = self.dataSource;
    return cell;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableView registerClass:[TestTableViewCell class] forCellReuseIdentifier:NSStringFromClass([TestTableViewCell class])];
    }
    return _tableView;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] initWithObjects:@"测试一下",@"测试二下",@"测试三下",@"测试四下",@"测试五下", nil];
    }
    return _dataSource;
}
@end
