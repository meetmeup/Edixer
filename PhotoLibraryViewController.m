//
//  PhotoLibraryViewController.m
//  Edixer
//
//  Created by tnylee's iMac on 11/28/2557 BE.
//  Copyright (c) 2557 tnylee's iMac. All rights reserved.
//

#import "PhotoLibraryViewController.h"
#import "CustomIOS7AlertView.h"
#import "EditWithStickerViewController.h"

/*helpers*/
#import "MFSideMenu.h"
#import "CTAssetsPickerController.h"

/*define*/
#define PHOTO_LIB_ASSETS @"photoLibraryAssets"

@interface PhotoLibraryViewController ()<CTAssetsPickerControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, CustomIOS7AlertViewDelegate>
{
    CustomIOS7AlertView *photoEditCustomAlertView;
}

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

#pragma mark - collection view properties
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.assets.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    NSArray *assets = [userDefaults objectForKey:PHOTO_LIB_ASSETS];
    
    ALAsset *asset = [self.assets objectAtIndex:indexPath.row];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithCGImage:asset.thumbnail]];
    [cell setBackgroundView:imageView];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width/3, self.view.frame.size.width/3);
}

- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0); // top, left, bottom, right
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{    
    return 0.0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // Here we need to pass a full frame
    photoEditCustomAlertView = [[CustomIOS7AlertView alloc] init];
    
    // Add some custom content to the alert view
    [photoEditCustomAlertView setContainerView:[self createPhotoEditMenu]];
    
    // Modify the parameters
    [photoEditCustomAlertView setButtonTitles:[NSMutableArray arrayWithObjects:@"Cancel", nil]];
    [photoEditCustomAlertView setDelegate:self];
    
    // You may use a Block, rather than a delegate.
    [photoEditCustomAlertView setOnButtonTouchUpInside:^(CustomIOS7AlertView *alertView, int buttonIndex) {
        NSLog(@"Block: Button at position %d is clicked on alertView %d.", buttonIndex, (int)[alertView tag]);
        [alertView close];
    }];
    
    [photoEditCustomAlertView setUseMotionEffects:true];
    
    // And launch the dialog
    [photoEditCustomAlertView show];
}

#pragma mark - alert view content
- (UIView *)createPhotoEditMenu
{
    UIView *createPhotoEditMenuView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 290, 210)];
    
    UIButton *editWithStickerButton         = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 270, 60)];
    [editWithStickerButton setImage:[UIImage imageNamed:@"tester.png"] forState:UIControlStateNormal];
    [editWithStickerButton setTitle:@"edit" forState:UIControlStateNormal];
    [editWithStickerButton addTarget:self action:@selector(editPhoto) forControlEvents:UIControlEventTouchUpInside];
    [createPhotoEditMenuView addSubview:editWithStickerButton];
    
    UIButton *deletePhotoButton         = [[UIButton alloc] initWithFrame:CGRectMake(10, 70, 270, 60)];
    [deletePhotoButton setImage:[UIImage imageNamed:@"tester.png"] forState:UIControlStateNormal];
    [deletePhotoButton setTitle:@"delete" forState:UIControlStateNormal];
    [deletePhotoButton addTarget:self action:@selector(deletePhoto) forControlEvents:UIControlEventTouchUpInside];
    [createPhotoEditMenuView addSubview:deletePhotoButton];

    UIButton *exportPhotoButton         = [[UIButton alloc] initWithFrame:CGRectMake(10, 130, 270, 60)];
    [exportPhotoButton setImage:[UIImage imageNamed:@"tester.png"] forState:UIControlStateNormal];
    [exportPhotoButton setTitle:@"export" forState:UIControlStateNormal];
    [exportPhotoButton addTarget:self action:@selector(exportPhoto) forControlEvents:UIControlEventTouchUpInside];
    [createPhotoEditMenuView addSubview:exportPhotoButton];
    
    return createPhotoEditMenuView;
}

#pragma mark - custom alert view delegate
- (void)customIOS7dialogButtonTouchUpInside: (CustomIOS7AlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    NSLog(@"Delegate: Button at position %d is clicked on alertView %d.", (int)buttonIndex, (int)[alertView tag]);
    [alertView close];
}

#pragma mark - Assets Picker Delegate
- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker isDefaultAssetsGroup:(ALAssetsGroup *)group
{
    return ([[group valueForProperty:ALAssetsGroupPropertyType] integerValue] == ALAssetsGroupSavedPhotos);
}

- (void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    
    [picker.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
    self.assets = [NSMutableArray arrayWithArray:assets];
//    [self saveAssetDataArray:self.assets];
    
    [self.collectionView reloadData];
}

- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldSelectAsset:(ALAsset *)asset
{
    if (picker.selectedAssets.count >= 10)
    {
        UIAlertView *alertView =
        [[UIAlertView alloc] initWithTitle:@"Attention"
                                   message:@"Please select not more than 10 photos"
                                  delegate:nil
                         cancelButtonTitle:nil
                         otherButtonTitles:@"OK", nil];
        
        [alertView show];
    }
    
    if (!asset.defaultRepresentation)
    {
        UIAlertView *alertView =
        [[UIAlertView alloc] initWithTitle:@"Attention"
                                   message:@"Your asset has not yet been downloaded to your device"
                                  delegate:nil
                         cancelButtonTitle:nil
                         otherButtonTitles:@"OK", nil];
        
        [alertView show];
    }
    
    return (picker.selectedAssets.count < 10 && asset.defaultRepresentation != nil);
}

#pragma mark - edit photo button
- (void) editPhoto
{
    [photoEditCustomAlertView close];
    EditWithStickerViewController *editWithStickerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"editWithStickerView"];
    [self presentViewController:editWithStickerViewController animated:YES completion:nil];
}

- (void) deletePhoto
{
    
}

- (void) exportPhoto
{
    
}

#pragma mark - save assets onto device
//- (void)saveAssetDataArray:(NSArray *)assets {
//    
//    NSMutableArray *archiveArray = [NSMutableArray arrayWithCapacity:assets.count];
//    for (ALAsset *asset in assets) {
//        NSData *assetData = [NSKeyedArchiver archivedDataWithRootObject:asset];
//        [archiveArray addObject:assetData];
//    }
//    
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    [userDefaults setObject:archiveArray forKey:PHOTO_LIB_ASSETS];
//}

@end
