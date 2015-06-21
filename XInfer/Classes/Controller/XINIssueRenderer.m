//
//  XINIssueRenderer.m
//  XInfer
//
//  Created by Marko Hlebar on 21/06/2015.
//  Copyright © 2015 Marko Hlebar. All rights reserved.
//

#import "XINIssueRenderer.h"
#import "DVTSourceTextView.h"
#import "MHXcodeDocumentNavigator.h"
#import "XINIssue.h"
#import "XINIssueView.h"

@interface XINIssueRenderer ()
@property (nonatomic, strong) NSMutableArray *issueViews;
@end

@implementation XINIssueRenderer

+ (instancetype)rendererWithIssues:(NSArray *)issues {
    return [[self alloc] initWithIssues:issues];
}

- (instancetype)initWithIssues:(NSArray *)issues {
    self = [super init];
    if (self) {
        _issues = issues.copy;
        _issueViews = [NSMutableArray new];
    }
    return self;
}

- (void)setCurrentTextView:(id)currentTextView {
    _currentTextView = currentTextView;
    
    [self clearIssues];
    [self renderIssues];
}

- (void)clearIssues {
    [self.issueViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.issueViews removeAllObjects];
}

- (void)renderIssues {
    NSString *currentFilePath = [MHXcodeDocumentNavigator currentFilePath];
    for (XINIssue *issue in self.issues) {
        if ([issue.filePath isEqualToString:currentFilePath]) {
            CGRect paragraphRect;
            CGRect firstLineRect;

            id textView = self.currentTextView;
            
            [textView getParagraphRect:&paragraphRect
                         firstLineRect:&firstLineRect
                          forLineRange:NSMakeRange(issue.line, 1)
                          ensureLayout:YES];
            
            firstLineRect.size.width = [self.currentTextView frame].size.width;
            XINIssueView *view = [[XINIssueView alloc] initWithFrame:firstLineRect];
            view.text = issue.message;
            
            [textView addSubview:view];
            [self.issueViews addObject:view];
        }
    }
}

@end
