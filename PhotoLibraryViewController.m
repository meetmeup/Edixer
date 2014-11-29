//
//  PhotoLibraryViewController.m
//  Edixer
//
//  Created by tnylee's iMac on 11/28/2557 BE.
//  Copyright (c) 2557 tnylee's iMac. All rights reserved.
//

#import "PhotoLibraryViewController.h"

/*helpers*/
#import "MFSideMenu.h"
#import "CTAssetsPickerController.h"

@interface PhotoLibraryViewController ()<CTAssetsPickerControllerDelegate>

@property (nonatomic, copy) NSArray *assets;

@end

@implementation PhotoLibraryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /*Adding navigation bar buttons*/
    [self setupleftSideeMenuButton];
    [self setupImportPhotosButton];
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

- (void) setupImportPhotosButton
{
    /*Adding middle bar button item*/
    UIButton *middlePhotoImportButton = [UIButton buttonWithType:UIButtonTypeCustom];
    middlePhotoImportButton.frame = CGRectMake(0, 0, 48, 37);
    [middlePhotoImportButton addTarget:self action:@selector(ImportPhotosClicked) forControlEvents:UIControlEventTouchUpInside];
    middlePhotoImportButton.showsTouchWhenHighlighted = YES;
    [middlePhotoImportButton setImage:[UIImage imageNamed:@"tester.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem *middlePhotoImportBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:middlePhotoImportButton];
//    self.navigationItem.leftBarButtonItem = leftSideeMenuBarButtonItem;
    self.navigationItem.titleView = middlePhotoImportButton;
}

#pragma mark - navigation bar button handlers
- (void) leftSideeMenuButtonClicked
{
    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
}

- (void) ImportPhotosClicked
{
    [self createPhotoLibrary];
}

#pragma mark - create photo library
- (void) createPhotoLibrary
{
    CTAssetsPickerController *picker = [[CTAssetsPickerController alloc] init];
    picker.assetsFilter         = [ALAssetsFilter allPhotos];
    picker.showsCancelButton    = YES;
    picker.delegate             = self;
    picker.selectedAssets       = [NSMutableArray arrayWithArray:self.assets];
    [self presentViewController:picker animated:YES completion:nil];
}


@end
