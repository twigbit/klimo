import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:klimo/config/firebase.dart';

class NotificationsServices {
  static Future initialize() async {
    ///request permission to receive messages
    if (Platform.isIOS) {
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      debugPrint('User granted permission: ${settings.authorizationStatus}');

      ///enable ios Notifications on foreground
      await messaging.setForegroundNotificationPresentationOptions(
        alert: true, // Required to display a heads up notification
        badge: true,
        sound: true,
      );
    }

    /// get FCM token for testing purposes
    //messaging.getToken().then((value) => debugPrint('FCM token $value'));

    ///anything here will work when user taps on notification & opens the app from terminated (background & closed) state
    ///uncomment following code if needed
    ///
    // messaging.getInitialMessage().then((message) {
    //   ///example: we could set a specific key (in Firebase Cloud Messaging Additional Custom Data) like "route" and fetch it for navigation based on its value
    //   if (message != null && message.data["route"] != null) {
    //     final routeFromMessage = message.data["route"];
    //     debugPrint(routeFromMessage);
    //   }
    // });

    ///anything here will work when app is in foreground
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        debugPrint(message.notification!.body);
        debugPrint(message.notification!.title);
      }
    });

    ///anything here will work when user taps on notification & opens the app from background but opened state
    ///uncomment following code if needed
    ///
    // FirebaseMessaging.onMessageOpenedApp.listen((message) {
    //   if (message.data["route"] != null) {
    //     final routeFromMessage = message.data["route"];
    //     debugPrint(routeFromMessage);
    //   }
    // });
  }
}
