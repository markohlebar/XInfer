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

@implementation XINIssueListViewModel

- (NSArray *)rowViewModels {
    return self.children;
}

- (void)setIssues:(NSArray *)issues {
    _issues = issues;
    
    [self removeAllChildren];
    [issues enumerateObjectsUsingBlock:^(XINIssue *issue, NSUInteger idx, BOOL * __nonnull stop) {
        [self addChild:[XINIssueCellViewModel viewModelWithModel:issue]];
    }];
}

@end
