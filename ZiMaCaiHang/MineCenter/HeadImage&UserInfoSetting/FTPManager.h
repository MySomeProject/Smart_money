//
//  FTPManager.h
//  ZiMaCaiHang
//
//  Created by zhangxh on 15/6/17.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CFNetwork/CFNetwork.h>

enum {
    kSendBufferSize = 32768
};

@protocol FTPManagerDelegate <NSObject>
-(void)ftpUploadFinishedWithSuccess:(BOOL)success;
@end

@interface FTPManager : NSObject<NSStreamDelegate>

@property (nonatomic, assign) id<FTPManagerDelegate>    delegate;

- (id)initWithServer:(NSString *)server user:(NSString *)username
            password:(NSString *)pass;

- (void)uploadFileWithFilePath:(NSString *)filePath;

@end
