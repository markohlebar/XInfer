//
//  XINIssueWindowController.h
//  XInfer
//
//  Created by Marko Hlebar on 23/06/2015.
//  Copyright © 2015 Marko Hlebar. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol BNDViewModel;
@interface XINIssueWindowController : NSWindowController

+ (instancetype)presentWithViewModel:(id <BNDViewModel> )viewModel;

@end
