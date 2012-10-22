//
//  ProductTableDriver.h
//  Sprint.ly Desktop
//
//  Created by Dan Reed on 10/19/12.
//  Copyright (c) 2012 Dan Reed. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ProductDriverDelegate <NSObject>

- (void) userSelectedNewApplication:(int)newAppID;

@end

@interface ProductTableDriver : NSObject<NSTableViewDataSource, NSTableViewDelegate>{
    NSArray *tableArray;
}

@property (nonatomic) id<ProductDriverDelegate>delegate;

- (void) giveTableArray:(NSArray *)newTableArray;

@end
