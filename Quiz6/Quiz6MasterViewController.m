//
//  Quiz6MasterViewController.m
//  Quiz6
//
//  Created by Moser, Wesley on 3/28/14.
//  Copyright (c) 2014 Moser, Wesley. All rights reserved.
//

#import "Quiz6MasterViewController.h"
#import "Quiz6DetailViewController.h"
#import "Task.h"

@interface Quiz6MasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation Quiz6MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    
    Task *newTask = [[Task alloc] init];
    [_objects addObject:newTask];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    Quiz6DetailViewController *dvc = [storyboard instantiateViewControllerWithIdentifier:@"Quiz6DetailViewController"];
    [dvc setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    dvc.detailItem = newTask;
    dvc.dismissBlock = ^{
        [[self tableView] reloadData];
    };
    [self presentViewController:dvc animated:YES completion:nil];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    Task *object = _objects[indexPath.row];
    cell.textLabel.text = object.name;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterLongStyle];
    cell.detailTextLabel.text =
        [NSString stringWithFormat:@"%@ (%.0f)",
            [formatter stringFromDate:object.dueDate], object.urgency];
    
    if ((object.urgency + .5) < 9)
        [cell.textLabel setTextColor:[UIColor greenColor]];
    else
        [cell.textLabel setTextColor:[UIColor redColor]];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Task *task = [_objects objectAtIndex:[indexPath row]];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    Quiz6DetailViewController *dvc = [storyboard instantiateViewControllerWithIdentifier:@"Quiz6DetailViewController"];
    [dvc setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    dvc.detailItem = task;
    dvc.dismissBlock = ^{
        [[self tableView] reloadData];
    };
    [self presentViewController:dvc animated:YES completion:nil];
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return NO;
}

@end
