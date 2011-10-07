/**
 * Your Copyright Here
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "TiSmsviewModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"

@implementation TiSmsviewModule

MAKE_SYSTEM_PROP(RETURNKEY_DEFAULT,UIReturnKeyDefault);
MAKE_SYSTEM_PROP(RETURNKEY_GO,UIReturnKeyGo);
MAKE_SYSTEM_PROP(RETURNKEY_GOOGLE,UIReturnKeyGoogle);
MAKE_SYSTEM_PROP(RETURNKEY_JOIN,UIReturnKeyJoin);
MAKE_SYSTEM_PROP(RETURNKEY_NEXT,UIReturnKeyNext);
MAKE_SYSTEM_PROP(RETURNKEY_ROUTE,UIReturnKeyRoute);
MAKE_SYSTEM_PROP(RETURNKEY_SEARCH,UIReturnKeySearch);
MAKE_SYSTEM_PROP(RETURNKEY_SEND,UIReturnKeySend);
MAKE_SYSTEM_PROP(RETURNKEY_YAHOO,UIReturnKeyYahoo);
MAKE_SYSTEM_PROP(RETURNKEY_DONE,UIReturnKeyDone);
MAKE_SYSTEM_PROP(RETURNKEY_EMERGENCY_CALL,UIReturnKeyEmergencyCall);

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"701fef48-47e8-4eb3-bb02-d66bb240a8a9";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"ti.Smsview";
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
	// release any resources that have been retained by the module
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

@end
