//
//  PeopleTableDriver.h
//  Sprint.ly Desktop
//
//  Created by Dan Reed on 10/19/12.
//  Copyright (c) 2012 Dan Reed. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PeopleDriverDelegate <NSObject>

- (void) userSelectedNewPerson:(int)newUserID;

@end

@interface PeopleTableDriver : NSObject<NSTableViewDataSource, NSTableViewDelegate>{
    NSArray *tableArray;
}

@property (nonatomic) id<PeopleDriverDelegate>delegate;

- (void) giveTableArray:(NSArray *)newTableArray;

@end
