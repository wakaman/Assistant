//
//  DDGDBExecutor.m
//  DigitPlayer
//
//  Created by Hackintosh-Cpp on 12/18/17.
//  Copyright © 2017 Mavericks-Hackintosh. All rights reserved.
//


#import "DDGDBExecutor.h"

#import "DDGProjectTask.h"
#import "DDGReadTask.h"

#import "DDGBook.h"
#import "DDGTask.h"

#include "SQLite3Cpp.hpp"
#include <iostream>
using namespace SQLite3;


@interface DDGDBExecutor ()

- (bool)saveProject:(DDGProjectTask *)project;
- (bool)saveReadTask:(DDGReadTask *)readBook;

- (bool)isTableExist:(NSString *)tableName;

- (int)bookIsbn10Count:(NSString *)strIsbn10;
- (int)bookIsbn13Count:(NSString *)strIsbn13;

- (void)createTable:(NSString *)strSql;
- (void)createBookTable;

- (void)createReadTable;
- (void)createProTable;

- (NSArray *)getProjects;
- (NSArray *)getReads;

@end


@implementation DDGDBExecutor
{
    Database taskBroker;
}


+ (DDGDBExecutor *)sharedExecutor
{
    static DDGDBExecutor* sharedExecutor = nil;
    
    if (! sharedExecutor) {
        sharedExecutor = [[super allocWithZone:nil] init];
    }
    
    return sharedExecutor;
}

- (id)init
{
    self = [super init];
    if (self) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *dbUrl = [[NSString alloc] initWithFormat:@"%s/DigitPlayer.db", [[paths objectAtIndex:0] UTF8String]];
        taskBroker.Open(dbUrl.UTF8String);
    }
    
    return self;
}

- (void)createReadTable
{
    NSLog(@"Here we create RBook table!");
    
    NSString* strSql = @"create table uRead(readId integer primary key,\
    bkTitle varchar(60) null,\
    bkIsbn10 varchar(60) null,\
    bkIsbn13 varchar(60) null,\
    bkLibrary varchar(100) null,\
    bkImage blob null,\
    bkReBorrow bool null,\
    createDate datetime not null,\
    beginDate datetime not null,\
    endDate datetime null,\
    currentPage int null,\
    priority int null)";
    
    [self createTable:strSql];    
}

- (void)createBookTable
{
    NSLog(@"Here we create RBook table!");
    
    NSString* strSql = @"create table uBook(bkId integer primary key,\
    bkIsbn10 varchar(10) null,\
    bkIsbn13 varchar(13) null,\
    bkTitle varchar(50) null,\
    bkSubTitle varchar(50) null,\
    bkOriginTitle varchar(50) null,\
    bkPublish varchar(50) null,\
    bkLanguage varchar(16) null,\
    bkBinding varchar(6) null,\
    bkCatalog varchar(16) null,\
    bkSummary varchar(300) null,\
    bkPubBatch int null,\
    bkEdition int null,\
    bkPages int null,\
    bkPrice int null,\
    bkPubDate date null,\
    bkMediumImage blob null,\
    bkSmallImage blob null,\
    bkLargeImage blob null,\
    bkTranslator blob null,\
    bkAuthor blob not null,\
    bkTags blob null,\
    bkPreference blob null)";
    
    [self createTable:strSql];
}

- (void)createProTable
{
    NSLog(@"Here we create project table!");
    
    NSString* strSql = @"create table uProject(proId integer primary key,\
    title varchar(20) not null,\
    descrp varchar(500) not null,\
    createDate datetime not null,\
    beginDate datetime not null,\
    funs blob null, bugs blob null)";
    
    [self createTable:strSql];
}

