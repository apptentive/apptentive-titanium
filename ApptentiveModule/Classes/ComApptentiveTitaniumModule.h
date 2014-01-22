/**
 * Copyright 2013 Apptentive, Inc.. All rights reserved.
 *
 * Created by Peter Kamb on 7/30/13.
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "TiModule.h"

@interface ComApptentiveTitaniumModule : TiModule
{
    
}

#pragma mark Apptentive Shared Features
- (id)apiKey:(id)args;
- (void)setApiKey:(id)args;
- (id)initialUserName:(id)args;
- (void)setInitialUserName:(id)args;
- (id)initialUserEmailAddress:(id)args;
- (void)setInitialUserEmailAddress:(id)args;

- (void)addCustomPersonData:(id)args;
- (void)removeCustomPersonDataWithKey:(id)args;

- (void)addCustomDeviceData:(id)args;
- (void)removeCustomDeviceDataWithKey:(id)args;


#pragma mark Message Center
- (void)presentMessageCenter:(id)args;
- (void)presentMessageCenterWithCustomData:(id)args;

- (id)unreadMessageCount:(id)args;

#pragma mark Ratings Flow
- (void)setAppID:(id)args;
- (void)showRatingFlowIfConditionsAreMet:(id)args;
- (void)logSignificantEvent:(id)args;

#pragma mark - Surveys
- (id)hasSurveyAvailableWithNoTags:(id)args;
- (id)hasSurveyAvailableWithTags:(id)args;
- (void)presentSurveyControllerWithNoTags:(id)args;
- (void)presentSurveyControllerWithTags:(id)args;

@end
