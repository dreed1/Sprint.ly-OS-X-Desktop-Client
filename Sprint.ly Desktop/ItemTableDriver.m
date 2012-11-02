//
//  ItemTableDriver.m
//  Sprint.ly Desktop
//
//  Created by Dan Reed on 10/19/12.
//  Copyright (c) 2012 Dan Reed. All rights reserved.
//

#import "ItemTableDriver.h"

@implementation ItemTableDriver
@synthesize delegate;

- (void) giveTableArray:(NSArray *)newTableArray{
    if(!sortStyle)
        sortStyle = 0;
    tableArray = [NSArray arrayWithArray:newTableArray];
}

- (void) addToTableArray:(NSArray *)newItemsForArray{
    NSMutableArray *newArray = [NSMutableArray arrayWithArray:tableArray];
    for(NSDictionary *anItem in newItemsForArray){
        [newArray addObject:anItem];
    }
    tableArray = [NSArray arrayWithArray:newArray];
}

#pragma mark - tableview datasouce/delegate methods

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex{
    if([[aTableColumn identifier]isEqualToString:@"number_column"]){
        return [[tableArray objectAtIndex:rowIndex]objectForKey:@"number"];
    }
    else if([[aTableColumn identifier]isEqualToString:@"status_column"]){
        return [[tableArray objectAtIndex:rowIndex]objectForKey:@"status"];
    }
    else if([[aTableColumn identifier]isEqualToString:@"score_column"]){
        return [[tableArray objectAtIndex:rowIndex]objectForKey:@"score"];
    }
    else if([[aTableColumn identifier]isEqualToString:@"type_column"]){
        return [[tableArray objectAtIndex:rowIndex]objectForKey:@"type"];
    }
    else if([[aTableColumn identifier]isEqualToString:@"assigned_column"]){
        if(![[[[tableArray objectAtIndex:rowIndex]objectForKey:@"assigned_to"]class]isSubclassOfClass:[NSNull class]])
            return [[[tableArray objectAtIndex:rowIndex]objectForKey:@"assigned_to"]objectForKey:@"first_name"];
        else
            return @"Nobody";
    }
    else if([[aTableColumn identifier]isEqualToString:@"title_column"]){
        return [[tableArray objectAtIndex:rowIndex]objectForKey:@"title"];
    }
    else{
        DLog(@"%@",[aTableColumn identifier]);
        return @"SH*T!";
    }
}

- (void) tableView:(NSTableView *)tableView willDisplayCell:(id)cell forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    if(row == [tableArray count]-1){
        [delegate loadNextPageOfItems];
    }
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView{
    return [tableArray count];
}

- (BOOL)tableView:(NSTableView *)aTableView shouldSelectTableColumn:(NSTableColumn *)aTableColumn{
    if([[aTableColumn identifier]isEqualToString:@"number_column"]){
        [self sortByNumber];
    }
    else if([[aTableColumn identifier]isEqualToString:@"status_column"]){
        [self sortByStatus];
    }
    else if([[aTableColumn identifier]isEqualToString:@"type_column"]){
        [self sortByType];
    }
    else if([[aTableColumn identifier]isEqualToString:@"assigned_column"]){
        [self sortByAssigned];
    }
    else if([[aTableColumn identifier]isEqualToString:@"score_column"]){
        [self sortByScore];
    }
    else{
        DLog(@"i refuse to sort by title");
    }
    return NO;
}

#pragma mark - sort methods

- (void) sortByNumber{
    NSSortDescriptor *numberSort;
    if(sortStyle !=numberAsc){
        sortStyle = numberAsc;
        numberSort = [[NSSortDescriptor alloc]initWithKey:@"number" ascending:YES];
    }
    else if(sortStyle == numberAsc){
        sortStyle = numberDesc;
        numberSort = [[NSSortDescriptor alloc]initWithKey:@"number" ascending:NO];
    }
    tableArray  = [tableArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:numberSort]];
    [delegate reloadItemTable];
}

- (void) sortByStatus{
    NSSortDescriptor *statusSort;
    if(sortStyle !=statusAsc){
        sortStyle = statusAsc;
        statusSort = [[NSSortDescriptor alloc]initWithKey:@"status" ascending:YES];
    }
    else if(sortStyle == statusAsc){
        sortStyle = statusDesc;
        statusSort = [[NSSortDescriptor alloc]initWithKey:@"status" ascending:NO];
    }
    tableArray  = [tableArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:statusSort]];
    [delegate reloadItemTable];
}

- (void) sortByType{
    NSSortDescriptor *typeSort;
    if(sortStyle !=typeAsc){
        sortStyle = typeAsc;
        typeSort = [[NSSortDescriptor alloc]initWithKey:@"type" ascending:YES];
    }
    else if(sortStyle == typeAsc){
        sortStyle = typeDesc;
        typeSort = [[NSSortDescriptor alloc]initWithKey:@"type" ascending:NO];
    }
    tableArray  = [tableArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:typeSort]];
    [delegate reloadItemTable];
}

- (void) sortByScore{
    NSSortDescriptor *scoreSort;
    if(sortStyle !=scoreAsc){
        sortStyle = scoreAsc;
        scoreSort = [[NSSortDescriptor alloc]initWithKey:@"score" ascending:YES];
    }
    else if(sortStyle == scoreAsc){
        sortStyle = scoreDesc;
        scoreSort = [[NSSortDescriptor alloc]initWithKey:@"score" ascending:NO];
    }
    tableArray  = [tableArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:scoreSort]];
    [delegate reloadItemTable];
}

- (void) sortByAssigned{
    
}

@end
