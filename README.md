# Apptentive Titanium Module

The Apptentive Titanium module allows you to add a quick and easy in-app-feedback mechanism to your Titanium applications. Feedback is sent to the Apptentive web service.

## Install Guide

The following steps will lead you through installing Apptentive into your application through the Titanium development environment. This guide assumes your app has been implemented through Titanium already.

### Get the Apptentive Module

There are a couple of ways you can get the Apptentive Titanium Module.

#### Appcelerator Marketplace

[![Appcelerator logo](https://raw.github.com/apptentive/apptentive-titanium/master/etc/screenshots/appcelerator_logo.png "Appcelerator Marketplace")](https://marketplace.appcelerator.com/apps/6222?19103220)

The Apptentive Titanium module is [available on the Appcelerator Open Mobile Marketplate](https://marketplace.appcelerator.com/apps/6222?1766037170).

#### GitHub

A packaged version of the Apptentive module can be found under the [Release tab](https://github.com/apptentive/apptentive-titanium/releases) of this repository.

The packaged module is released as a .zip file:

    com.apptentive.titanium-iphone-1.0.zip

### Setup the Apptentive Module

The Apptentive module package (above) should be unzipped into your Titanium directory:

    > unzip -u -o com.apptentive.titanium-iphone-1.0.zip -d ~/Library/Application\ Support/Titanium/

Note: Your Titanium SDK may be installed under `/Library` rather than `~/Library`. Adjust these commands accordingly.

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

#### Test Module Installation

To test that you have installed the module correctly, edit the `app.js` file in your Titanium app's resource directory, like so:

    var apptentiveModule = require('com.apptentive.titanium');
    Ti.API.info("module is => " + apptentiveModule);

When you run your Titanium app, you should see the following:

    Detected third-party module: com.Apptentive.Titanium/1.0

    [INFO] [object ComApptentiveTitaniumModule] loaded
    [INFO] module is => [object ComApptentiveTitaniumModule]

If you see these statements and no errors appear in the console, the Apptentive module has been installed and loaded correctly in your Titanium app.

### Implement Apptentive

Once you have successfully installed the module, you can begin using Apptentive in your Titanium app.

First, set your API Key with the following code snippet:

    var apptentiveModule = require('com.apptentive.titanium');
    apptentiveModule.setApiKey("YOUR_APPTENTIVE_API_KEY");

It is important that you set your Apptentive API key, which you can get by signing up on our [website](http://www.apptentive.com/).

You can then begin using the features of Apptentive. 

#### Message Center

Get feedback from your customers with the Apptentive Message Center. Add the following piece of code to the event listener that you want to bring up the feedback interface.

    apptentiveModule.presentMessageCenter();

The first time you present the Message Center, the user will be presented with an email feedback form. Thereafter, they will be taken to the Message Center. If you reply to your customers' feedback via the Apptentive website, the replies will be pushed to their in-app Message Center. 

Check for the number of unread messages with the following:

    apptentiveModule.unreadMessageCount(); 

You can also listen for our `ATMessageCenterUnreadCountChangedNotification` notification like so:

    apptentiveModule.addEventListener('ATMessageCenterUnreadCountChangedNotification', function(e) {
        Ti.API.info('New unread Message Center messages! ' + e.type);
    }); 

#### Ratings

Apptentive also provides an App Store rating flow. A ratings dialog will be displayed based on the number of launches of your application, the amount of time the user has been using it, and the number of significant events the user has completed (for example, levels passed). All of these variables can be modified on [Apptentive](http://apptentive.com).

Display the rating flow at a certain point in your code with:

    apptentiveModule.showRatingFlowIfConditionsAreMet();

The rating flow will only be shown if all conditions (number of launches, significant events, etc.) have been met.

Log significant events, such as completing a level, with:

    apptentiveModule.logSignificantEvent();

#### Surveys

Surveys can be created on our website and presented, in-app, to users.

You can check if there are any available surveys that have been downloaded from the server:

    apptentiveModule.hasSurveyAvailableWithNoTags();

or...

    apptentiveModule.hasSurveyAvailableWithTags("testSurvey", "testTag"); 

You can also listen for our `ATSurveyNewSurveyAvailableNotification` notification by adding this code snippet:

    apptentiveModule.addEventListener('ATSurveyNewSurveyAvailableNotification', function(e) {
        Ti.API.info('New Apptentive Surveys! ' + e.type);
    });

If surveys are available, present the surveys in the app:

    apptentiveModule.presentSurveyControllerWithNoTags();

or...

    apptentiveModule.presentSurveyControllerWithTags("testSurvey", "testTag");

We will then send a notification when the survey has been sent to Apptentive:

    apptentiveModule.addEventListener('ATSurveySentNotification', function(e) {
        Ti.API.info('Apptentive Survey was sent! ' + e.type);
    });

#### User info

You can pre-load Apptentive with information about the user, which makes their Message Center experience easier:

    apptentiveModule.setInitialUserName("Peter");
    apptentiveModule.setInitialUserEmailAddress("peter@example.com");

You can also store arbitrary information about the user, which is then visible in your Message Center:

    apptentiveModule.addCustomDataWithKey("data", "key");
    apptentiveModule.addCustomDataWithKey("Seattle", "city");

Similarly, you can remove custom data:

    apptentiveModule.removeCustomDataWithKey("city");
