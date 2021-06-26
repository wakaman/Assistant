//
//  DDGBookRefStore.m
//  DigitPlayer
//
//  Created by Hackintosh-SnowSquirrel on 3/22/17.
//  Copyright (c) 2017 Mavericks-Hackintosh. All rights reserved.
//

#import "DDGBookStore.h"
#import "DDGBook.h"

#import "DDGDBExecutor.h"
//#import "./libcurl-ios-dist/include/curl/curl.h"


@interface DDGBookStore ()

- (DDGBook *)constructBookFrom:(NSDictionary *)bookItem;

@end



// Global c function
size_t imageViewCallback(char* ptr, size_t size, size_t nmemb, void* userdata);


@implementation DDGBookStore
{
    NSMutableArray* allBKItems;
}


+ (DDGBookStore *)sharedStore
{
    static DDGBookStore* sharedStore = nil;
    
    if (!sharedStore) {
        sharedStore = [[super allocWithZone:nil] init];
    }
    
    return sharedStore;
}

+ (id)allocWithZone:(NSZone*)zone
{
    return [self sharedStore];
}

- (DDGBook *)constructBook:(NSDictionary *)bookItem
{
    if (bookItem == nil) {
        return nil;
    }
    
    //DDGBook* book = [self createBook];
    DDGBook* book = [[DDGBook alloc] init];
    if (book == nil) {
        return nil;
    }
    
    book.isbn10 = bookItem[@"bkIsbn10"];
    book.isbn13 = bookItem[@"bkIsbn13"];
    book.title = bookItem[@"bkTitle"];
    book.subTitle = bookItem[@"bkSubTitle"];
    book.originTitle = bookItem[@"bkOriginTitle"];
    book.publisher = bookItem[@"bkPublish"];
    book.language = bookItem[@"bkLanguage"];
    book.binding = bookItem[@"bkBinding"];
    book.catalog = bookItem[@"bkCatalog"];
    book.summary = bookItem[@"bkSummary"];
    book.publishBatch = bookItem[@"bkPubBatch"];
    book.edition = bookItem[@"bkEdition"];
    book.pages = bookItem[@"bkPages"];
    book.price = bookItem[@"bkPrice"];
    book.publishDate = bookItem[@"bkPubDate"];
    book.mediumImage = [UIImage imageWithData:bookItem[@"bkMediumImage"]];
    book.smallImage = [UIImage imageWithData:bookItem[@"bkSmallImage"]];
    book.largeImage = [UIImage imageWithData:bookItem[@"bkLargeImage"]];
    book.translator = bookItem[@"bkTranslator"];
    book.author = bookItem[@"bkAuthor"];
    book.tags = bookItem[@"bkTags"];
    book.preference = bookItem[@"bkPereference"];
    
    return book;
}

- (id)init
{
    self = [super init];
    
    if (self) {
        
        
        
#if 0
        objectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
        NSPersistentStoreCoordinator* persStoreCood = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:objectModel];
        
        NSString* storePath = [self itemArchivePath];
        NSURL* storeUrl = [NSURL fileURLWithPath:storePath];
        
        NSError* error = nil;
        if (![persStoreCood addPersistentStoreWithType:NSSQLiteStoreType
                                        configuration:nil
                                                  URL:storeUrl
                                              options:nil
                                                error:&error]) {
            [NSException raise:@"Open failed"
                        format:@"Reason: %@", [error localizedDescription]];
        }
        
        objectContext = [NSManagedObjectContext new];
        [objectContext setPersistentStoreCoordinator:persStoreCood];
        
        [objectContext setUndoManager:nil];
#endif
        
        [self loadAllItems];
    }
    
    return self;
}

#pragma mark -- internal interface (private message method)
- (NSString *)itemArchivePath
{
    NSArray *documentDirectories =
            NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:@"Digits.archives"];
}

- (void)loadAllItems
{
    if (nil == allBKItems) {
        
        allBKItems = [NSMutableArray new];
        if (nil == allBKItems) {
            return;
        }
        
        
        NSArray* bookArry = [[DDGDBExecutor sharedExecutor] getDBBooks];
        if (bookArry == nil) {
            return;
        }
        
        for (id bkItem in bookArry) {
            [allBKItems addObject:[self constructBook:bkItem]];
        }
    }
}

