//
//  DDGReadBook.h
//  DigitPlayer
//
//  Created by HS_macOSSierra on 12/13/17.
//  Copyright © 2017 Mavericks-Hackintosh. All rights reserved.
//


//#import "DDGTask.h"


//@interface DDGBook : DDGTask
@interface DDGBook : NSObject


#if 0
@property (nullable, nonatomic, copy) NSDecimalNumber *edition;

@property (nullable, nonatomic, copy) NSString *binding;
@property (nullable, nonatomic, copy) NSString *catalog;

@property (nullable, nonatomic, retain) UIImage *mediumImage;
@property (nullable, nonatomic, retain) UIImage *smallImage;
@property (nullable, nonatomic, retain) UIImage *largeImage;

@property (nullable, nonatomic, retain) NSData *translator;
@property (nullable, nonatomic, retain) NSData *preference;
@property (nullable, nonatomic, retain) NSData *author;
@property (nullable, nonatomic, retain) NSData *tags;

@property (nullable, nonatomic, copy) NSDecimalNumber *pages;
@property (nullable, nonatomic, copy) NSNumber *price;

@property (nullable, nonatomic, copy) NSString *publisher;
@property (nullable, nonatomic, copy) NSString *language;
@property (nullable, nonatomic, copy) NSString *summary;
@property (nullable, nonatomic, copy) NSString *isbn10;
@property (nullable, nonatomic, copy) NSString *isbn13;

@property (nullable, nonatomic, copy) NSDecimalNumber *publishBatch;
@property (nullable, nonatomic, copy) NSDate *publishDate;

@property (nullable, nonatomic, copy) NSString *originTitle;
@property (nullable, nonatomic, copy) NSString *subTitle;
@property (nullable, nonatomic, copy) NSString *title;
#endif



#if 0
@property (nullable, nonatomic, copy) NSString *publisher;
@property (nullable, nonatomic, copy) NSString *language;
@property (nullable, nonatomic, copy) NSString *binding;
@property (nullable, nonatomic, copy) NSString *catalog;
@property (nullable, nonatomic, copy) NSString *summary;
@property (nullable, nonatomic, copy) NSString *isbn10;
@property (nullable, nonatomic, copy) NSString *isbn13;

@property (nullable, nonatomic, copy) NSString *originTitle;
@property (nullable, nonatomic, copy) NSString *subTitle;
@property (nullable, nonatomic, copy) NSString *title;

@property (nullable, nonatomic) NSDate *publishDate;

@property (nullable, nonatomic) UIImage *mediumImage;
@property (nullable, nonatomic) UIImage *smallImage;
@property (nullable, nonatomic) UIImage *largeImage;

@property (nullable, nonatomic) NSData *translator;
@property (nullable, nonatomic) NSData *preference;
@property (nullable, nonatomic) NSData *author;
@property (nullable, nonatomic) NSData *tags;

@property (nullable, nonatomic) NSDecimalNumber *publishBatch;
@property (nullable, nonatomic) NSDecimalNumber *edition;
@property (nullable, nonatomic) NSDecimalNumber *pages;

//@property (nullable, nonatomic) NSDecimalNumber *price;
@property (nullable, nonatomic) NSNumber *price;
#endif



@property (nonatomic, copy) NSString *publisher;
@property (nonatomic, copy) NSString *language;
@property (nonatomic, copy) NSString *binding;
@property (nonatomic, copy) NSString *catalog;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, copy) NSString *isbn10;
@property (nonatomic, copy) NSString *isbn13;

@property (nonatomic, copy) NSString *originTitle;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, copy) NSString *title;

@property (nonatomic) NSDate *publishDate;

@property (nonatomic) UIImage *mediumImage;
@property (nonatomic) UIImage *smallImage;
@property (nonatomic) UIImage *largeImage;

@property (nonatomic) NSData *translator;
@property (nonatomic) NSData *preference;
@property (nonatomic) NSData *author;
@property (nonatomic) NSData *tags;

@property (nonatomic) NSDecimalNumber *publishBatch;
@property (nonatomic) NSDecimalNumber *edition;
@property (nonatomic) NSDecimalNumber *pages;

//@property (nullable, nonatomic) NSDecimalNumber *price;
@property (nonatomic) NSNumber *price;



- (void)save;

@end
