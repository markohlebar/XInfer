//
//  XINIssueView.m
//  XInfer
//
//  Created by Marko Hlebar on 21/06/2015.
//  Copyright © 2015 Marko Hlebar. All rights reserved.
//

#import "XINIssueView.h"

@interface XINIssueView ()
@property (nonatomic, getter=isExpanded) BOOL expanded;
@property (nonatomic) CGRect initialFrame;
@end

@implementation XINIssueView

- (instancetype)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.editable = NO;
        self.bezeled = NO;
        self.backgroundColor = [NSColor colorWithCalibratedRed:1 green:0 blue:0 alpha:0.5];
        self.textColor = [NSColor whiteColor];
        
        self.initialFrame = frame;
        
        [self setupGestureRecognizer];
    }
    return self;
}

- (void)setupGestureRecognizer {
    NSClickGestureRecognizer *gestureRecognizer = [[NSClickGestureRecognizer alloc] initWithTarget:self action:@selector(onClick:)];
    [self addGestureRecognizer:gestureRecognizer];
}

- (void)onClick:(NSClickGestureRecognizer *)gestureRecognizer {
    [self toggleExpanded];
}

- (void)toggleExpanded {
    self.expanded = !self.isExpanded;
    self.frame = self.isExpanded ? self.initialFrame : self.collapsedFrame;
}

- (NSRect)collapsedFrame {
    NSRect frame = self.initialFrame;
    frame.size.width = 10;
    return frame;
}

- (void)setText:(NSString *)text {
    _text = text;
    self.stringValue = text;
}

@end
