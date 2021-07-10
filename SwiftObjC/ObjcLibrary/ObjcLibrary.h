//
//  ObjcLibrary.h
//  ObjcLibrary
//
//  Created by Иван Казанцев on 05.07.2021.
//

#import <Foundation/Foundation.h>
#import "SecondObjcLibrary.h"


@interface ObjcLibrary : NSObject

@property (strong, nonatomic, readonly) NSString *string;
@property (strong, nonatomic, readonly) SecondObjcLibrary *anotherLib;

@end
