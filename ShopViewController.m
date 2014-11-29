//
//  ShopViewController.m
//  Edixer
//
//  Created by tnylee's iMac on 11/29/2557 BE.
//  Copyright (c) 2557 tnylee's iMac. All rights reserved.
//

#import "ShopViewController.h"
#import "MFSideMenu.h"

@interface ShopViewController ()

@end

@implementation ShopViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupleftSideeMenuButton];
}

#pragma mark - navigation bar button set up
-(void)setupleftSideeMenuButton
{
    /*Adding left bar button item*/
    UIButton *leftSideeMenuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftSideeMenuButton.frame = CGRectMake(0, 0, 48, 37);
    [leftSideeMenuButton addTarget:self action:@selector(leftSideeMenuButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    leftSideeMenuButton.showsTouchWhenHighlighted = YES;
    [leftSideeMenuButton setImage:[UIImage imageNamed:@"tester.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem *leftSideeMenuBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftSideeMenuButton];
    self.navigationItem.leftBarButtonItem = leftSideeMenuBarButtonItem;
}

#pragma mark - navigation bar button handlers
- (void) leftSideeMenuButtonClicked
{
    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
}


@end
