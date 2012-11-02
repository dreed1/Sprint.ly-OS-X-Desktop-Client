//
//  ItemTableDriver.h
//  Sprint.ly Desktop
//
//  Created by Dan Reed on 10/19/12.
//  Copyright (c) 2012 Dan Reed. All rights reserved.
//

#import <Foundation/Foundation.h>

enum {
    noSort = 0,
    numberAsc = 1,
    numberDesc = 2,
    statusAsc = 3,
    statusDesc = 4,
    typeAsc = 5,
    typeDesc = 6,
    assignedAsc = 7,
    assignedDesc = 8,
    scoreAsc = 9,
    scoreDesc = 10
};
typedef NSUInteger SortStyle;

@protocol ItemDriverDelegate <NSObject>

- (void) reloadItemTable;
- (void) loadNextPageOfItems;

@end

@interface ItemTableDriver : NSObject<NSTableViewDataSource, NSTableViewDelegate>{
    NSArray *tableArray;
    SortStyle sortStyle;
}

@property (nonatomic) id<ItemDriverDelegate>delegate;

- (void) giveTableArray:(NSArray *)newTableArray;
- (void) addToTableArray:(NSArray *)newItemsForArray;

//sort methods
- (void) sortByNumber;
- (void) sortByStatus;
- (void) sortByType;
- (void) sortByAssigned;
- (void) sortByScore;

@end
