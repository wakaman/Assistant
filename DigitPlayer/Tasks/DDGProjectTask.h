//
//  DDGProjectTask.h
//  DigitPlayer
//
//  Created by HS_macOSSierra on 12/6/17.
//  Copyright © 2017 Mavericks-Hackintosh. All rights reserved.
//


#import "DDGTask.h"


@interface DDGProjectTask : DDGTask
{
    //NSMutableArray* funcsArry2;
    //NSMutableArray* bugsArry2;
}

#if 0
@property (nullable, nonatomic, copy) NSString *projectDescrp;
@property (nullable, nonatomic, copy) NSString *duration;
@property (nullable, nonatomic, strong) NSMutableArray* funcsArry;
@property (nullable, nonatomic, strong) NSMutableArray* bugsArry;

- (void)addFunction:(NSString *_Nullable)newFunc;
- (void)addBug:(NSString *_Nullable)newBug;

- (NSArray *_Nullable)allFuns;
- (NSArray *_Nullable)allBugs;
#endif


@property (nonatomic, copy) NSString *projectDescrp;
@property (nonatomic, copy) NSString *duration;
@property (nonatomic, strong) NSMutableArray* funcsArry;
@property (nonatomic, strong) NSMutableArray* bugsArry;

- (void)addFunction:(NSString *)newFunc;
- (void)addBug:(NSString *)newBug;

- (NSArray *)allFuns;
- (NSArray *)allBugs;


@end
