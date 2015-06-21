//
//  XINIssueCache.h
//  XInfer
//
//  Created by Marko Hlebar on 20/06/2015.
//  Copyright © 2015 Marko Hlebar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XINIssueCache : NSObject
@property (nonatomic, strong, readonly) NSArray *issues;

+ (instancetype)cacheWithIssuesDictionary:(NSDictionary *)issuesDictionary;

@end
