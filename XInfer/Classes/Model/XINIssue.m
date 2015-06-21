//
//  XINIssue.m
//  XInfer
//
//  Created by Marko Hlebar on 20/06/2015.
//  Copyright © 2015 Marko Hlebar. All rights reserved.
//

#import "XINIssue.h"

/*
 {
 "key": "248289310",
 "kind": "ERROR",
 "hash": "1027637581",
 "severity": "HIGH",
 "trace": "{\"trace\":[{\"level\":0,\"filename\":\"/Users/mhlebar/Downloads/infer-osx-v0.1.0/infer/examples/ios_hello/HelloWorldApp/AppDelegate.m\",\"line_number\":19,\"description\":\"start of procedure memory_leak_bug\",\"node_tags\":[{\"tag\":\"kind\",\"value\":\"procedure_start\"},{\"tag\":\"name\",\"value\":\"AppDelegate_memory_leak_bug\"},{\"tag\":\"name_id\",\"value\":\"AppDelegate_memory_leak_bug\"}]},{\"level\":0,\"filename\":\"/Users/mhlebar/Downloads/infer-osx-v0.1.0/infer/examples/ios_hello/HelloWorldApp/AppDelegate.m\",\"line_number\":20,\"description\":\"\",\"node_tags\":[]}]}",
 "advice": "",
 "procedure_id": "AppDelegate_memory_leak_bug",
 "bug_id": "3",
 "always_report": "false",
 "file": "/Users/mhlebar/Downloads/infer-osx-v0.1.0/infer/examples/ios_hello/HelloWorldApp/AppDelegate.m",
 "qualifier_tags": "<qualifier_tags><line>20</line><call_procedure>CGPathCreateWithRect()</call_procedure><call_line>20</call_line><value>shadowPath</value><bucket>[CF]</bucket></qualifier_tags>",
 "line": "20",
 "type": "MEMORY_LEAK",
 "class": "PROVER",
 "procedure": "AppDelegate_memory_leak_bug",
 "qualifier": "[CF] memory dynamically allocated to shadowPath by call to CGPathCreateWithRect() at line 20, column 28 is not reachable after line 20, column 5"
 },
 
 */

@implementation XINIssue

+ (instancetype)issueWithDictionary:(NSDictionary *)dictionary {
    return [[self alloc] initWithDictionary:dictionary];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _key = [dictionary[@"key"] copy];
        _message = [dictionary[@"qualifier"] copy];
        _filePath = [dictionary[@"file"] copy];
        _line = [dictionary[@"line"] integerValue];
    }
    return self;
}

@end
