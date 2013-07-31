/**
 * Your Copyright Here
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "ComApptentiveTitaniumModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import "TiApp.h"
#import "ATConnect.h"
#import "ATAppRatingFlow.h"
#import "ATSurveys.h"

@implementation ComApptentiveTitaniumModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"c103d324-0b82-4f61-92dc-9becc11d790b";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"com.apptentive.titanium";
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

#pragma mark Apptentive Shared Features

- (id)apiKey:(id)args
{
    return [[ATConnect sharedConnection] apiKey];
}

- (void)setApiKey:(id)args
{
    ENSURE_SINGLE_ARG(args, NSString);
    NSString *apiKey = [TiUtils stringValue:args];
    [[ATConnect sharedConnection] setApiKey:apiKey];
}

- (id)initialUserName:(id)args
{
    return [[ATConnect sharedConnection] initialUserName];
}

- (void)setInitialUserName:(id)args
{
    ENSURE_SINGLE_ARG(args, NSString);
    NSString *initialUserName = [TiUtils stringValue:args];
    [[ATConnect sharedConnection] setInitialUserName:initialUserName];
}

- (id)initialUserEmailAddress:(id)args
{
    return [[ATConnect sharedConnection] initialUserEmailAddress];
}

- (void)setInitialUserEmailAddress:(id)args {
    ENSURE_SINGLE_ARG(args, NSString);
    NSString *initialUserEmailAddress = [TiUtils stringValue:args];
    [[ATConnect sharedConnection] setInitialUserEmailAddress:initialUserEmailAddress];
}

- (void)addCustomDataWithKey:(id)args
{
    NSObject<NSCoding> *data = [((NSArray *)args) objectAtIndex:0];
    NSString *key = [((NSArray *)args) objectAtIndex:1];
    [[ATConnect sharedConnection] addCustomData:data withKey:key];
}

- (void)removeCustomDataWithKey:(id)args
{
    ENSURE_SINGLE_ARG(args, NSString);
    NSString *key = [TiUtils stringValue:args];
    [[ATConnect sharedConnection] removeCustomDataWithKey:key];
}

#pragma mark Message Center

- (void)presentMessageCenter:(id)args
{
    ENSURE_UI_THREAD_0_ARGS;
    [[ATConnect sharedConnection] presentMessageCenterFromViewController:[TiApp app].controller];
}

- (id)unreadMessageCount:(id)args
{
    NSUInteger *count = [[ATConnect sharedConnection] unreadMessageCount];
    return [NSNumber numberWithInt:count];
}

#pragma mark Ratings Flow

- (void)showRatingFlowIfConditionsAreMet:(id)args
{
    ENSURE_UI_THREAD_0_ARGS;
    [[ATAppRatingFlow sharedRatingFlow] showRatingFlowFromViewControllerIfConditionsAreMet:[[TiApp app] controller]];
}

- (void)logSignificantEvent:(id)args
{
    [[ATAppRatingFlow sharedRatingFlow] logSignificantEvent];
}

#pragma mark - Surveys

- (id)hasSurveyAvailableWithNoTags:(id)args
{
    BOOL hasSurvey = [ATSurveys hasSurveyAvailableWithNoTags];
    return [NSNumber numberWithBool:hasSurvey];
}

- (id)hasSurveyAvailableWithTags:(id)args
{
    NSSet *tags = [NSSet setWithArray:args];
    BOOL hasSurvey = [ATSurveys hasSurveyAvailableWithTags:tags];
    return [NSNumber numberWithBool:hasSurvey];
}

- (void)presentSurveyControllerWithNoTags:(id)args
{
    ENSURE_UI_THREAD_0_ARGS
    [ATSurveys presentSurveyControllerWithNoTagsFromViewController:[[TiApp app] controller]];
}

- (void)presentSurveyControllerWithTags:(id)args
{
    ENSURE_UI_THREAD_1_ARG(args)
    NSSet *tags = [NSSet setWithArray:args];
    [ATSurveys presentSurveyControllerWithTags:tags fromViewController:[[TiApp app] controller]];
}

#pragma Public APIs

-(id)example:(id)args
{
	// example method
    return @"hello world";
}

-(id)exampleProp
{
	// example property getter
	return @"hello world";
}

-(void)setExampleProp:(id)value
{
	// example property setter
}

@end
