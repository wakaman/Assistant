//
//  DDGReadTask.h
//  DigitPlayer
//
//  Created by HS_macOSSierra on 12/13/17.
//  Copyright © 2017 Mavericks-Hackintosh. All rights reserved.
//

#import "DDGTask.h"


@class DDGBook;


@interface DDGReadTask : DDGTask


#if 0
@property (nullable, nonatomic, strong) DDGBook* currentBook;
@property (nullable, nonatomic, strong) NSDate* duration;
@property (nullable, nonatomic, strong) UIImage* bkImage;
@property (nullable, nonatomic, copy) NSString *bkLibrary;
@property (nullable, nonatomic, strong) NSNumber *reBorrow;
#endif


@property (nonatomic, strong) DDGBook* currentBook;
@property (nonatomic, strong) NSDate* duration;
@property (nonatomic, strong) UIImage* bkImage;
@property (nonatomic, copy) NSString *bkLibrary;
@property (nonatomic, strong) NSNumber *reBorrow;



@end
