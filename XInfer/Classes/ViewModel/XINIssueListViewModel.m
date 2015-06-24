//
//  XINIssueListViewModel.m
//  XInfer
//
//  Created by Marko Hlebar on 23/06/2015.
//  Copyright © 2015 Marko Hlebar. All rights reserved.
//

#import "XINIssueListViewModel.h"
#import "XINIssue.h"
#import "XINIssueCellViewModel.h"
#import "NSObject+NODE.h"

@interface XINIssueListViewModel ()
@property (nonatomic, strong) NSArray *rowViewModels;
@end

@implementation XINIssueListViewModel

- (void)setIssues:(NSArray *)issues {
    _issues = issues;
    
    NSMutableArray *children = [NSMutableArray new];
    [issues enumerateObjectsUsingBlock:^(XINIssue *issue, NSUInteger idx, BOOL * __nonnull stop) {
        [children addObject:[XINIssueCellViewModel viewModelWithModel:issue]];
    }];
    
    self.rowViewModels = children.copy;
}

@end
