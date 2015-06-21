//
//  XInfer.h
//  XInfer
//
//  Created by Marko Hlebar on 20/06/2015.
//  Copyright (c) 2015 Marko Hlebar. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface XInfer : NSObject

+ (instancetype)sharedPlugin;

@property (nonatomic, strong, readonly) NSBundle* bundle;
@end