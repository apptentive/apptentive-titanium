#Apptentive module for Titanium
===================

The Apptentive Titanium module allows you to add a quick and easy in-app-feedback mechanism to your Titanium applications. Feedback is sent to the Apptentive web service.

##Available on the Titanium Marketplace
===================

The module will soon be available through the [Titanium Marketplace](https://marketplace.appcelerator.com/).

##Available as a packaged module
===================

A packaged version of the Apptentive module can be found under the [Release](https://github.com/apptentive/apptentive-titanium/releases) tab of this repository.

The packaged module is released as a .zip file:

    com.apptentive.titanium-iphone-1.0.zip

###Installing the packaged Apptentive module
===================

The Apptentive module package (above) should be unzipped into your Titanium directory:

    > unzip -u -o com.apptentive.titanium-iphone-1.0.zip -d ~/Library/Application\ Support/Titanium/

**NOTE**: Your Titanium SDK may be installed under `/Library` rather than `~/Library`. Adjust these commands accordingly.

Then, in your Titanium app, edit the `tiapp.xml` file. Add the following near the end of the file:

    <modules>
        <module version="1.0">com.apptentive.titanium</module>
    </modules>
	
Your final `tiapp.xml` file should look similar to the following:

```
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
===================

Test that you have installed the module correctly by editing `app.js` in your Titanium app's resource directory:

    var apptentiveModule = require('com.apptentive.titanium');
    Ti.API.info("module is => " + apptentiveModule);

When you run your Titanium app, you should see the following:

    Detected third-party module: com.Apptentive.Titanium/1.0

	[INFO] [object ComApptentiveTitaniumModule] loaded
	[INFO] module is => [object ComApptentiveTitaniumModule]
	
If you see these statements and no errors in the console, the Apptentive module has been installed and loaded correctly in your Titanium app.

##Using the Apptentive module in your Titanium app
===================

Once you have successfully installed the module, you can begin using Apptentive in your Titanium app.

    var apptentiveModule = require('com.apptentive.titanium');
	apptentiveModule.setApiKey("GET_YOUR_API_KEY_FROM_APPTENTIVE.COM");

It is important that you set your Apptentive API key, which you can get by signing up [on our website](http://www.apptentive.com/).

You can then begin using the features of Apptentive. For example, you could add a "Give Feedback" button to your interface that collects feedback via Apptentive's Message Center (`apptentiveModule.presentMessageCenter()`).

```
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
   










