//
//  AppDelegate.h
//  SSDataManager
//
//  Created by Susim on 10/31/13.
//  Copyright (c) 2013 Susim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersistentStack.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, strong) PersistentStack* persistentStack;
- (NSURL*)modelURL;
@end
