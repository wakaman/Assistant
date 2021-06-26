//
//  DDGDetailBookInfoViewController.h
//  DigitPlayer
//
//  Created by SnowSquirrel on 6/26/17.
//  Copyright © 2017 Mavericks-Hackintosh. All rights reserved.
//

#import <UIKit/UIKit.h>


@class DDGBook;
//@class DDGReadBook;


@interface DDGDetailBookInfoViewController : UIViewController


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;

@property (weak, nonatomic) IBOutlet UIImageView *bookImageView;
@property (weak, nonatomic) IBOutlet UITextView *bookTextView;

//@property (strong, nonatomic) DDGBook *selectedBook;
//@property (strong, nonatomic) DDGReadBook *selectedBook;
//@property (strong, nonatomic) DDGReadBook *targetBook;

@property (strong, nonatomic) DDGBook *currentBook;

@end
