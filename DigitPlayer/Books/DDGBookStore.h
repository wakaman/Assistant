//
//  DDGBookRefStore.h
//  DigitPlayer
//
//  Created by Hackintosh-SnowSquirrel on 3/22/17.
//  Copyright (c) 2017 Mavericks-Hackintosh. All rights reserved.
//

#import <Foundation/Foundation.h>


//@class NSManagedObjectContext;
//@class NSManagedObjectModel;
//@class DDGReadBook;

@class DDGBook;


@interface DDGBookStore : NSObject
{
}


+ (DDGBookStore *)sharedStore;


- (void)moveItemAtIndex:(NSInteger)from toIndex:(NSInteger)to;
- (void)removeBook:(DDGBook *)bookItem;

- (DDGBook *)searchRBook:(NSString *)bookISBN;
- (bool)searchItem:(DDGBook *)bookItem;

- (NSString *)itemArchivePath;
- (void)loadAllItems;

- (DDGBook *)createBook;
- (NSArray *)allBooks;

- (bool)saveChanges;
- (bool)saveBooks;

- (DDGBook *)searchRBookInfoDouBan:(NSString *)bookISBN;
@end