//- (void)downloadImage:(NSString *)img fromURL:(NSString *)url toObject:(DDGBook *)rbkItem
- (void)downloadImage:(NSString *)img fromURL:(NSString *)url toObject:(DDGBook *)rbkItem
{
#if 0       // by liuc 20210626
    // Get imagee from urls -- // sPic lPic mPic
    CURL* easyHandle = curl_easy_init();
    
    curl_easy_setopt(easyHandle, CURLOPT_URL, [url UTF8String]);
    curl_easy_setopt(easyHandle, CURLOPT_HTTPAUTH, CURLAUTH_ANY);
    curl_easy_setopt(easyHandle, CURLOPT_WRITEFUNCTION, imageViewCallback);
    
    //跳过服务器SSL验证，不使用CA证书
    curl_easy_setopt(easyHandle, CURLOPT_SSL_VERIFYPEER, 0L);
    
    //如果不跳过SSL验证，则可指定一个CA证书目录
    //curl_easy_setopt(curl, CURLOPT_CAPATH, "this is ca ceat");
    
    
    NSMutableData *imgDat = [NSMutableData new];
    
    //curl_easy_setopt(easyHandle, CURLOPT_WRITEDATA, self);
    curl_easy_setopt(easyHandle, CURLOPT_WRITEDATA, imgDat);
    
    CURLcode curlRes = curl_easy_perform(easyHandle);
    if (CURLE_OK != curlRes) {
        NSLog(@"We got trouble!");
    }
    
    // Use KVC set book.bk_image_large or medium or small properties!!!
    UIImage* image = [[UIImage alloc] initWithData:imgDat];
    [rbkItem setValue:image forKey:img];
    
    curl_easy_cleanup(easyHandle);
    
    [imgDat resetBytesInRange:NSMakeRange(0, [imgDat length])];
    [imgDat setLength:0];
#endif
}

#pragma mark -- external interface (public message method)
//- (DDGBook *)searchRBookInfoDouBan:(NSString *)bookISBN
- (DDGBook *)searchRBookInfoDouBan:(NSString *)bookISBN
{
    // We should extract information from different source such as amazon, doubian, dangdang, 360buy
    // and each source with a company algorithm to dealn it information with the bookstore object
    
    // GET  https://api.douban.com/v2/book/isbn/:name
    // NSString *doubanUrl = [NSString stringWithFormat:@"http://api.douban.com/book/subject/isbn/%@?alt=json", _isbn];
    
    // bookInfoURL must be from a singleton config file which read it address from configuration file use for updating.
    NSString* bookInfoURL = [NSString stringWithFormat:@"https://api.douban.com/v2/book/isbn/:%@", bookISBN];
    
    // NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:doubanUrl]];
    NSURLRequest* requestUrl = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:bookInfoURL]];
    
    NSData *responseUrl = [NSURLConnection sendSynchronousRequest:requestUrl returningResponse:nil error:nil];
    NSString *stringJson = [[NSString alloc] initWithBytes:[responseUrl bytes] length:[responseUrl length] encoding:NSUTF8StringEncoding];
    
    NSData *responseUtf8 = [stringJson dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    
    NSDictionary *infoDic = [NSJSONSerialization JSONObjectWithData:responseUtf8 options:NSJSONReadingMutableContainers error:&error];
    // NSLog(@"%@", infoDic);
    
    if (error) {
        NSLog(@"error: %@", [error description]);
        return nil;
    }
    
    DDGBook* rbkItem = [self createBook];
    
    // Set book item's information!!!
    rbkItem.originTitle = [infoDic valueForKey:@"origin_title"];
    rbkItem.subTitle = [infoDic valueForKey:@"subtitle"];
    rbkItem.title = [infoDic valueForKey:@"title"];
    
    rbkItem.pages = [[NSDecimalNumber alloc] initWithString:[infoDic valueForKey:@"pages"]];
    //rbkItem.price = [NSDecimalNumber alloc] initWithString:[infoDic valueForKey:@"price"]
    rbkItem.price = [[NSNumber alloc] initWithFloat:[[infoDic valueForKey:@"price"] floatValue]];
    rbkItem.isbn13 = [infoDic valueForKey:@"isbn13"];
    rbkItem.isbn10 = [infoDic valueForKey:@"isbn10"];
    
    // _bookItem.bk_tags = [infoDic valueForKey:@"tags"];
    // NSData *arrayData = [NSKeyedArchiver archivedDataWithRootObject:[infoDic valueForKey:@"tags"]]; _bookItem.bk_tags = arrayData;
    rbkItem.tags = [NSKeyedArchiver archivedDataWithRootObject:[infoDic valueForKey:@"tags"]];
    
    // Deal with author, translator
    // rbkItem.author_introduce = [infoDic valueForKey:@"author_intro"];
    
    rbkItem.translator = [NSKeyedArchiver archivedDataWithRootObject:[infoDic valueForKey:@"translator"]];
    rbkItem.author = [NSKeyedArchiver archivedDataWithRootObject:[infoDic valueForKey:@"author"]];
    
    // NSString *string = @"2016-7-16 09:33:22";
    // 日期格式化类 -- 设置日期格式 为了转换成功 -- // NSString * -> NSDate * // @"yyyy-MM-dd HH:mm:ss"
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd";
    NSDate *date = [format dateFromString:[infoDic valueForKey:@"pubdate"]];
    if (date == nil) {
        format.dateFormat = @"yyyy-MM";
        date = [format dateFromString:[infoDic valueForKey:@"pubdate"]];
    }
    
    rbkItem.publishDate = date;
    rbkItem.publisher = [infoDic valueForKey:@"publisher"];
    rbkItem.binding = [infoDic valueForKey:@"binding"];
    rbkItem.catalog = [infoDic valueForKey:@"catalog"];
    rbkItem.summary = [infoDic valueForKey:@"summary"];
    
    // Must be something wrong!!!
    // [_bookItem setBk_image_medium:nil]; -- we can use macro instead those string.
    // if (!_imgData) {
        // _imgData = [NSMutableData data];
    //    _imgData = [[NSMutableData alloc] init];
    // }

    [self downloadImage:@"mediumImage"//@"image_medium"
                fromURL:[[infoDic valueForKey:@"images"] valueForKey:@"medium"] toObject:rbkItem];
    
    [self downloadImage:@"largeImage"//@"image_large"
                fromURL:[[infoDic valueForKey:@"images"] valueForKey:@"large"] toObject:rbkItem];
    
    [self downloadImage:@"smallImage"//@"image_small"
                fromURL:[[infoDic valueForKey:@"images"] valueForKey:@"small"] toObject:rbkItem];
    
    // Set images
    // _bookItem.bk_images = [[NSArray alloc]
    //                       initWithObjects:_bookItem.bk_image_large, _bookItem.bk_image_medium, _bookItem.bk_image_small, nil];
    // NSLog(@"%@", bookItem.image_medium);
    // rbkItem.images = nil;
    
    rbkItem.preference = nil;
    rbkItem.language = nil;    
    
    return rbkItem;
}

