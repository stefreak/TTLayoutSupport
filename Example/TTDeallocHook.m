//
//  DeallocHook.m
//  Inkmonkey
//
//  Created by Steffen on 16.08.14.
//  Copyright (c) 2014 tatgram. All rights reserved.
//

#import "TTDeallocHook.h"
#import <objc/runtime.h>

// Address of a static global var can be used as a key
static void *kDeallocHookAssociation = &kDeallocHookAssociation;

@implementation TTDeallocHook

+ (id)attachTo:(id)target callback:(dispatch_block_t)block
{
    TTDeallocHook *hook = [[TTDeallocHook alloc] initWithCallback:block];
    
    // The trick is that associations are released when your target
    // object gets deallocated, so our DeallocHook object will get
    // deallocated right after your object
    objc_setAssociatedObject(target, kDeallocHookAssociation, hook, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    return hook;
}

- (id)initWithCallback:(dispatch_block_t)block
{
    self = [super init];
    
    if (self != nil) {
        // Here we just copy the callback for later
        self.callback = block;
    }

    return self;
}

- (void)dealloc
{
    // And we place our callback within the -dealloc method
    // of your helper class.
    if (self.callback != nil) {
        self.callback();
    }
}

@end
