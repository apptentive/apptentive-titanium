/**
 * Copyright 2013 Apptentive, Inc.. All rights reserved.
 *
 * Created by Peter Kamb on 7/30/13.
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
    
    //Apptentive
    ATConnect *connection __attribute__((unused)) = [ATConnect sharedConnection];
    
    //Message Center Notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(unreadMessageCountChanged:) name:ATMessageCenterUnreadCountChangedNotification object:nil];
        
    //Survey Notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(surveyBecameAvailable:) name:ATSurveyNewSurveyAvailableNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(surveyWasSent:) name:ATSurveySentNotification object:nil];
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably
	
	// you *must* call the superclass
	[super shutdown:sender];
    
    //Apptentive
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ATMessageCenterUnreadCountChangedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ATSurveyNewSurveyAvailableNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ATSurveySentNotification object:nil];
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
    if ([type isEqualToString:ATMessageCenterUnreadCountChangedNotification]) {
        NSLog(@"[INFO] Added listener for Apptentive Message Center unread count.");
    }
    
    if ([type isEqualToString:ATSurveyNewSurveyAvailableNotification]) {
        NSLog(@"[INFO] Added listener for new Apptentive surveys.");
    }
    
    if ([type isEqualToString:ATSurveySentNotification]) {
        NSLog(@"[INFO] Added listener for Apptentive survey send events.");
    }
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
    if ([type isEqualToString:ATMessageCenterUnreadCountChangedNotification]) {
        NSLog(@"[INFO] Removed listener for Apptentive Message Center unread count.");
    }
    
    if ([type isEqualToString:ATSurveyNewSurveyAvailableNotification]) {
        NSLog(@"[INFO] Removed listener for new Apptentive surveys.");
    }
    
    if ([type isEqualToString:ATSurveySentNotification]) {
        NSLog(@"[INFO] Removed listener for Apptentive survey send events.");
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

- (void)setInitialUserEmailAddress:(id)args
{
    ENSURE_SINGLE_ARG(args, NSString);
    NSString *initialUserEmailAddress = [TiUtils stringValue:args];
    [[ATConnect sharedConnection] setInitialUserEmailAddress:initialUserEmailAddress];
}

- (void)addCustomPersonData:(id)args
{
    NSObject<NSCoding> *data = [((NSArray *)args) objectAtIndex:0];
    NSString *key = [((NSArray *)args) objectAtIndex:1];
    [[ATConnect sharedConnection] addCustomPersonData:data withKey:key];
}

- (void)removeCustomPersonDataWithKey:(id)args
{
    ENSURE_SINGLE_ARG(args, NSString);
    NSString *key = [TiUtils stringValue:args];
    [[ATConnect sharedConnection] removeCustomPersonDataWithKey:key];
}

- (void)addCustomDeviceData:(id)args
{
    NSObject<NSCoding> *data = [((NSArray *)args) objectAtIndex:0];
    NSString *key = [((NSArray *)args) objectAtIndex:1];
    [[ATConnect sharedConnection] addCustomDeviceData:(NSString *)data withKey:key];
}

- (void)removeCustomDeviceDataWithKey:(id)args
{
    ENSURE_SINGLE_ARG(args, NSString);
    NSString *key = [TiUtils stringValue:args];
    [[ATConnect sharedConnection] removeCustomDeviceDataWithKey:key];
}

- (void)addIntegrationWithConfiguration:(id)args
{
    NSString *integration = [((NSArray *)args) objectAtIndex:0];
    NSDictionary *configuration = [((NSArray *)args) objectAtIndex:1];
    [[ATConnect sharedConnection] addIntegration:integration withConfiguration:configuration];
}

- (void)removeIntegration:(id)args
{
    ENSURE_SINGLE_ARG(args, NSString);
    NSString *integration = [TiUtils stringValue:args];
    [[ATConnect sharedConnection] removeIntegration:integration];
}

#pragma mark Message Center

- (void)presentMessageCenter:(id)args
{
    ENSURE_UI_THREAD_0_ARGS;
    [[ATConnect sharedConnection] presentMessageCenterFromViewController:[TiApp app].controller];
}

- (void)presentMessageCenterWithCustomData:(id)args
{
    ENSURE_UI_THREAD_1_ARG(args);
    NSDictionary *customData = [((NSArray *)args) objectAtIndex:0];
    [[ATConnect sharedConnection] presentMessageCenterFromViewController:[TiApp app].controller withCustomData:customData];
}

- (id)unreadMessageCount:(id)args
{
    int *count = (int)[[ATConnect sharedConnection] unreadMessageCount];
    return [NSNumber numberWithInt:count];
}

- (void)unreadMessageCountChanged:(NSNotification *)notification
{
    if ([self _hasListeners:ATMessageCenterUnreadCountChangedNotification]) {
        [self fireEvent:ATMessageCenterUnreadCountChangedNotification withObject:notification.userInfo];
    }
}

#pragma mark Engagement

- (void)engageCodePoint:(id)args
{
    ENSURE_UI_THREAD_1_ARG(args);
    ENSURE_SINGLE_ARG(args, NSString);
    NSString *codePoint = [TiUtils stringValue:args];
    [[ATConnect sharedConnection] engage:codePoint fromViewController:[TiApp app].controller];
}

#pragma mark Ratings Flow

- (void)setAppID:(id)args
{
    ENSURE_SINGLE_ARG(args, NSString);
    NSString *appID = [TiUtils stringValue:args];
    [[ATAppRatingFlow sharedRatingFlow] setAppID:appID];
}

- (void)showRatingFlowIfConditionsAreMet:(id)args
{
    ENSURE_UI_THREAD_0_ARGS;
    BOOL shown = [[ATAppRatingFlow sharedRatingFlow] showRatingFlowFromViewControllerIfConditionsAreMet:[[TiApp app] controller]];
    
    // ENSURE_UI_THREAD_0_ARGS;
    // Docs say: "You can only use this method if you have no return result."
    // http://developer.appcelerator.com/question/161830/alternative-to-ensureuithread0args-when-proxy-method-returns-a-value
    
    // Thus we can't return `shown` until we find an alternative.
    //return [NSNumber numberWithBool:shown];
}

- (void)logSignificantEvent:(id)args
{
    [[ATAppRatingFlow sharedRatingFlow] logSignificantEvent];
}

- (void)openAppStore:(id)args
{
    ENSURE_UI_THREAD_0_ARGS;
    [[ATAppRatingFlow sharedRatingFlow] openAppStore];
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

- (void)surveyBecameAvailable:(NSNotification *)notification
{
    if ([self _hasListeners:ATSurveyNewSurveyAvailableNotification]) {
        [self fireEvent:ATSurveyNewSurveyAvailableNotification withObject:notification.userInfo];
    }
}

- (void)presentSurveyControllerWithNoTags:(id)args
{
    ENSURE_UI_THREAD_0_ARGS;
    [ATSurveys presentSurveyControllerWithNoTagsFromViewController:[[TiApp app] controller]];
}

- (void)presentSurveyControllerWithTags:(id)args
{
    ENSURE_UI_THREAD_1_ARG(args);
    NSSet *tags = [NSSet setWithArray:args];
    [ATSurveys presentSurveyControllerWithTags:tags fromViewController:[[TiApp app] controller]];
}

- (void)surveyWasSent:(NSNotification *)notification
{
    if ([self _hasListeners:ATSurveySentNotification]) {
        [self fireEvent:ATSurveySentNotification withObject:notification.userInfo];
    }
}

@end
