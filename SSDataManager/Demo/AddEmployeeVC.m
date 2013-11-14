//
//  AddEmployeeVC.m
//  SSDataManager
//
//  Created by Susim on 11/14/13.
//  Copyright (c) 2013 Susim. All rights reserved.
//

#import "AddEmployeeVC.h"
#import "Employee.h"
#import "AppDelegate.h"

@interface AddEmployeeVC ()
@property (weak,nonatomic) IBOutlet UITextField *empIdTf;
@property (weak,nonatomic) IBOutlet UITextField *empNameTf;
@property (weak,nonatomic) IBOutlet UILabel *statusLbl;
@end

@implementation AddEmployeeVC

#pragma mark View liefecycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)addEmp:(id)sender {
    [self addEmployeeWithEmpID:self.empIdTf.text empName:self.empNameTf.text];
    [self.empNameTf resignFirstResponder];
}
#pragma mark Core Data task
- (void)addEmployeeWithEmpID:(NSString *)empId empName:(NSString *)empName {
	AppDelegate *appDel = (AppDelegate *)[[UIApplication sharedApplication] delegate];
   	Employee *emp = [NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:appDel.managedObjectContext];
    emp.empId = empId;
    emp.empName = empName;
    NSError *error;
    [appDel.managedObjectContext save:&error];
    if (error) {
        NSLog(@"%@",error);
    }else {
        self.statusLbl.text = @"Info Saved";
    }
}
@end
