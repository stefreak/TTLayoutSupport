//
//  DeallocHook.h
//  Inkmonkey
//
//  Created by Steffen on 16.08.14.
//  Copyright (c) 2014 tatgram. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTDeallocHook : NSObject

@property (copy, nonatomic) dispatch_block_t callback;

+ (id)attachTo:(id)target callback:(dispatch_block_t)block;

@end
