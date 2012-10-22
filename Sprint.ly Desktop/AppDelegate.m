//
//  AppDelegate.m
//  Sprint.ly Desktop
//
//  Created by Dan Reed on 10/19/12.
//  Copyright (c) 2012 Dan Reed. All rights reserved.
//

#import "AppDelegate.h"


@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    sharedAsync = [AsyncHTTP sharedAsync];
    
    productTableDriver = [[ProductTableDriver alloc]init];
    [productTableDriver setDelegate:self];
    [productsTable setDataSource:productTableDriver];
    [productsTable setDelegate:productTableDriver];
    
    itemTableDriver = [[ItemTableDriver alloc]init];
    [itemTableDriver setDelegate:self];
    [itemsTable setDataSource:itemTableDriver];
    [itemsTable setDelegate:itemTableDriver];
    
    peopleTableDriver = [[PeopleTableDriver alloc]init];
    [peopleTableDriver setDelegate:self];
    [peopleTable setDataSource:peopleTableDriver];
    [peopleTable setDelegate:peopleTableDriver];
    
    [self callForProducts:nil];
}

#pragma mark - action methods

- (IBAction)callForProducts:(id)sender{
    [sharedAsync makeGetRequestWithPath:@"products.json" andParameters:nil withCallback:^(MKNetworkOperation *callback){
        [productTableDriver giveTableArray:[callback responseJSON]];
        [productsTable reloadData];
        
        activeApplicationId = [[[[callback responseJSON] objectAtIndex:0]objectForKey:@"id"]intValue];
        [self callForItems:nil];
        [self callForPeople:nil];
    }];
}

- (IBAction)callForItems:(id)sender{
    NSDictionary *params = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSNumber numberWithInt:100], nil] forKeys:[NSArray arrayWithObjects: @"limit", nil]];
    [sharedAsync makeGetRequestWithPath:[NSString stringWithFormat:@"products/%d/items.json",activeApplicationId] andParameters:params withCallback:^(MKNetworkOperation *callback){
        [itemTableDriver giveTableArray:[callback responseJSON]];
        [itemsTable reloadData];
    }];
}

- (IBAction)callForPeople:(id)sender{
    [sharedAsync makeGetRequestWithPath:[NSString stringWithFormat:@"products/%d/people.json",activeApplicationId] andParameters:nil withCallback:^(MKNetworkOperation *callback){
        [peopleTableDriver giveTableArray:[callback responseJSON]];
        [peopleTable reloadData];
    }];
}

- (IBAction)callForUser:(id)sender{
    if(activeUserId){
        NSDictionary *params = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSNumber numberWithInt:activeUserId],[NSNumber numberWithInt:100], nil] forKeys:[NSArray arrayWithObjects:@"assigned_to", @"limit", nil]];
        [sharedAsync makeGetRequestWithPath:[NSString stringWithFormat:@"products/%d/items.json",activeApplicationId] andParameters:params withCallback:^(MKNetworkOperation *callback){
            [itemTableDriver giveTableArray:[callback responseJSON]];
            [itemsTable reloadData];
        }];
    }
    else{
        NSAlert *noUserAlert = [NSAlert alertWithMessageText:@"Dude, you have to select a user first" defaultButton:@"Whoops, my bad" alternateButton:nil otherButton:nil informativeTextWithFormat:@"How can you have any pudding if you don't eat your meat?"];
        [noUserAlert runModal];
    }
}

#pragma mark - item delegate methods
- (void) reloadItemTable{
    [itemsTable reloadData];
}

#pragma mark - product delegate methods
- (void) userSelectedNewApplication:(int)newAppID{
    activeApplicationId = newAppID;
    [self callForItems:nil];
    [self callForPeople:nil];
}

#pragma mark - people delegate methods

- (void) userSelectedNewPerson:(int)newUserID{
    activeUserId = newUserID;
}

@end
