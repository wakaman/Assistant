//
//  DDGReadBook.m
//  DigitPlayer
//
//  Created by HS_macOSSierra on 12/13/17.
//  Copyright © 2017 Mavericks-Hackintosh. All rights reserved.
//

#import "DDGBook.h"

@implementation DDGBook



@synthesize language = _language;
@synthesize binding = _binding;
@synthesize catalog = _catalog;
@synthesize summary = _summary;
@synthesize isbn10 = _isbn10;
@synthesize isbn13 = _isbn13;

@synthesize originTitle = _originTitle;
@synthesize subTitle = _subTitle;
@synthesize title = _title;

@synthesize mediumImage = _mediumImage;
@synthesize smallImage = _smallImage;
@synthesize largeImage = _largeImage;
@synthesize translator = _translator;
@synthesize preference = _preference;
@synthesize author = _author;
@synthesize tags = _tags;

@synthesize edition = _edition;
@synthesize pages = _pages;
@synthesize price = _price;

@synthesize publishBatch = _publisherBatch;
@synthesize publishDate = _publishDate;
@synthesize publisher = _publisher;

- (void)save;
{
    NSLog(@"Save it!");
}

@end
