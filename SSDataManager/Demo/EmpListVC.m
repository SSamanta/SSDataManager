//
//  EmpListVC.m
//  SSDataManager
//
//  Created by Susim on 11/14/13.
//  Copyright (c) 2013 Susim. All rights reserved.
//

#import "EmpListVC.h"
#import "AppDelegate.h"
#import "Employee.h"
#import "SSDataManager.h"

@interface EmpListVC ()
@property (weak,nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSFetchedResultsController* fetchResultsController;
@end

@implementation EmpListVC

- (void)viewDidLoad {
    [super viewDidLoad];
	[SSDataManager fetchAllEmployeeOnCompletion:^(id object, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }else {
            self.fetchResultsController = object;
            [self.tableView reloadData];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark Table View Data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.fetchResultsController.fetchedObjects.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EmpCell"];
    Employee *emp = self.fetchResultsController.fetchedObjects[indexPath.row];
    cell.textLabel.text = emp.empName;
    cell.detailTextLabel.text = emp.empId;
    return cell;
}
@end
