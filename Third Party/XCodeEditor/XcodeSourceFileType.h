////////////////////////////////////////////////////////////////////////////////
//
//  JASPER BLUES
//  Copyright 2012 Jasper Blues
//  All Rights Reserved.
//
//  NOTICE: Jasper Blues permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////

#import <Foundation/Foundation.h>

typedef enum {
    FileTypeNil,             // Unknown filetype 
    Framework,               // .framework 
    PropertyList,            // .plist 
    SourceCodeHeader,        // .h     
    SourceCodeObjC,          // .m     
    SourceCodeObjCPlusPlus,  // .mm
    SourceCodeCPlusPlus,     // .cpp
    XibFile,                 // .xib   
    ImageResourcePNG,        // .png
    Bundle,                  // .bundle  .octet 
    Archive,                 // .a files
    HTML,                    // HTML file 
    TEXT,                    // Some text file 
    XcodeProject             // .xcodeproj
} XcodeSourceFileType;

@interface NSString (XCodeFileType)

+ (NSString*) stringFromSourceFileType:(XcodeSourceFileType)type;

- (XcodeSourceFileType) asSourceFileType;

@end