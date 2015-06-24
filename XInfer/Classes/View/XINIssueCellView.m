//
//  BNDBindingCellView.m
//  BINDPlugin
//
//  Created by Marko Hlebar on 29/11/2014.
//  Copyright (c) 2014 Marko Hlebar. All rights reserved.
//

#import "XINIssueCellView.h"
#import "BIND.h"
#import "XINIssueCellViewModel.h"

@interface XINIssueCellView ()
@property (weak) IBOutlet NSTextFieldCell *textFieldCell;
@end

@implementation XINIssueCellView
BINDINGS(XINIssueCellViewModel,
         BINDViewModel(text, ~>, textFieldCell.stringValue),
         nil)
@end
