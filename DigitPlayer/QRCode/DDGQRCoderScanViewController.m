//
//  DDGQRCoderScanViewController.m
//  DigitPlayer
//
//  Created by Hackintosh-SnowSquirrel on 4/19/17.
//  Copyright (c) 2017 Mavericks-Hackintosh. All rights reserved.
//

#import "DDGDetailBookInfoViewController.h"
#import "DDGQRCoderScanViewController.h"
#import <AVFoundation/AVFoundation.h>

#import "DDGTaskStore.h"
#import "DDGBookStore.h"


static const char* kMainQueue = "primeQueue";


@interface DDGQRCoderScanViewController () <AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) AVCaptureMetadataOutput *captureMetadataOutput;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer* previewLayer;
@property (nonatomic, strong) AVCaptureDeviceInput* inputDevice;
@property (nonatomic, strong) AVCaptureSession* captureSession;
@property (nonatomic, strong) AVCaptureDevice* captureDevice;


@property (nonatomic, assign) BOOL bInit;

#pragma mark -- mark function
//- (void)showBookDetialView:(NSString*)bookISBN;
- (void)showDetailBookView:(NSString*)bookISBN;

@end

@implementation DDGQRCoderScanViewController

@synthesize dismissBlock;
@synthesize bInit;


- (id)init
{
    return [self initWithNibName:@"DDGQRCoderScanViewController" bundle:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        // Custom initialization
        // [_boxView setBackgroundColor:[UIColor greenColor]];
        bInit = false;
    }
    
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //[self startScanning];
    
    //[self showDetailBookView:@"9787800806094"];
    //[self showDetailBookView:@"9787121272639"];
    [self showDetailBookView:@"978-7-115-31809-1"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([self startReading]) {
        [self startScanning];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self stopScanning];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    [self startReading];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- scan qrcoder
- (BOOL)startReading
{

    if (bInit) {
        NSLog(@"We have init av capture");
        return true;
    }

    NSError* error;
    // AVCaptureDevice* captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    // AVCaptureDeviceInput* inputDevice = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    
    _captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    _inputDevice = [AVCaptureDeviceInput deviceInputWithDevice:_captureDevice error:&error];
    
    if (!_inputDevice) {
        NSLog(@"%@", [error localizedDescription]);
        return NO;
    }
    
    // AVCaptureMetadataOutput* captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    // AVCaptureMetadataOutput *captureMetadataOutput = [AVCaptureMetadataOutput new];
    // [captureMetadataOutput setRectOfInterest:CGRectMake(0.0, 0.0, 1.0, 1.0)];
    
    _captureMetadataOutput = [AVCaptureMetadataOutput new];
    _captureSession = [AVCaptureSession new];
    
    //_captureSession.sessionPreset = AVCaptureSessionPresetHigh;
    [_captureSession addOutput:_captureMetadataOutput];
    [_captureSession addInput:_inputDevice];

    
    // Can't set it there!
    // [captureMetadataOutput setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeCode128Code]];
    
    dispatch_queue_t dispatchQueue = dispatch_queue_create(kMainQueue, NULL);
    [_captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    [_captureMetadataOutput setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeCode128Code]];
    
    _previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _captureSession.sessionPreset = AVCaptureSessionPresetHigh;
    _previewLayer.frame = _boxView.bounds;
    [_boxView.layer addSublayer:_previewLayer];
    
    [_captureMetadataOutput setRectOfInterest:CGRectMake(0.0, 0.0, 1.0, 1.0)];
    // [_captureSession startRunning];

    bInit = true;
    return TRUE;
}

#pragma mark -- AVCaptureMetadataOutputObjectDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects != nil && [metadataObjects count] > 0 ) {
        
        AVMetadataMachineReadableCodeObject* metadataObj = [metadataObjects objectAtIndex:0];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // self.searchTF.text = [metadataObj stringValue];
            // NSLog(@"%@",metadataObj.stringValue);
            
            //[self stopReading];
            [self stopScanning];
            
            [self performSelectorOnMainThread:@selector(showDetailBookView:) withObject:metadataObj.stringValue waitUntilDone:false];
        });
    }
}

- (void)stopReading
{
    [_captureSession stopRunning];
    _captureSession = nil;
    [_previewLayer removeFromSuperlayer];
}

- (void)startScanning
{
    [_captureSession startRunning];
}

- (void)stopScanning
{
    [_captureSession stopRunning];
}

#pragma mark -- Book Detial
- (void)showDetailBookView:(NSString*)bookISBN
{
    
    DDGBook *rbkItem = [[DDGBookStore sharedStore] searchRBook:bookISBN];    
    if (nil == rbkItem) {
        rbkItem = [[DDGBookStore sharedStore] searchRBookInfoDouBan:bookISBN];
    }
    
    DDGDetailBookInfoViewController *detailBookInfoVC = [DDGDetailBookInfoViewController new];
    detailBookInfoVC.currentBook = rbkItem;
    
    UIBarButtonItem *backBarBtnItem = [UIBarButtonItem new];
    self.navigationItem.backBarButtonItem = backBarBtnItem;
    [backBarBtnItem setTitle:@"Back"];
    
    [[self navigationController] pushViewController:detailBookInfoVC animated:YES];
    
    // @property (nonatomic, copy) void (^dismissBlock)(void);    
    // detailBookInfoVC.modalPresentationStyle = UIModalPresentationCurrentContext;
    // [self presentViewController:detailBookInfoVC animated:YES completion:nil];    
    // [self presentModalViewController:detailBookInfoVC animated:YES];
    
    return;
}

@end