- (void)moveItemAtIndex:(NSInteger)from toIndex:(NSInteger)to
{

}

- (void)removeBook:(DDGBook *)bookItem
{
    //[allBookItems removeObject:bookItem];
    //[objectContext deleteObject:bookItem];
}

- (DDGBook *)searchRBook:(NSString *)bookISBN
{
    if (bookISBN == nil /*|| self.allBookItem.em*/) {
        return nil;
    }
    
#if 0
    for (DDGReadBook *rbkItem in allBookItems) {
        
        NSLog(@"The isbn 13 is %@", rbkItem.isbn13);
        NSLog(@"The isbn 10 is %@", rbkItem.isbn10);
        
        if ([[(DDGReadBook*)rbkItem isbn10] isEqualToString:bookISBN]
            || [[(DDGReadBook*)rbkItem isbn13] isEqualToString:bookISBN]) {
            
            return (DDGReadBook*)rbkItem;
        }
    }
#endif
    
    return nil;
}

- (bool)searchItem:(DDGBook *)bookItem
{
    return false;
}

- (DDGBook *)createBook
{
    DDGBook* newBook = [DDGBook new];
    [allBKItems addObject:newBook];
    return newBook;
}

- (NSArray *)allBooks
{
    return [allBKItems copy];
}

- (bool)saveChanges
{
#if 0
    NSError *error = nil;
    bool successful = [objectContext save:&error];
    if (!successful) {
        NSLog(@"Error saving: %@", [error localizedDescription]);
    }    
    return successful;
#endif 
    
    return true;
}

- (bool)saveBooks
{
    for (DDGBook* bkItem in allBKItems) {
        
        if ([[DDGDBExecutor sharedExecutor] isBookExistIsbn10:bkItem.isbn10 andIsbn13:bkItem.isbn13]) {
            continue;
        }
        
        [[DDGDBExecutor sharedExecutor] saveBook:bkItem];
    }

    return true;
}
@end

#pragma mark -- C function (why callback defination like this!)
size_t imageViewCallback(char* ptr, size_t size, size_t nmemb, void* userdata)
{
    if (userdata == nil) {
        NSLog(@"Invalid parameter!");
        return 0;
    }
    
    const size_t sizeInBytes = size * nmemb;
    
    // UIViewController* vc = (__bridge UIViewController*)userdata;
    // userdata = (__bridge void*)[UIImage imageWithData:data];
    // UIImage* bkImg = (__bridge UIImage*)userdata;
    
    NSData* data = [[NSData alloc] initWithBytes:ptr length:sizeInBytes];
    NSMutableData* imgData = (__bridge NSMutableData*)userdata;
    [imgData appendData:data];
    
    NSLog(@"------>>line:%d, data:%@", __LINE__, data);
    return sizeInBytes;
}
