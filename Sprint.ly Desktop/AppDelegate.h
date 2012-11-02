//
//  AppDelegate.h
//  Sprint.ly Desktop
//
//  Created by Dan Reed on 10/19/12.
//  Copyright (c) 2012 Dan Reed. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AsyncHTTP.h"
#import "ProductTableDriver.h"
#import "ItemTableDriver.h"
#import "PeopleTableDriver.h"

#define itemPageSize 100

@interface AppDelegate : NSObject <NSApplicationDelegate, ItemDriverDelegate, ProductDriverDelegate, PeopleDriverDelegate>{
    AsyncHTTP *sharedAsync;
    
    ProductTableDriver *productTableDriver;
    IBOutlet NSTableView *productsTable;
    
    ItemTableDriver *itemTableDriver;
    IBOutlet NSTableView *itemsTable;
    int currentPageOfItems;
    BOOL moreItemsAvailable;
    BOOL currentlyLoadingNextPage;
    
    PeopleTableDriver *peopleTableDriver;
    IBOutlet NSTableView *peopleTable;
    
    int activeApplicationId;
    int activeUserId;
}

@property (assign) IBOutlet NSWindow *window;

//action methods
- (IBAction)callForProducts:(id)sender;
- (IBAction)callForItems:(id)sender;
- (IBAction)callForPeople:(id)sender;
- (IBAction)callForUser:(id)sender;

//item delegate methods
- (void) reloadItemTable;
- (void) loadNextPageOfItems;

//product delegate methods
- (void) userSelectedNewApplication:(int)newAppID;

//people delegate methods
- (void) userSelectedNewPerson:(int)newUserID;

@end
