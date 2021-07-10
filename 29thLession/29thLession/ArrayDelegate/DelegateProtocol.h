//
//  DelegateProtocol.h
//  29thLession
//
//  Created by Иван Казанцев on 02.07.2021.
//

@protocol DelegateProtocol <NSObject>

//наш протокол содержит метод, которые принимает в себя массив типа NSArray и возвращает void
- (void)array:(NSArray *)array;

@end
