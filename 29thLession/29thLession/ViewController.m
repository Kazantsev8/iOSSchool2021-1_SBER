//
//  ViewController.m
//  29thLession
//
//  Created by Иван Казанцев on 02.07.2021.
//

#import "ViewController.h"
#import "DelegateProtocol.h"
#import "ArrayDelegate.h"

//имплементируем наш протокол
@interface ViewController () <DelegateProtocol>

@property (nonatomic, strong) ArrayDelegate *arrayDelegate;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arrayDelegate = [ArrayDelegate new];
    self.arrayDelegate.current = self;
    
    [self.arrayDelegate createArray];
}


- (void)array:(NSArray *)array {
    //сортируем массив с помощью замыкания
    NSArray *sortedArray = [array sortedArrayUsingComparator: ^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        //считаем количество букв первого имени в одном элементе массива (сравниваемом)
        NSUInteger *obj1Number = [[obj1 componentsSeparatedByString:@"i"] count];
        //то же самое в другом
        NSUInteger *obj2Number = [[obj2 componentsSeparatedByString:@"i"] count];
        
        //при различных условиях меняем местами путем возврата значения, с которым работает функция (sortedArrayUsingComparator:)
        if (obj1Number > obj2Number) { return NSOrderedAscending; }
        else if (obj2Number > obj1Number) { return NSOrderedDescending; }
        else { return NSOrderedSame ; }
        
    }];
    //в консоль выводится отсортированный массив
    NSLog(@"%@", sortedArray);
}





@end
