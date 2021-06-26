//
//  DDGDBExecutor.h
//  DigitPlayer
//
//  Created by Hackintosh-Cpp on 12/18/17.
//  Copyright © 2017 Mavericks-Hackintosh. All rights reserved.
//

#import <Foundation/Foundation.h>


@class DDGProjectTask;
@class DDGBook;
@class DDGTask;


@interface DDGDBExecutor : NSObject


+ (DDGDBExecutor *)sharedExecutor;


- (NSDictionary *)getTasks;
- (NSArray *)getDBBooks;


- (bool)saveTask:(DDGTask *)task;
- (bool)saveBook:(DDGBook *)book;

- (bool)isBookExistIsbn10:(NSString *)strIsbn10 andIsbn13:(NSString *)strIsbn13;


- (void)extraceTask;

@end
