//
//  BNDBindingCellView.m
//  BINDPlugin
//
//  Created by Marko Hlebar on 29/11/2014.
//  Copyright (c) 2014 Marko Hlebar. All rights reserved.
//

#import "XINIssueCellView.h"
#import "BIND.h"

@interface XINIssueCellView ()
@property (weak) IBOutlet NSTextField *textField;
@end

@implementation XINIssueCellView

- (void)awakeFromNib {
    [self loadBindings];
}

- (void)loadBindings {
    BNDBinding *binding = [BNDBinding bindingWithBIND:@"viewModel.BIND <> textField.text | BNDNilToEmptyStringTransformer"];
    self.bindings = @[binding];
}

@end