- (void)addProject:(DDGProjectTask *)project;
{
    using namespace SQLite3;
    
#if 0
    Database taskDbase;
    taskDbase.Open("DigitPlayer.db");
    if (! [self isTableExist:@"uProject"]) {
        [self createProTable];
    }
#endif
    
    // NSString *strSql = @"insert into uprojects(title, descrp, create, begin, priority, duration, functions, bugs) values('aaaa', 'bbbb', 'cccc', 'ddddd', 'eeeee')";
    // NSLog(@"Here we are!");
}

- (bool)saveProject:(DDGProjectTask *)project
{
    // Task
    if (! [self isTableExist:@"uProject"]) {
        [self createProTable];
    }
    
    project.taskCreatedDate = [NSDate date];
    project.taskBeginDate = [NSDate date];
    
    NSData* funsData = [NSKeyedArchiver archivedDataWithRootObject:project.allFuns];
    NSData* bugsData = [NSKeyedArchiver archivedDataWithRootObject:project.allBugs];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *strSql = @"insert into uProject values(?, ?, ?, ?, ?, ?, ?)";
    Statement sqliteStmt = taskBroker.compileStatement(strSql.UTF8String);
    sqliteStmt.bindNull(1);
    sqliteStmt.bind(2, project.taskTitle.UTF8String);
    sqliteStmt.bind(3, project.projectDescrp.UTF8String);
    sqliteStmt.bind(4, [formatter stringFromDate:project.taskCreatedDate].UTF8String);
    sqliteStmt.bind(5, [formatter stringFromDate:project.taskBeginDate].UTF8String);
    sqliteStmt.bind(6, (unsigned char*)funsData.bytes, (int)funsData.length);
    sqliteStmt.bind(7, (unsigned char*)bugsData.bytes, (int)bugsData.length);
    
    bool bRet = false;
    sqliteStmt.execDML() ? bRet = true : bRet = false;
    
    return bRet;
}

