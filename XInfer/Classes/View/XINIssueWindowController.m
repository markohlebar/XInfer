//
//  XINIssueWindowController.m
//  XInfer
//
//  Created by Marko Hlebar on 23/06/2015.
//  Copyright © 2015 Marko Hlebar. All rights reserved.
//

#import "XINIssueWindowController.h"
#import "XINIssueListViewController.h"
#import "BNDViewModel.h"

@interface XINIssueWindowController ()

@end

@implementation XINIssueWindowController

+ (instancetype)presentWithViewModel:(id <BNDViewModel> )viewModel {
    XINIssueWindowController *windowController = [[XINIssueWindowController alloc] initWithWindowNibName:@"XINIssueWindowController"];
    [windowController showWindow:[NSApp mainWindow]];
    
    XINIssueListViewController *viewController = [[XINIssueListViewController alloc] initWithNibName:nil bundle:[NSBundle bundleForClass:self]];
    windowController.window.contentViewController = viewController;
    
    return windowController;
}

-(id)initWithWindowNibName:(nonnull NSString *)windowNibName {
    self = [super initWithWindowNibName:windowNibName];
    if (self) {
//        notifications = [NSMutableArray array];
//        regularExpressions = [NSMutableArray array];
    }
    return self;
}

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

@end
