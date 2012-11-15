/**
 * MARSHMALLOW MACHINE 2012. All rights reseverd.
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "JpMsmcTistoreproductviewModule.h"
#import "TiApp.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"

@implementation JpMsmcTistoreproductviewModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"d33f3016-f880-4204-864e-64e524a57292";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"jp.msmc.tistoreproductview";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];
	
	NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably
	
	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup 

-(void)dealloc
{
    RELEASE_TO_NIL(storeProductViewController);
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
	if (count == 1 && [type isEqualToString:@"my_event"])
	{
		// the first (of potentially many) listener is being added 
		// for event named 'my_event'
	}
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
	if (count == 0 && [type isEqualToString:@"my_event"])
	{
		// the last listener called for event named 'my_event' has
		// been removed, we can optionally clean up any resources
		// since no body is listening at this point for that event
	}
}

- (void)loadApp:(int)appId animated:(BOOL)animated
{
    NSDictionary *parameters = @{ SKStoreProductParameterITunesItemIdentifier:[NSNumber numberWithInt:appId] };

    RELEASE_TO_NIL(storeProductViewController);
    storeProductViewController = [[SKStoreProductViewController alloc] init];
    storeProductViewController.delegate = self;

    storeProductViewControllerAppId = appId;
    storeProductViewControllerAnimated = animated;
    
    NSLog(@"[DEBUG] loading:%d...", appId);
    [storeProductViewController loadProductWithParameters:parameters completionBlock:^(BOOL result, NSError *error){
        if(result)
        {
            NSLog(@"[DEBUG] successfully loaded.");
            TiApp * tiApp = [TiApp app];
            
            if ([TiUtils isIPad] == NO)
            {
                [[tiApp controller] manuallyRotateToOrientation:UIInterfaceOrientationPortrait
                                                       duration:0.0];
            }
            [tiApp showModalController:storeProductViewController
                              animated:storeProductViewControllerAnimated];
            [self fireEvent:@"success" withObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                                   [NSNumber numberWithInt:appId], @"appId", nil]];
        }
        else
        {
            NSLog(@"[DEBUG] an error occurred.");
            [self fireEvent:@"error" withObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                                 [NSNumber numberWithInt:appId], @"appId",
                                                 [error description], @"error", nil]];
        }
    }];    
}

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController
{
    TiApp * tiApp = [TiApp app];
    
    [tiApp hideModalController:storeProductViewController
                      animated:storeProductViewControllerAnimated];

    [self fireEvent:@"closed" withObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                         [NSNumber numberWithInt:storeProductViewControllerAppId], @"appId", nil]];
}

#pragma Public APIs
- (void)showApp:(id)args
{
    ENSURE_UI_THREAD_1_ARG(args);
    ENSURE_SINGLE_ARG(args, NSDictionary);
    
    int appId = [[args objectForKey:@"appId"] intValue];
    BOOL animated = YES;    
    if([args objectForKey:@"animated"]){
        animated = [[args objectForKey:@"animated"] boolValue];
    }
    
    if([args objectForKey:@"success"]){
    }
    
    [self loadApp:appId animated:animated];
}

@end
