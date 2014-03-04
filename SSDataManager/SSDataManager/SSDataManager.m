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
@end
