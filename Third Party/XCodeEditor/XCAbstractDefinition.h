////////////////////////////////////////////////////////////////////////////////
//
//  JASPER BLUES
//  Copyright 2012 - 2013 Jasper Blues
//  All Rights Reserved.
//
//  NOTICE: Jasper Blues permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////


#import <Foundation/Foundation.h>

typedef enum
{

    /**
    * Creates the reference in the project and writes the contents to disk. If a file already exists at the specified
    * location, its contents will be updated.
    */
            FileOperationStyleOverwrite,

    /**
    * Creates the reference in the project. If a file already exists at the specified location, the contents will not
    * be updated.
    */
            FileOperationStyleAcceptExisting,

    /**
    * Creates the reference in the project, but does not write to disk. The filesystem is expected to be updated
     * through some other means.
    */
            FileOperationStyleReferenceOnly
} XcodeFileOperationStyle;

/**
* Holds properties to all types of resource that can be added to an Xcode project.
*/
@interface XCAbstractDefinition : NSObject
{
    XcodeFileOperationStyle _fileOperationStyle;
}

@property(nonatomic) XcodeFileOperationStyle fileOperationStyle;


@end