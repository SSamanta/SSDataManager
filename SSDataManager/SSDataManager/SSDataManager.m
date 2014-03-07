//
//  SSDataManager.m
//  SSDataManager
//
//  Created by Susim on 10/31/13.
//  Copyright (c) 2013 Susim. All rights reserved.
//

#import "SSDataManager.h"
#import "AppDelegate.h"
#import "Employee.h"

@implementation SSDataManager
+ (void)addEmployeeWithEmpID:(NSString *)empId empName:(NSString *)empName onCompletion:(CompletionHandler)handler {
	AppDelegate *appDel = (AppDelegate *)[[UIApplication sharedApplication] delegate];
   	Employee *emp = [NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:appDel.managedObjectContext];
    emp.empId = empId;
    emp.empName = empName;
    NSError *error;
    [appDel.managedObjectContext save:&error];
    if (error) {
        handler (nil,error);
    }else {
        handler (@"Info Saved" ,nil);
    }

}
+ (void)fetchAllEmployeeOnCompletion:(CompletionHandler)handler {
    AppDelegate *appDel = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectModel* model = [[NSManagedObjectModel alloc] initWithContentsOfURL:appDel.modelURL];
    NSFetchRequest *fetchRequest = [model fetchRequestTemplateForName:@"allEmployeeFetchRequest"];
    NSSortDescriptor* sortDescriptors = [NSSortDescriptor sortDescriptorWithKey:@"empId" ascending:YES];
    [fetchRequest setSortDescriptors:@[sortDescriptors]];
    NSFetchedResultsController *fetchResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:appDel.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    NSError *error ;
    [fetchResultsController performFetch:&error];
    if (error) {
        handler (nil,error);
    }else {
    	handler (fetchResultsController,nil);
    }
    
}
+ (void)deleteDuplicateEmployee {
    [self fetchAllEmployeeOnCompletion:^(NSFetchedResultsController *fetchResultsController, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }else {
            NSMutableArray *list = [[NSMutableArray alloc] init];
            AppDelegate *appDel = (AppDelegate *) [[UIApplication sharedApplication]delegate];
            [fetchResultsController.fetchedObjects enumerateObjectsUsingBlock:^(Employee *empObj, NSUInteger idx, BOOL *stop) {
                [list addObject:empObj];
            }];
            [list enumerateObjectsUsingBlock:^(Employee *empObj, NSUInteger idx, BOOL *stop) {
                if (idx+1 == list.count) {
                    *stop = YES;
                }else {
                    Employee *nextObj = list [idx +1];
                    if ([nextObj.empId isEqualToString:empObj.empId] && [nextObj.empName isEqualToString:empObj.empName]) {
                        [appDel.managedObjectContext deleteObject:empObj];
                    }
                }
            }];
            NSError *error;
            [appDel.managedObjectContext save:&error];
        }
    }];
}
@end
