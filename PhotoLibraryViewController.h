//
//  PhotoLibraryViewController.h
//  Edixer
//
//  Created by tnylee's iMac on 11/28/2557 BE.
//  Copyright (c) 2557 tnylee's iMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoLibraryCollectionView.h"

@interface PhotoLibraryViewController : UIViewController
@property (weak, nonatomic) IBOutlet PhotoLibraryCollectionView *collectionView;

@end
