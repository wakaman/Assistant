//
//  DDGNetworker.m
//  DigitPlayer
//
//  Created by Hackintosh-Developer on 10/8/2017.
//  Copyright © 2017 Mavericks-Hackintosh. All rights reserved.
//

#import "DDGNetworker.h"

//#import "DDGTask+CoreDataClass.h"
#import "DDGTask.h"

#import <CoreFoundation/CoreFoundation.h>
//#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>


@implementation DDGNetworker

+ (DDGNetworker *)sharedInstance
{
    static DDGNetworker *sharedInstance = nil;
    
    @synchronized (self) {
        if (!sharedInstance) {
            sharedInstance = [[self alloc] init];
        }
    }
    
    return sharedInstance;
}

/*
- (void)downloadTasks:(DDGUser *)userInfo
{

}
*/

- (BOOL)uploadTask:(DDGTask *)taskItem
{
    // Use tcpip connection task info upload to database ,book image upload to http server
    NSLog(@"Here we are!");
    
    // CFSocketRef clientSockfd = CFSocketCreate(kCFAllocatorDefault, PF_INET, SOCK_STREAM, IPPROTO_TCP, kCFSocketReadCallBack, NULL, NULL);//
    CFSocketRef clientSockfd = CFSocketCreate(kCFAllocatorDefault, PF_INET, SOCK_STREAM, IPPROTO_TCP, kCFSocketConnectCallBack, NULL, NULL);//
    //sockRef
    
    struct sockaddr_in serverAddr;
    memset(&serverAddr, 0, sizeof(serverAddr));
    
    serverAddr.sin_len = sizeof(serverAddr);
    serverAddr.sin_family = AF_INET;
    serverAddr.sin_port = htons(27015);
    serverAddr.sin_addr.s_addr = inet_addr("192.168.1.103");
    //serverAddr.sin_addr.s_addr = inet_addr(192.168.1.106);
    //clientSockfd
    
    CFDataRef address = CFDataCreate(kCFAllocatorDefault, (UInt8 *)&serverAddr, sizeof(serverAddr));
    
    // Connect
    CFSocketError result = CFSocketConnectToAddress(clientSockfd, address, 5);
    CFRelease(address);
    
    if (result != kCFSocketSuccess) {
        // release resource
        return false;
    }
    
    char buf[2048];
    memset(buf, 0, sizeof(buf) / sizeof(char));
    
    do
    {
        //int nRecvBytes = recv(clientSockfd, buf, sizeof(buf) / sizeof(char), 0);
        ssize_t nRecvBytes = recv(CFSocketGetNative(clientSockfd), buf, sizeof(buf) / sizeof(char), 0);
        
        if (nRecvBytes > 0) {
            NSLog(@"We got it");
            break;
        }
    } while (true);
    
    // Release resource
    CFRunLoopRef cfrl = CFRunLoopGetCurrent();
    CFRunLoopSourceRef source = CFSocketCreateRunLoopSource(kCFAllocatorDefault, clientSockfd, 0);
    CFRunLoopAddSource(cfrl, source, kCFRunLoopCommonModes);
    CFRelease(source);
    CFRunLoopRun();
    
    return true;
}

@end
