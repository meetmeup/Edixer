//
//  LeftSideMenuViewController.m
//  Edixer
//
//  Created by tnylee's iMac on 11/28/2557 BE.
//  Copyright (c) 2557 tnylee's iMac. All rights reserved.
//

#import "LeftSideMenuViewController.h"
#import "ShopViewController.h"
#import "PhotoLibraryViewController.h"
#import "SettingsViewController.h"

#import "MFSideMenu.h"

@interface LeftSideMenuViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    /*menu icon normal image name*/
    NSArray *sideMenuImageArray;
    /*menu icon highlighted image name*/
    NSArray *sideMenuImageHighlightArray;
}

@end

@implementation LeftSideMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    sideMenuImageArray = [[NSArray alloc] initWithObjects:@"tester.png", @"tester.png", @"tester.png", nil];
    sideMenuImageHighlightArray = [[NSArray alloc] initWithObjects:@"tester2.png", @"tester2.png", @"tester2.png", nil];
    
    /*set up table view properties*/
    self.tableView.scrollEnabled = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


//- (IBAction)buttonClicked:(id)sender
//{
//    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed completion:^{}];
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        // allocate the cell:
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        UIButton *sideMenuButton = [[UIButton alloc] init];
        [sideMenuButton addTarget:self action:@selector(menuButtonClickedWithIndex:) forControlEvents:UIControlEventTouchUpInside];
        [sideMenuButton setTag:1];
        [cell.contentView addSubview:sideMenuButton];
    }
    
    UIImage *sideMenuImageForRow = [UIImage imageNamed:[sideMenuImageArray objectAtIndex:indexPath.row]];
    UIImage *sideMenuImageForRowHighlighted = [UIImage imageNamed:[sideMenuImageHighlightArray objectAtIndex:indexPath.row]];
    [(UIButton *) [cell.contentView viewWithTag:1] setFrame:CGRectMake((120.0f/2) - (sideMenuImageForRow.size.width/2), ((self.view.frame.size.height/3)/2) - (sideMenuImageForRow.size.height/2), sideMenuImageForRow.size.height, sideMenuImageForRow.size.height)];
    [(UIButton *) [cell.contentView viewWithTag:1] setImage:sideMenuImageForRow forState:UIControlStateNormal];
    [(UIButton *) [cell.contentView viewWithTag:1] setImage:sideMenuImageForRowHighlighted forState:UIControlStateHighlighted];
    [(UIButton *) [cell.contentView viewWithTag:1] setTitle:[NSString stringWithFormat:@"%lu",indexPath.row] forState:UIControlStateNormal];
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.frame.size.height/3;
}

#pragma mark - menu button clicked
- (void) menuButtonClickedWithIndex:(id)sender
{
    UIButton *button = (UIButton*)sender;
    
#pragma switch view back
    
    /*switching view back*/
    if ([button.titleLabel.text intValue] == 0)
    {
        PhotoLibraryViewController *photoLibraryViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"photoLibraryView"];
        
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        NSArray *controllers = [NSArray arrayWithObject:photoLibraryViewController];
        navigationController.viewControllers = controllers;
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
    }
    else if ([button.titleLabel.text intValue] == 1)
    {
        ShopViewController *shopViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"shopView"];
        
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        NSArray *controllers = [NSArray arrayWithObject:shopViewController];
        navigationController.viewControllers = controllers;
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
    }
    else
    {
        SettingsViewController *settingsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"settingsView"];
        
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        NSArray *controllers = [NSArray arrayWithObject:settingsViewController];
        navigationController.viewControllers = controllers;
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
    }
}

@end
