//
//  XInfer.m
//  XInfer
//
//  Created by Marko Hlebar on 20/06/2015.
//  Copyright (c) 2015 Marko Hlebar. All rights reserved.
//

#import "XInfer.h"
#import "NSString+XCAdditions.h"
#import "MHXcodeDocumentNavigator.h"
#import "XCTarget.h"
#import "XINIssueCache.h"
#import "DVTSourceTextView.h"
#import "XINIssueRenderer.h"
#import "XINIssueWindowController.h"
#import "XINIssueListViewModel.h"

static XInfer *sharedPlugin;

@interface XInfer()

@property (nonatomic, strong, readwrite) NSBundle *bundle;
@property (nonatomic, strong) NSOperationQueue *inferQueue;
@property (nonatomic, strong) XINIssueRenderer *issueRenderer;
@property (nonatomic, strong) XINIssueWindowController *windowController;
@property (nonatomic, strong) XINIssueListViewModel *viewModel;

@end

@implementation XInfer

+ (void)pluginDidLoad:(NSBundle *)plugin
{
    static dispatch_once_t onceToken;
    NSString *currentApplicationName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
    if ([currentApplicationName isEqual:@"Xcode"]) {
        dispatch_once(&onceToken, ^{
            sharedPlugin = [[self alloc] initWithBundle:plugin];
        });
    }
}

+ (instancetype)sharedPlugin
{
    return sharedPlugin;
}

- (id)initWithBundle:(NSBundle *)plugin {
    if (self = [super init]) {
        // reference to plugin's bundle, for resource access
        self.bundle = plugin;
        
        // Create menu items, initialize UI, etc.
        dispatch_async(dispatch_get_main_queue(), ^{
            [self addMenuItem];
            [self addObservers];
            [self collectAndRenderCurrentIssues];
            
            _viewModel = [XINIssueListViewModel new];
        });
    }
    return self;
}

- (void)addObservers {
    [[NSNotificationCenter defaultCenter] addObserverForName:@"IDESourceCodeEditorDidFinishSetup"
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note) {
                                                      self.issueRenderer.currentTextView = [MHXcodeDocumentNavigator currentSourceCodeTextView];
                                                  }];
}

- (void)addMenuItem {
    NSApplication *app = NSApp;
    
    NSMenu *menu = [app mainMenu];
    // Sample Menu Item:
    NSMenuItem *menuItem = [menu itemWithTitle:@"Product"];
    if (menuItem) {
        [[menuItem submenu] addItem:[NSMenuItem separatorItem]];
        NSMenuItem *actionMenuItem = [[NSMenuItem alloc] initWithTitle:@"Infer" action:@selector(infer) keyEquivalent:@""];
        [actionMenuItem setTarget:self];
        [[menuItem submenu] addItem:actionMenuItem];
    }
}

static NSString *const kXInferXcodeBuildWorkspaceFormat = @"xcodebuild -workspace %@ -scheme %@ -configuration Debug -sdk iphonesimulator %@";
static NSString *const kXInferXcodeBuildClean = @"clean";
static NSString *const kXInferXcodeBuildBuild = @"build";

- (NSOperationQueue *)inferQueue {
    if (!_inferQueue) {
        _inferQueue = [NSOperationQueue new];
    }
    return _inferQueue;
}

// Sample Action, for menu item:
- (void)infer {
    NSString *workspace = [MHXcodeDocumentNavigator currentWorkspacePath];
    NSString *scheme = [MHXcodeDocumentNavigator currentTarget].name;
    
    NSOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        NSString *clean = [NSString stringWithFormat:kXInferXcodeBuildWorkspaceFormat, workspace, scheme, kXInferXcodeBuildClean];
        [clean xcRunAsCommandInShell:@"/bin/bash"];
        
        NSString *build = [NSString stringWithFormat:kXInferXcodeBuildWorkspaceFormat, workspace, scheme, kXInferXcodeBuildBuild];
        NSString *infer = [NSString stringWithFormat:@"infer -o \"/tmp/out\" -- %@", build];
        [infer xcRunAsCommandInShell:@"/bin/bash"];
    }];
    
    operation.completionBlock = ^{
        [self collectAndRenderCurrentIssues];
    };
    
    [self.inferQueue addOperation:operation];
    
    [self displayWindow];
}

- (void)collectAndRenderCurrentIssues {
    __block NSArray *issues = [self collectIssues];
    
    if (issues) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentIssues:issues];
        });
    }
}

- (void)displayWindow {
    self.windowController = [XINIssueWindowController presentWithViewModel:self.viewModel];
}

- (NSArray *)collectIssues {
    NSString *reportPath = @"/tmp/out/report.json";
    NSData *data = [NSData dataWithContentsOfFile:reportPath];
    if (!data) {
        return nil;
    }
    
    NSDictionary *reportDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:0
                                                                       error:nil];
    XINIssueCache *cache = [XINIssueCache cacheWithIssuesDictionary:reportDictionary];
    return cache.issues;
}

- (void)presentIssues:(NSArray *)issues {
    self.issueRenderer = [XINIssueRenderer rendererWithIssues:issues];
    self.issueRenderer.currentTextView = [MHXcodeDocumentNavigator currentSourceCodeTextView];
    
    self.viewModel.issues = issues;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
