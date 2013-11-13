
    //
//  AppDelegate.m
//  SSDataManager
//
//  Created by Susim on 10/31/13.
//  Copyright (c) 2013 Susim. All rights reserved.
//

#import "AppDelegate.h"
#import "PersistentStack.h"
#import "Employee.h"
@interface AppDelegate ()

@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, strong) PersistentStack* persistentStack;

@end
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.persistentStack = [[PersistentStack alloc] initWithStoreURL:self.storeURL modelURL:self.modelURL];
    self.managedObjectContext = self.persistentStack.managedObjectContext;


    return YES;
}
- (void)addEmp {
    Employee *emp = [NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:self.managedObjectContext];
     emp.empId = @"1";
     emp.empName = @"Susim";
     NSError *error;
     [self.managedObjectContext save:&error];
     if (error) {
     NSLog(@"%@",error);
     }
}
- (void)fetchEmp {
    NSManagedObjectModel* model = [[NSManagedObjectModel alloc] initWithContentsOfURL:self.modelURL];
    NSFetchRequest *fetchRequest = [model fetchRequestTemplateForName:@"allEmployeeFetchRequest"];
    NSSortDescriptor* sortDescriptors = [NSSortDescriptor sortDescriptorWithKey:@"empId" ascending:YES];
    [fetchRequest setSortDescriptors:@[sortDescriptors]];
    NSFetchedResultsController* controller = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                                 managedObjectContext:self.managedObjectContext
                                                                                   sectionNameKeyPath:nil
                                                                                            cacheName:nil];
    NSError *error ;
    [controller performFetch:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    NSArray *list = controller.fetchedObjects;
    Employee *emp = list[0];
    NSLog(@"%@ %@",emp.empId,emp.empName);
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (NSURL*)storeURL
{
    NSURL* documentsDirectory = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:NULL];
    return [documentsDirectory URLByAppendingPathComponent:@"MyApp.sqlite"];
}

- (NSURL*)modelURL
{
    return [[NSBundle mainBundle] URLForResource:@"MyAppModel" withExtension:@"momd"];
}
@end
