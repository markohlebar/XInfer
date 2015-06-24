//
//  BNDBindingListViewController.m
//  BINDPlugin
//
//  Created by Marko Hlebar on 29/11/2014.
//  Copyright (c) 2014 Marko Hlebar. All rights reserved.
//

#import "XINIssueListViewController.h"
#import "NSTableView+BNDBinding.h"
#import "XINIssueCellView.h"
#import "XINIssueListViewModel.h"

@interface XINIssueListViewController () <NSTableViewDataSource, NSTableViewDelegate>
@property (weak) IBOutlet NSTableView *tableView;
@property (nonatomic, strong) BNDBinding *reloadDataBinding;
@end

@implementation XINIssueListViewController
BINDINGS(XINIssueListViewModel,
         BINDViewModel(rowViewModels, ~>, tableView.onReloadData),
         nil)

#pragma mark - NSTableViewDelegate / NSTableViewDataSource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    id <BNDTableSectionViewModel> viewModel = (id <BNDTableSectionViewModel>)self.viewModel;
    return viewModel.rowViewModels.count;
}

- (NSView *)tableView:(NSTableView *)tableView
   viewForTableColumn:(NSTableColumn *)tableColumn
                  row:(NSInteger)row {
    id <BNDTableSectionViewModel> viewModel = (id <BNDTableSectionViewModel>)self.viewModel;
    id <BNDTableRowViewModel> rowViewModel = viewModel.rowViewModels[row];
    
    NSString *className = [rowViewModel identifier];
    BNDTableViewCell *cell = [tableView makeViewWithIdentifier:className
                                                         owner:self];
    if (!cell) {
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        NSArray *topLevelObjects = nil;
        [bundle loadNibNamed:className
                       owner:self
             topLevelObjects:&topLevelObjects];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF isKindOfClass:%@", NSClassFromString(className)];
        cell = [[topLevelObjects filteredArrayUsingPredicate:predicate] firstObject];
        [cell setIdentifier:className];
    }
    cell.viewModel = rowViewModel;
    return cell;
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    return 37;
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification {
    if (self.tableView.selectedRow == -1) {
        return;
    }

    XINIssueCellView *cell = [self.tableView viewAtColumn:self.tableView.selectedColumn
                                                        row:self.tableView.selectedRow
                                            makeIfNecessary:NO];
    if ([cell isKindOfClass:[XINIssueCellView class]]) {
        [cell.textField becomeFirstResponder];
    }
    
    [self.tableView deselectRow:self.tableView.selectedRow];
}

- (void)makeCellFirstResponderAtRow:(NSInteger)row
                         afterDelay:(NSTimeInterval)delay {
    if (row < 0) {
        return;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        XINIssueCellView *cell = [self.tableView viewAtColumn:0
                                                            row:row
                                                makeIfNecessary:NO];
        if ([cell isKindOfClass:[XINIssueCellView class]]) {
            [cell.textField becomeFirstResponder];
            cell.textField.placeholderString = @"modelView.text -> model.text";
        }
    });
}

@end
