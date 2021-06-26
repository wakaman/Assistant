//
//  DDGProjectTask.m
//  DigitPlayer
//
//  Created by HS_macOSSierra on 12/6/17.
//  Copyright © 2017 Mavericks-Hackintosh. All rights reserved.
//

#import "DDGProjectTask.h"

@implementation DDGProjectTask

//@synthesize projectDescrp;
//@synthesize duration;
//@synthesize funcsArry;
//@synthesize funcsArry;
//@synthesize bugsArry;

@synthesize projectDescrp = _projectDescrp;
@synthesize duration = _duration;
@synthesize funcsArry = _funcsArry;
@synthesize bugsArry = _bugsArry;


- (id)init
{
    self = [super init];
    if (self) {        
        //_funcsArry = nil;
        //_bugsArry = nil;
    }
   
    return self;
}

- (void)addFunction:(NSString *)newFunc
{
    if (nil == newFunc) {
        return;
    }
    
    if (nil == _funcsArry) {
        _funcsArry = [NSMutableArray new];
    }
    
    //if (newFunc == nil) {
        // throw exception
    //}
    
    [_funcsArry addObject:newFunc];
}

- (void)addBug:(NSString *)newBug
{
    if (nil == _bugsArry) {
        _bugsArry = [NSMutableArray new];
    }
    
    if (nil == _bugsArry) {
        // throw exception
    }
    
    [_bugsArry addObject:newBug];
}

- (NSArray *)allFuns
{
    return _funcsArry;
}

- (NSArray *)allBugs
{
    return _bugsArry;
}
@end
