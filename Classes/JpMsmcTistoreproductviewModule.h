/**
 * Your Copyright Here
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import <StoreKit/StoreKit.h>
#import "TiModule.h"

@interface JpMsmcTistoreproductviewModule : TiModule <SKStoreProductViewControllerDelegate>
{
    SKStoreProductViewController *storeProductViewController;
    BOOL storeProductViewControllerAppId;
    BOOL storeProductViewControllerAnimated;
}
- (void)showApp:(id)args;
@end
