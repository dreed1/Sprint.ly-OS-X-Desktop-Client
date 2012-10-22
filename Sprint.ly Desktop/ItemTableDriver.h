//
//  ItemTableDriver.h
//  Sprint.ly Desktop
//
//  Created by Dan Reed on 10/19/12.
//  Copyright (c) 2012 Dan Reed. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ItemDriverDelegate <NSObject>

- (void) reloadItemTable;

@end

@interface ItemTableDriver : NSObject<NSTableViewDataSource, NSTableViewDelegate>{
    NSArray *tableArray;
}

@property (nonatomic) id<ItemDriverDelegate>delegate;

- (void) giveTableArray:(NSArray *)newTableArray;

//sort methods
- (void) sortByNumber;
- (void) sortByStatus;
- (void) sortByType;
- (void) sortByAssigned;

@end
