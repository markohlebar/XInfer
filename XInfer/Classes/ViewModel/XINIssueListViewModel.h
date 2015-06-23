//
//  XINIssueListViewModel.h
//  XInfer
//
//  Created by Marko Hlebar on 23/06/2015.
//  Copyright © 2015 Marko Hlebar. All rights reserved.
//

#import "BNDConcreteViewModel.h"

@interface XINIssueListViewModel : BNDViewModel <BNDTableSectionViewModel>
@property (nonatomic, strong) NSArray *issues;
@end