// NSDictionary(type, NSDictionary(key, value))
- (bool)saveReadTask:(DDGReadTask *)readTask
{
    if (! [self isTableExist:@"uRead"]) {
        [self createReadTable];
    }
    
    NSString* strBkIsbn10 = readTask.currentBook.isbn10;
    NSString* strBkIsbn13 = readTask.currentBook.isbn13;
    if (strBkIsbn10 == nil && strBkIsbn13 == nil) {
        return false;
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *strSql = @"insert into uRead values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    Statement sqliteStmt = taskBroker.compileStatement(strSql.UTF8String);
    sqliteStmt.bindNull(1);
    sqliteStmt.bind(2, readTask.taskTitle.UTF8String);
    sqliteStmt.bind(3, strBkIsbn10.UTF8String);
    sqliteStmt.bind(4, strBkIsbn13.UTF8String);
    
    if (readTask.bkImage != nil) {
        NSData* imageData = UIImagePNGRepresentation(readTask.bkImage);
        sqliteStmt.bind(5, (unsigned char*)imageData.bytes, (int)imageData.length);
    }
    else {
        sqliteStmt.bindNull(5);
    }
    
    sqliteStmt.bind(6, readTask.bkLibrary.UTF8String);
    sqliteStmt.bind(7, readTask.reBorrow.intValue);
    sqliteStmt.bind(8, [formatter stringFromDate:readTask.taskCreatedDate].UTF8String);
    sqliteStmt.bind(9, [formatter stringFromDate:readTask.taskBeginDate].UTF8String);
    sqliteStmt.bind(10, [formatter stringFromDate:readTask.duration].UTF8String);
    sqliteStmt.bind(11, 0);
    sqliteStmt.bind(12, 0);
    
    bool bRet = false;
    sqliteStmt.execDML() ? bRet = true : bRet = false;
    return bRet;
}

- (bool)saveTask:(DDGTask *)task
{
    bool bRet(false);
    switch (task.taskType.intValue) {
        case kDDGProjectTaskType:
            bRet = [self saveProject:(DDGProjectTask *)task];
            break;
            
        case kDDGReadingTaskType:
            bRet = [self saveReadTask:(DDGReadTask *)task];
            break;
            
        case kDDGEventTaskType:
            break;
    }
    
    return bRet;
}

- (bool)saveBook:(DDGBook *)book
{
    bool bRet(false);
    if (nil == book) {
        return bRet;
    }
    
    // Book
    if (! [self isTableExist:@"uBook"]) {
        [self createBookTable];
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *strSql = @"insert into uBook values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    Statement sqliteStmt = taskBroker.compileStatement(strSql.UTF8String);
    sqliteStmt.bindNull(1);
    sqliteStmt.bind(2, book.isbn10.UTF8String);
    sqliteStmt.bind(3, book.isbn13.UTF8String);
    sqliteStmt.bind(4, book.title.UTF8String);
    sqliteStmt.bind(5, book.subTitle.UTF8String);
    sqliteStmt.bind(6, book.originTitle.UTF8String);
    sqliteStmt.bind(7, book.publisher.UTF8String);
    sqliteStmt.bind(8, book.language.UTF8String);
    sqliteStmt.bind(9, book.binding.UTF8String);
    sqliteStmt.bind(10, book.catalog.UTF8String);
    sqliteStmt.bind(11, book.summary.UTF8String);
    sqliteStmt.bind(12, book.publishBatch.intValue);
    sqliteStmt.bind(13, book.edition.intValue);
    sqliteStmt.bind(14, book.pages.intValue);
    sqliteStmt.bind(15, book.price.floatValue);
    
    //NSData* image = [NSKeyedArchiver archivedDataWithRootObject:book.m];
    sqliteStmt.bind(16, [formatter stringFromDate:book.publishDate].UTF8String);
    
    NSData* image = UIImagePNGRepresentation(book.mediumImage);
    sqliteStmt.bind(17, (unsigned char*)image.bytes, (int)image.length);
    image = UIImagePNGRepresentation(book.smallImage);
    sqliteStmt.bind(18, (unsigned char*)image.bytes, (int)image.length);
    image = UIImagePNGRepresentation(book.largeImage);
    sqliteStmt.bind(19, (unsigned char*)image.bytes, (int)image.length);
    
    // NSArray to NSData
    //NSDate* arry = [NSKeyedArchiver archivedDataWithRootObject:book.translator]
    sqliteStmt.bind(20, (unsigned char*)book.translator.bytes, (int)book.translator.length);
    sqliteStmt.bind(21, (unsigned char*)book.author.bytes, (int)book.author.length);
    sqliteStmt.bind(22, (unsigned char*)book.tags.bytes, (int)book.tags.length);
    sqliteStmt.bind(23, (unsigned char*)book.preference.bytes, (int)book.preference.length);

    sqliteStmt.execDML() ? bRet = true : 0;
    return bRet;
}

- (bool)isBookExistIsbn10:(NSString *)strIsbn10 andIsbn13:(NSString *)strIsbn13
{
    bool bExist = false;
    
    if (! [self isTableExist:@"uBook"]) {
        return bExist;
    }
    
    if (strIsbn10 != nil) {
        [self bookIsbn10Count:strIsbn10] ? bExist = true : 0;
    }
    
    if (!bExist && strIsbn13 != nil) {
        [self bookIsbn13Count:strIsbn13] ? bExist = true : 0;
    }
    
    return bExist;
}

- (void)extraceTask
{
    NSLog(@"Here we are!");
}

- (NSArray *)getDBBooks
{
    if (![self isTableExist:@"uBook"]) {
        return nil;
    }
    
    NSMutableArray* bookArry = [[NSMutableArray alloc] init];
    using namespace std;
    
    NSString* strBkIsbn10 = nil;
    NSString* strBkIsbn13 = nil;
    NSString* strBkTitle = nil;
    NSString* strBkSubTitle = nil;
    NSString* strBkOriginTitle = nil;
    NSString* strBkPublish = nil;
    NSString* strBkLanguage = nil;
    NSString* strBkBinding = nil;
    NSString* strBkCatalog = nil;
    NSString* strBkSummary = nil;
    NSDate* bkPubDate = nil;
    NSData* bkMediumImage = nil;
    NSData* bkSmallImage = nil;
    NSData* bkLargeImage = nil;
    NSData* bkTranslator = nil;
    NSData* bkAuthor = nil;
    NSData* bkTags = nil;
    NSData* bkPereference = nil;
    NSNumber* bkPubBatch = nil;
    NSNumber* bkEdition = nil;
    NSNumber* bkPages = nil;
    NSNumber* bkPrice = nil;
    NSNumber* bkIndex = nil;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    int length = 0;

    NSString* strSql = @"select * from uBook";
    Query bookSet = taskBroker.execQuery(strSql.UTF8String);
    
    while (! bookSet.eof()) {
        
        bkIndex = [[NSNumber alloc] initWithInt:bookSet.getIntField(0)];
        
        strBkIsbn10 = [[NSString alloc] initWithUTF8String:bookSet.getStringField(1)];
        strBkIsbn13 = [[NSString alloc] initWithUTF8String:bookSet.getStringField(2)];
        strBkTitle = [[NSString alloc] initWithUTF8String:bookSet.getStringField(3)];
        strBkSubTitle = [[NSString alloc] initWithUTF8String:bookSet.getStringField(4)];
        strBkOriginTitle = [[NSString alloc] initWithUTF8String:bookSet.getStringField(5)];
        strBkPublish = [[NSString alloc] initWithUTF8String:bookSet.getStringField(6)];
        strBkLanguage = [[NSString alloc] initWithUTF8String:bookSet.getStringField(7)];
        strBkBinding = [[NSString alloc] initWithUTF8String:bookSet.getStringField(8)];
        strBkCatalog = [[NSString alloc] initWithUTF8String:bookSet.getStringField(9)];
        strBkSummary = [[NSString alloc] initWithUTF8String:bookSet.getStringField(10)];
        bkPubBatch = [[NSNumber alloc] initWithInt:bookSet.getIntField(11)];
        bkEdition = [[NSNumber alloc] initWithInt:bookSet.getIntField(12)];
        bkPages = [[NSNumber alloc] initWithInt:bookSet.getIntField(13)];
        
        bkPrice = [[NSNumber alloc] initWithFloat:bookSet.getFloatField(14)];
        //bkPrice = [[NSNumber alloc] initWithInt:bookSet.getIntField(14)];
        
        bkPubDate = [formatter dateFromString:[[NSString alloc] initWithUTF8String:bookSet.getStringField(15)]];
        bkMediumImage = [[NSData alloc] initWithBytes:bookSet.getBlobField(16, length) length:length];
        bkSmallImage = [[NSData alloc] initWithBytes:bookSet.getBlobField(17, length) length:length];
        bkLargeImage = [[NSData alloc] initWithBytes:bookSet.getBlobField(18, length) length:length];
        bkTranslator = [[NSData alloc] initWithBytes:bookSet.getBlobField(19, length) length:length];
        bkAuthor = [[NSData alloc] initWithBytes:bookSet.getBlobField(20, length) length:length];
        bkTags = [[NSData alloc] initWithBytes:bookSet.getBlobField(21, length) length:length];
        bkPereference = [[NSData alloc] initWithBytes:bookSet.getBlobField(22, length) length:length];
        
        NSDictionary* record = @{
                                 @"bkIndex" : bkIndex,
                                 @"bkIsbn10" : strBkIsbn10,
                                 @"bkIsbn13" : strBkIsbn13,
                                 @"bkTitle" : strBkTitle,
                                 @"bkSubTitle" : strBkSubTitle,
                                 @"bkOriginTitle" : strBkOriginTitle,
                                 @"bkPublish" : strBkPublish,
                                 @"bkLanguage" : strBkPublish,
                                 @"bkBinding" : strBkLanguage,
                                 @"bkCatalog" : strBkCatalog,
                                 @"bkSummary" : strBkSummary,
                                 @"bkPubBatch" : bkPubBatch,
                                 @"bkEdition" : bkEdition,
                                 @"bkPages" : bkPages,
                                 @"bkPrice" : bkPrice,
                                 @"bkPubDate" : bkPubDate,
                                 @"bkMediumImage" : bkMediumImage,
                                 @"bkSmallImage" : bkSmallImage,
                                 @"bkLargeImage" : bkLargeImage,
                                 @"bkTranslator" : bkTranslator,
                                 @"bkAuthor" : bkAuthor,
                                 @"bkTags" : bkTags,
                                 @"bkPereference" : bkPereference
                                 };
        
        [bookArry addObject:record];
        bookSet.nextRow();
    }

    return [bookArry copy];
}

- (NSDictionary *)getTasks
{
    NSLog(@"Here we got data from database!");
    // use multitread to get every table's records
    
    NSMutableDictionary* taskDict = [NSMutableDictionary new];
    NSArray* taskItems = (id)[NSNull null];
    
    if ([self isTableExist:@"uProject"]) {
        taskItems = [self getProjects];
        [taskDict setObject:taskItems forKey:@"projects"];
    }
    
    if ([self isTableExist:@"uRead"]) {
        taskItems = [self getReads];
        [taskDict setObject:taskItems forKey:@"reads"];
    }
    
    return [taskDict copy];
}
        
#pragma mark -- private
- (bool)isTableExist:(NSString *)tableName
{
    bool bRet = false;
    if (tableName == nil) {
        return bRet;
    }
    
    return taskBroker.tableExists(tableName.UTF8String);
}

- (void)createTable:(NSString *)strSql
{
    if (nil == strSql) {
        return;
    }
    
    taskBroker.execDML(strSql.UTF8String);
}

- (int)bookIsbn10Count:(NSString *)strIsbn10
{
    int count(0);
    if (strIsbn10 == nil) {
        return count;
    }

    NSString* strSql = [[NSString alloc] initWithFormat:@"select count(*) from uBook where bkIsbn10=\'%s\'", strIsbn10.UTF8String];
    Query countSet = taskBroker.execQuery(strSql.UTF8String);
    
    while (! countSet.eof()) {
        count = countSet.getIntField(0);
        countSet.nextRow();
    }
    
    return count;
}

- (int)bookIsbn13Count:(NSString *)strIsbn13
{
    int count(0);
    if (strIsbn13 == nil) {
        return count;
    }
    
    NSString* strSql = [[NSString alloc] initWithFormat:@"select count(bkIsbn13) from uBook where bkIsbn13=\'%s\'", strIsbn13.UTF8String];
    Query countSet = taskBroker.execQuery(strSql.UTF8String);
    
    while (! countSet.eof()) {
        count = countSet.getIntField(0);
        countSet.nextRow();
    }
    
    return count;
}

// NSDictionary --
- (NSArray *)getProjects
{
    using namespace std;
    
    NSString* strSql = @"select * from uProject";
    Query projectSet = taskBroker.execQuery(strSql.UTF8String);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSMutableArray* proArry = [[NSMutableArray alloc] init];
    NSString* strDescrp = nil;
    NSDate* createdDate = nil;
    NSString* strTitle = nil;
    NSDate* beginDate = nil;
    NSArray* funsArry = nil;
    NSArray* bugsArry = nil;
    NSData* funcDat = nil;
    NSData* bugsDat = nil;
    int length(0);
    int index(0);
    
    while (! projectSet.eof()) {

        index = projectSet.getIntField(0);
        cout << "index is" << index << endl;
        
        strTitle = [[NSString alloc] initWithUTF8String:projectSet.getStringField(1)];
        strDescrp = [[NSString alloc] initWithUTF8String:projectSet.getStringField(2)];
        beginDate = [formatter dateFromString:[[NSString alloc] initWithUTF8String:projectSet.getStringField(3)]];
        createdDate = [formatter dateFromString:[[NSString alloc] initWithUTF8String:projectSet.getStringField(4)]];
        funcDat = [[NSData alloc] initWithBytes:projectSet.getBlobField(5, length) length:length];
        bugsDat = [[NSData alloc] initWithBytes:projectSet.getBlobField(6, length) length:length];
        funsArry = [NSKeyedUnarchiver unarchiveObjectWithData:funcDat];
        bugsArry = [NSKeyedUnarchiver unarchiveObjectWithData:bugsDat];
        
        NSDictionary* record = @{
                                 @"taskTitle" : strTitle,
                                 @"projectDescrp" : strDescrp,
                                 @"beginDate" : beginDate,
                                 @"createdDate" : createdDate,
                                 @"funsArry" : funsArry,
                                 @"bugsArry" : bugsArry
                                 };
        
        [proArry addObject:record];
        
        // next row
        projectSet.nextRow();
    }
    
    return [proArry copy];
}

- (NSArray *)getReads
{
    using namespace std;
    
    NSString* strSql = @"select * from uRead";
    Query readSet = taskBroker.execQuery(strSql.UTF8String);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSMutableArray* readArry = [[NSMutableArray alloc] init];
    NSString* strBkLibrary = nil;
    NSString* strBkIsbn10 = nil;
    NSString* strBkIsbn13 = nil;
    NSString* strBkTitle = nil;
    NSDate* createDate = nil;
    NSDate* beginDate = nil;
    NSDate* endDate = nil;
    NSData* bkImage = nil;
    NSDecimalNumber* currentPage = nil;
    NSDecimalNumber* bkReBorrow = nil;
    NSDecimalNumber* priority = nil;
    int length(0);
    int index(0);
    
    while (! readSet.eof()) {
        
        index = readSet.getIntField(0);
        cout << "index is" << index << endl;
        strBkTitle = [[NSString alloc] initWithUTF8String:readSet.getStringField(1)];
        strBkIsbn10 = [[NSString alloc] initWithUTF8String:readSet.getStringField(2)];
        strBkIsbn13 = [[NSString alloc] initWithUTF8String:readSet.getStringField(3)];
        bkImage = [[NSData alloc] initWithBytes:readSet.getBlobField(4, length) length:length];
        strBkLibrary = [[NSString alloc] initWithUTF8String:readSet.getStringField(5)];
        bkReBorrow = [[NSDecimalNumber alloc] initWithBool:readSet.getIntField(6)];
        beginDate = [formatter dateFromString:[[NSString alloc] initWithUTF8String:readSet.getStringField(7)]];
        createDate = [formatter dateFromString:[[NSString alloc] initWithUTF8String:readSet.getStringField(8)]];
        endDate = [formatter dateFromString:[[NSString alloc] initWithUTF8String:readSet.getStringField(9)]];
        currentPage = [[NSDecimalNumber alloc] initWithInt:readSet.getIntField(10)];
        priority = [[NSDecimalNumber alloc] initWithInt:readSet.getIntField(11)];
        
        NSDictionary* record = @{
                                 @"bkTitle" : strBkTitle,
                                 @"bkIsbn10" : strBkIsbn10,
                                 @"bkIsbn13" : strBkIsbn13,
                                 @"bkImage" : bkImage,
                                 @"bkLibrary" : strBkLibrary,
                                 @"bkReBorrow" : bkReBorrow,
                                 @"beginDate" : beginDate,
                                 @"createDate" : createDate,
                                 @"endDate" : endDate,
                                 @"currentPage" : currentPage,
                                 @"priority" : priority
                                 };
        
        [readArry addObject:record];
        
        // next row
        readSet.nextRow();
    }
    
    return [readArry copy];
}

@end
