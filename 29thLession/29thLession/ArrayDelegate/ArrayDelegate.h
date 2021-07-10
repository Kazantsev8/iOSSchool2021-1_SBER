//
//  ArrayDelegate.h
//  29thLession
//
//  Created by Иван Казанцев on 02.07.2021.
//

#import <Foundation/Foundation.h>
#import "DelegateProtocol.h"

//создаем header для класса ArrayDelegate
@interface ArrayDelegate : NSObject

//делаем свойство arrayDelegate тип DelegateProtocol. Так как свойство типа протокола, то id.
@property (nonatomic, weak) id<DelegateProtocol> current;

//функция 
- (void)createArray;

@end
