#Apptentive module for Titanium

The Apptentive Titanium module allows you to add a quick and easy in-app-feedback mechanism to your Titanium applications. Feedback is sent to the Apptentive web service.

##Available on the Titanium Marketplace

The module will soon be available through the [Titanium Marketplace](https://marketplace.appcelerator.com/).

##Available as a packaged module

A packaged version of the Apptentive module can be found under the [Release](https://github.com/apptentive/apptentive-titanium/releases) tab of this repository.

The packaged module is released as a .zip file:

    com.apptentive.titanium-iphone-1.0.zip

###Installing the packaged Apptentive module

The Apptentive module package (above) should be unzipped into your Titanium directory:

    > unzip -u -o com.apptentive.titanium-iphone-1.0.zip -d ~/Library/Application\ Support/Titanium/

**NOTE**: Your Titanium SDK may be installed under `/Library` rather than `~/Library`. Adjust these commands accordingly.

Then, in your Titanium app, edit the `tiapp.xml` file. Add the following near the end of the file:

    <modules>
        <module version="1.0">com.apptentive.titanium</module>
    </modules>

Your final `tiapp.xml` file should look similar to the following:

``` XML
<ti:app xmlns:ti="http://ti.appcelerator.org">
  <id>com.example.test</id>
  <name>testapp</name>
  <version>1.0</version>
  <publisher>Your Company</publisher>
  <url>www.example.com</url>
  <description>Our cool Titanium app</description>
  <copyright>Copyright 2013</copyright>
  <icon>appicon.png</icon>
  <guid>c347a9a1-44bd-48c8-a6bf-7762f2582f50</guid>
  <modules>
    <module version="1.0">com.apptentive.titanium</module>
  </modules>
</ti:app>
```

###Test that the module is correctly installed

Test that you have installed the module correctly by editing `app.js` in your Titanium app's resource directory:

    var apptentiveModule = require('com.apptentive.titanium');
    Ti.API.info("module is => " + apptentiveModule);

When you run your Titanium app, you should see the following:

    Detected third-party module: com.Apptentive.Titanium/1.0

	[INFO] [object ComApptentiveTitaniumModule] loaded
	[INFO] module is => [object ComApptentiveTitaniumModule]

If you see these statements and no errors in the console, the Apptentive module has been installed and loaded correctly in your Titanium app.

##Using the Apptentive module in your Titanium app

Once you have successfully installed the module, you can begin using Apptentive in your Titanium app.

    var apptentiveModule = require('com.apptentive.titanium');
	apptentiveModule.setApiKey("GET_YOUR_API_KEY_FROM_APPTENTIVE.COM");

It is important that you set your Apptentive API key, which you can get by signing up [on our website](http://www.apptentive.com/).

You can then begin using the features of Apptentive. For example, you could add a "Give Feedback" button to your interface that collects feedback via Apptentive's Message Center.

``` JavaScript
var messageCenterButton = Titanium.UI.createButton({
   title: "Give Feedback",
   width: 200,
   height: 50
});
win.add(messageCenterButton);
messageCenterButton.addEventListener('click',function(e)
{
   apptentiveModule.presentMessageCenter();
});
```
   
##Message Center

Get feedback from your customers with the Apptentive Message Center.

    apptentiveModule.presentMessageCenter();

The first time you present the Message Center, the user will be presented with an email feedback form. Thereafter, they will be taken to the Message Center. If you reply to your customers' feedback via the Apptentive website, the replies will be pushed to their in-app Message Center. 

Check for the number of unread messages like so:

    apptentiveModule.unreadMessageCount(); 

You can also listen for our `ATMessageCenterUnreadCountChangedNotification` notification:

    apptentiveModule.addEventListener('ATMessageCenterUnreadCountChangedNotification', function(e) {
        Ti.API.info('New unread Message Center messages! ' + e.type);
    }); 

##User info

You can pre-load Apptentive with information about the user, which makes their Message Center experience easier:

    apptentiveModule.setInitialUserName("Peter");
	apptentiveModule.setInitialUserEmailAddress("peter@example.com");

You can also store arbitrary information about the user, which is then visible in your Message Center.

    apptentiveModule.addCustomDataWithKey("data", "key");
    apptentiveModule.addCustomDataWithKey("Seattle", "city");

Similarly, you can remove custom data:

	apptentiveModule.removeCustomDataWithKey("city");

##App Store Rating Flow

Apptentive also provides an App Store rating flow. A ratings dialog will be displayed based on the number of launches of your application, the amount of time the user has been using it, and the number of significant events the user has completed (for example, levels passed). All of these variables can be modified on Apptentive.com.

Display the rating flow at a certain point in your code with:

    apptentiveModule.showRatingFlowIfConditionsAreMet();

The rating flow will only be shown if all conditions (number of launches, significant events, etc.) have been met.

Log significant events, such as completing a level, with:

    apptentiveModule.logSignificantEvent();

##In-App Surveys

Surveys can be created on our website and presented, in-app, to users.

You can check if there are any available surveys that have been downloaded from the server:

    apptentiveModule.hasSurveyAvailableWithNoTags();
	//...or...//
    apptentiveModule.hasSurveyAvailableWithTags("testSurvey", "testTag");	

You can also listen for our `ATSurveyNewSurveyAvailableNotification` notification:

    apptentiveModule.addEventListener('ATSurveyNewSurveyAvailableNotification', function(e) {
        Ti.API.info('New Apptentive Surveys! ' + e.type);
    });

If surveys are available, present the surveys in the app:

    apptentiveModule.presentSurveyControllerWithNoTags();
    //...or...//
    apptentiveModule.presentSurveyControllerWithTags("testSurvey", "testTag");

We will then send a notification when the survey has been sent to Apptentive:

	apptentiveModule.addEventListener('ATSurveySentNotification', function(e) {
	    Ti.API.info('Apptentive Survey was sent! ' + e.type);
	});

##Questions? Comments? Help using Apptentive?

Please let us know how we can improve this document or the Apptentive Titanium module!

https://github.com/apptentive/apptentive-titanium/issues

If you have any other questions, please contact us and we will get back to you quickly.

http://www.apptentive.com/contact
