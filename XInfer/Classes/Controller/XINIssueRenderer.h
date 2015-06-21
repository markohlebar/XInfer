//
//  XINIssueRenderer.h
//  XInfer
//
//  Created by Marko Hlebar on 21/06/2015.
//  Copyright © 2015 Marko Hlebar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XINIssueRenderer : NSObject
@property (nonatomic, strong) id currentTextView;
@property (nonatomic, copy, readonly) NSArray *issues;

+ (instancetype)rendererWithIssues:(NSArray *)issues;

@end
