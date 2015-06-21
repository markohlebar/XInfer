//
//  XINIssue.h
//  XInfer
//
//  Created by Marko Hlebar on 20/06/2015.
//  Copyright © 2015 Marko Hlebar. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, XINIssueKind) {
    XINIssueKindWarning = 0,
    XINIssueKindError = 1,
};

typedef NS_ENUM(NSUInteger, XINIssueSeverity) {
    XINIssueSeverityLow = 0,
    XINIssueSeverityMedium = 1,
    XINIssueSeverityHigh = 2,
};

@interface XINIssue : NSObject
@property (nonatomic, copy, readonly) NSString *key;
@property (nonatomic, copy, readonly) NSString *message;
@property (nonatomic, copy, readonly) NSString *filePath;
@property (nonatomic, readonly) NSUInteger line;

@property (nonatomic, readonly) XINIssueKind kind;
@property (nonatomic, readonly) XINIssueSeverity severity;

+ (instancetype)issueWithDictionary:(NSDictionary *)dictionary;

@end
