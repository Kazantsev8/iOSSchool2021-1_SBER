//
//  ArrayDelegate.m
//  29thLession
//
//  Created by Иван Казанцев on 02.07.2021.
//

#import <Foundation/Foundation.h>
#import "ArrayDelegate.h"

@implementation ArrayDelegate

- (void)createArray {
    
    NSArray *array = @[
        @"firststring",
        @"secondstring",
        @"thirdstring",
        @"fourthstring",
        @"fifthstring"
    ];
    
    [self.current array:array];
}

@end
