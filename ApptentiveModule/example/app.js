// This is a test harness for your module
// You should do something interesting in this harness 
// to test out the module and to provide instructions 
// to users on how to use it by example.

// open a single window
var win = Ti.UI.createWindow({
	backgroundColor:'white'
});
win.open();

var ApptentiveModule = require('com.apptentive.titanium');
Ti.API.info("module is => " + ApptentiveModule);

//API Key
var apiKey = ApptentiveModule.apiKey();
if (apiKey) {throw Error("Apptentive API key should be nil when not set!");}
ApptentiveModule.setApiKey("XYZ");
apiKey = ApptentiveModule.apiKey();
if (apiKey != "XYZ") {throw Error("Apptentive API key was not properly set!");}

//UserName
var userName = ApptentiveModule.initialUserName();
if (userName) {throw Error("Apptentive username should be nil when not set!");}
ApptentiveModule.setInitialUserName("Steven P. Jobs");
userName = ApptentiveModule.initialUserName();
if (userName != "Steven P. Jobs") {throw Error("Apptentive username was not properly set!");}

//EmailAddress
var email = ApptentiveModule.initialUserEmailAddress();
if (email) {throw Error("Apptentive email should be nil when not set!");}
ApptentiveModule.setInitialUserEmailAddress("steve@apple.com");
email = ApptentiveModule.initialUserEmailAddress();
if (email != "steve@apple.com") {throw Error("Apptentive email address was not properly set!");}

//Custom data
ApptentiveModule.addCustomDataWithKey("1 Infinite Loop, Cupertino CA", "address");
ApptentiveModule.addCustomDataWithKey("RemoveThisData", "remove");
ApptentiveModule.removeCustomDataWithKey("remove");

//Message Center
var messageCenterButton = Titanium.UI.createButton({
   title: "Present Message Center",
   textAlign: Titanium.UI.TEXT_ALIGNMENT_LEFT,
   top: 20,
   left: 20,
   width: 200,
   height: 50
});
win.add(messageCenterButton);
messageCenterButton.addEventListener('click',function(e)
{
   ApptentiveModule.presentMessageCenter();
});

var messageCenterCountButton = Titanium.UI.createButton({
   title: ApptentiveModule.unreadMessageCount(),
   top: 20,
   left: 240,
   width: 50,
   height: 50
});
win.add(messageCenterCountButton);
messageCenterCountButton.addEventListener('click',function(e)
{
  	messageCenterCountButton.title = ApptentiveModule.unreadMessageCount();
});

ApptentiveModule.addEventListener('ATMessageCenterUnreadCountChangedNotification', function(e) {
    Ti.API.info('EVENT! ' + e.type);
  	messageCenterCountButton.title = ApptentiveModule.unreadMessageCount();
});

//Rating Flow
var showRatingsFlowButton = Titanium.UI.createButton({
   title: "Rating flow",
   textAlign: Titanium.UI.TEXT_ALIGNMENT_LEFT,
   top: 90,
   left: 20,
   width: 125,
   height: 50
});
win.add(showRatingsFlowButton);
showRatingsFlowButton.addEventListener('click',function(e)
{
   ApptentiveModule.showRatingFlowIfConditionsAreMet();
});

var logEventButton = Titanium.UI.createButton({
   title: "Log Event",
   textAlign: Titanium.UI.TEXT_ALIGNMENT_LEFT,
   top: 90,
   left: 165,
   width: 125,
   height: 50
});
win.add(logEventButton);
logEventButton.addEventListener('click',function(e)
{
   ApptentiveModule.logSignificantEvent();
});

//Surveys (no tags)
var surveyNoTagsButton = Titanium.UI.createButton({
   title: 'Survey [no tags]',
   textAlign: Titanium.UI.TEXT_ALIGNMENT_LEFT,
   top: 160,
   left: 20,
   width: 200,
   height: 50
});
win.add(surveyNoTagsButton);
surveyNoTagsButton.addEventListener('click',function(e)
{
   ApptentiveModule.presentSurveyControllerWithNoTags();
});

var hasSurveyNoTagsButton = Titanium.UI.createButton({
   title: ApptentiveModule.hasSurveyAvailableWithNoTags(),
   top: 160,
   left: 240,
   width: 50,
   height: 50
});
win.add(hasSurveyNoTagsButton);
hasSurveyNoTagsButton.addEventListener('click',function(e)
{
   hasSurveyNoTagsButton.title = ApptentiveModule.hasSurveyAvailableWithNoTags();
});

//Surveys (tags)
var surveyWithTagsButton = Titanium.UI.createButton({
   title: 'Survey [testsurvey, testtag]',
   textAlign: Titanium.UI.TEXT_ALIGNMENT_LEFT,
   top: 230,
   left: 20,
   width: 200,
   height: 50
});
win.add(surveyWithTagsButton);
surveyWithTagsButton.addEventListener('click',function(e)
{
   ApptentiveModule.presentSurveyControllerWithTags("testsurvey", "testtag");
});

var hasSurveyWithTagsButton = Titanium.UI.createButton({
   title: ApptentiveModule.hasSurveyAvailableWithTags("testsurvey", "testtag"),
   top: 230,
   left: 240,
   width: 50,
   height: 50
});
win.add(hasSurveyWithTagsButton);
hasSurveyWithTagsButton.addEventListener('click',function(e)
{
   hasSurveyWithTagsButton.title = ApptentiveModule.hasSurveyAvailableWithTags("testsurvey", "testtag");
});

//Survey notifications
ApptentiveModule.addEventListener('ATSurveyNewSurveyAvailableNotification', function(e) {
    Ti.API.info('EVENT! ' + e.type);
    hasSurveyNoTagsButton.title = ApptentiveModule.hasSurveyAvailableWithNoTags();
    hasSurveyWithTagsButton.title = ApptentiveModule.hasSurveyAvailableWithTags("testsurvey", "testtag");
});

ApptentiveModule.addEventListener('ATSurveySentNotification', function(e) {
    Ti.API.info('EVENT! ' + e.type);
    hasSurveyNoTagsButton.title = ApptentiveModule.hasSurveyAvailableWithNoTags();
    hasSurveyWithTagsButton.title = ApptentiveModule.hasSurveyAvailableWithTags("testsurvey", "testtag");
});


Ti.API.info("module exampleProp is => " + ApptentiveModule.exampleProp);
ApptentiveModule.exampleProp = "This is a test value";

if (Ti.Platform.name == "android") {
	var proxy = ApptentiveModule.createExample({
		message: "Creating an example Proxy",
		backgroundColor: "red",
		width: 100,
		height: 100,
		top: 100,
		left: 150
	});

	proxy.printMessage("Hello world!");
	proxy.message = "Hi world!.  It's me again.";
	proxy.printMessage("Hello world!");
	win.add(proxy);
}

