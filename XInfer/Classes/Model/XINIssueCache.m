//
//  XINIssueCache.m
//  XInfer
//
//  Created by Marko Hlebar on 20/06/2015.
//  Copyright © 2015 Marko Hlebar. All rights reserved.
//

#import "XINIssueCache.h"
#import "XINIssue.h"

@interface XINIssueCache ()
@property (nonatomic, strong) NSArray *issues;
@end

@implementation XINIssueCache

+ (instancetype)cacheWithIssuesDictionary:(NSDictionary *)issuesDictionary {
    return [[self alloc] initWithIssuesDictionary:issuesDictionary];
}

- (instancetype)initWithIssuesDictionary:(NSDictionary *)issuesDictionary {
    self = [super init];
    if (self) {
        _issues = [self parseIssues:issuesDictionary];
    }
    return self;
}

- (NSArray *)parseIssues:(NSDictionary *)issuesDictionary {
    NSMutableArray *issues = [NSMutableArray new];
    for (NSDictionary *issue in issuesDictionary) {
        [issues addObject:[XINIssue issueWithDictionary:issue]];
    }
    return issues.copy;
}

@end
