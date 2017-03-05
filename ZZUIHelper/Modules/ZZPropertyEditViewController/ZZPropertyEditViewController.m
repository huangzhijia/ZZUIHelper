//
//  ZZPropertyEditViewController.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/21.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZPropertyEditViewController.h"
#import "ZZPropertyEditViewController+Delegate.h"
#import "ZZUIControl.h"

@interface ZZPropertyEditViewController ()

@end

@implementation ZZPropertyEditViewController

- (void)loadView
{
    [super loadView];
    
    [self.collectionView setWantsLayer:YES];
    [self.collectionView.layer setBackgroundColor:[NSColor windowBackgroundColor].CGColor];
    
    [self registerViewsForCollectionView:self.collectionView];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(editProperty:) name:NOTI_CLASS_PROPERTY_CHANGED object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(editProperty:) name:NOTI_CLASS_PROPERTY_SELECTED object:nil];
}

- (void)viewWillLayout
{
    [super viewWillLayout];
    
    [self.collectionView reloadData];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)editProperty:(NSNotification *)notification
{
    ZZNSObject *object = notification.object;
    
    NSMutableArray *data = [[NSMutableArray alloc] init];
    
    // Properties
    if (object.properties.count > 0) {
        for (ZZPropertyGroup *group in object.properties) {
            if (group.properties.count > 0) {
                ZZPropertySectionModel *classSection = [[ZZPropertySectionModel alloc] initWithSectionType:ZZPropertySectionTypeProperty title:group.groupName andData:group.properties];
                [data insertObject:classSection atIndex:0];
            }
        }
    }
    
    // Events
    if ([[object class] isSubclassOfClass:[ZZUIControl class]] && [(ZZUIControl *)object events].count > 0) {
        ZZPropertySectionModel *eventsMethods = [[ZZPropertySectionModel alloc] initWithSectionType:ZZPropertySectionTypeEvent title:@"Events" andData:[(ZZUIControl *)object events]];
        [data addObject:eventsMethods];
    }
    
    // Delegates
    for (ZZProtocol *protocol in [object delegates]) {
        ZZPropertySectionModel *protocolMethods = [[ZZPropertySectionModel alloc] initWithSectionType:ZZPropertySectionTypeDelegate title:protocol.protocolName andData:protocol.protocolMethods];
        [data addObject:protocolMethods];
    }
    
    
    self.object = object;
    self.data = data;
    [self.collectionView reloadData];
}


@end
