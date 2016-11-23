//
//  SZTableViewViewController.m
//  Common
//
//  Created by Summer.zhu on 16/2/9.
//  Copyright © 2016年 VIP. All rights reserved.
//

#import "SZTableViewViewController.h"
#import "SZTableCell.h"
#import "FileHelper.h"
#import <Masonry.h>

@interface SZTableViewViewController ()

@end

@implementation SZTableViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableview.backgroundColor = [UIColor clearColor];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    [self.view addSubview:_tableview];
    [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    if([_tableview respondsToSelector:@selector(setKeyboardDismissMode:)])
    {
        [self.tableview setKeyboardDismissMode:UIScrollViewKeyboardDismissModeOnDrag];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc{
    _tableview.delegate = nil;
    _tableview.dataSource = nil;
}

- (CGFloat)heightForClass:(Class)cellClass indexPath:(NSIndexPath*)indexPath
{
    SEL selector2 = @selector(sz_cellHeightWithModel:withSuperWidth:);
    
    BOOL flag2 = [((id)cellClass) respondsToSelector:selector2];
    if(flag2)
    {
        NSInteger t_currentSection  = indexPath.section;
        NSInteger t_currentRow      = indexPath.row;
        NSArray *sectionInfos       = self.dataSource[t_currentSection];
        return [cellClass sz_cellHeightWithModel:sectionInfos[t_currentRow] withSuperWidth:CGRectGetWidth(self.tableview.frame)];
    }
    else
    {
        return 0;
    }
}

- (NSString*)wm_cellIndentifyAtIndexPath:(NSIndexPath*)indexPath
{
    if(self.cellClass.count > 0)
    {
        Class cellClasses  = self.cellClass[indexPath.section];
        return NSStringFromClass(cellClasses);
    }else{
        return nil;
    }
}

#pragma mark - tableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if (!self.dataSource) {//默认为1
        return 1;
    }
    return [self.dataSource count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    NSArray *t_sectionDatas     = [self.dataSource objectAtIndex:section];
    if([t_sectionDatas isKindOfClass:[NSArray class]])
    {
        return [t_sectionDatas count];
    }
    else
    {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger t_rowNum = [tableView.dataSource tableView:tableView numberOfRowsInSection:indexPath.section];
    if(t_rowNum <= 0)
    {
        return 0;
    }
    else
    {
        if (self.cellClass.count > 0) {
            NSArray *t_cellClasses = [self cellClass];
            
            Class cellClass = t_cellClasses[indexPath.section];
            return [self heightForClass:cellClass indexPath:indexPath];
        }
        else
        {
            return 0;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[self wm_cellIndentifyAtIndexPath:indexPath]];
    
    if(!cell)
    {
        Class t_cellClass   = nil;
        if (self.cellClass.count > 0) {
            t_cellClass             = self.cellClass[indexPath.section];
        }
        else
        {
            return nil;
        }
        
        NSString *t_xibPath = [[NSBundle mainBundle] pathForResource:NSStringFromClass(t_cellClass) ofType:@"nib"];
        if(t_xibPath && [[FileHelper shareIntance] fileExistsAtPath:t_xibPath])
        {
            NSArray *cells = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(t_cellClass) owner:nil options:nil];
            if([cells count] <= 0)
            {
                cell = [[t_cellClass alloc]initWithStyle:UITableViewCellStyleDefault
                                                 reuseIdentifier:[self wm_cellIndentifyAtIndexPath:indexPath]];
            }
            else
            {
                cell = cells[0];
            }
        }
        else
        {
            cell = [[t_cellClass alloc]initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:[self wm_cellIndentifyAtIndexPath:indexPath]];
        }
    }
    
    
    if([cell respondsToSelector:@selector(setDelegate:)])
    {
        [cell performSelector:@selector(setDelegate:) withObject:self];
    }
    
    NSInteger t_currentSection  = indexPath.section;
    NSInteger t_currentRow      = indexPath.row;
    NSArray *sectionInfos       = self.dataSource[t_currentSection];
    if([sectionInfos isKindOfClass:[NSArray class]])
    {
        if([cell isKindOfClass:[SZTableCell class]])
        {
            if(t_currentRow < [sectionInfos count])
            {
                if ([cell respondsToSelector:@selector(sz_updateCellInfoWithModel:withSuperWidth:indexPath:)]) {
                    [(SZTableCell *)cell sz_updateCellInfoWithModel:sectionInfos[t_currentRow] withSuperWidth:CGRectGetWidth(self.tableview.frame) indexPath:indexPath];
                }   
            }
            else
            {
                NSAssert(0, @"数组越界");
            }
        }
        else
        {
            //TODO: other cell update
        }
    }
    else
    {
        NSAssert(0, @"datasource中的元素必须为数组");
    }
    
    
    return cell;
}

@end
