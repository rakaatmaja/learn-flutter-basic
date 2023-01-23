import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NotificationProvider(),
      child: MaterialApp(home: LocalNotificationView()),
    );
  }
}

class LocalNotificationView extends StatefulWidget {
  @override
  _LocalNotificationViewState createState() => _LocalNotificationViewState();
}

class _LocalNotificationViewState extends State<LocalNotificationView> {
  @override
  initState() {
    Provider.of<NotificationProvider>(context, listen: false).initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Center(
                child: Consumer<NotificationProvider>(
      builder: (context, model, _) =>
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        ElevatedButton(
            onPressed: () => model.stylishNotification(),
            child: Text('Stylish Notification')),
        ElevatedButton(
            onPressed: () => model.sheduledNotification(),
            child: Text('Scheduled Notification')),
        ElevatedButton(
            onPressed: () => model.cancelNotification(),
            child: Text('Cancel Notification')),
      ]),
    ))));
  }
}

class NotificationProvider extends ChangeNotifier {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher");

    IOSInitializationSettings iosInitializationSettings =
        IOSInitializationSettings();

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: androidInitializationSettings,
            iOS: iosInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  //Instant Notifications
  Future<void> instantNofitication() async {
    var android = AndroidNotificationDetails(
      "id",
      "channel",
    );

    var ios = IOSNotificationDetails();

    var platform = new NotificationDetails(android: android, iOS: ios);

    await _flutterLocalNotificationsPlugin.show(
        0, "Demo instant notification", "Tap to do something", platform,
        payload: "Welcome to demo app");
  }

  //Image notification
  Future<void> imageNotification() async {
    var bigPicture = BigPictureStyleInformation(
        DrawableResourceAndroidBitmap("@mipmap/ic_launcher"),
        largeIcon: DrawableResourceAndroidBitmap("@mipmap/ic_launcher"),
        contentTitle: "Demo image notification",
        summaryText: "This is some text",
        htmlFormatContent: true,
        htmlFormatContentTitle: true);

    var android = AndroidNotificationDetails("id", "channel",
        styleInformation: bigPicture);

    var platform = new NotificationDetails(android: android);

    await _flutterLocalNotificationsPlugin.show(
        0, "Demo Image notification", "Tap to do something", platform,
        payload: "Welcome to demo app");
  }

  //Stylish Notification
  Future<void> stylishNotification() async {
    var android = AndroidNotificationDetails("id", "channel",
        styleInformation: BigPictureStyleInformation(
            DrawableResourceAndroidBitmap("@mipmap/ic_launcher"),
            largeIcon: DrawableResourceAndroidBitmap("@mipmap/ic_launcher"),
            contentTitle: "Demo stylish notification",
            summaryText: "This is some text",
            htmlFormatContent: true,
            htmlFormatContentTitle: true));

    var platform = new NotificationDetails(android: android);

    await _flutterLocalNotificationsPlugin.show(
        0, "Demo Stylish notification", "Tap to do something", platform);
  }

  //Sheduled Notification
  Future<void> sheduledNotification() async {
    var interval = RepeatInterval.everyMinute;
    var bigPicture = BigPictureStyleInformation(
        DrawableResourceAndroidBitmap("@mipmap/ic_launcher"),
        largeIcon: DrawableResourceAndroidBitmap("@mipmap/ic_launcher"),
        contentTitle: "Demo scheduled image notification",
        summaryText: "This is some text",
        htmlFormatContent: true,
        htmlFormatContentTitle: true);

    var android = AndroidNotificationDetails("id", "channel",
        styleInformation: bigPicture);

    var platform = new NotificationDetails(android: android);

    await _flutterLocalNotificationsPlugin.periodicallyShow(
        0,
        "Demo Sheduled notification",
        "Tap to do something",
        interval,
        platform);
  }

  Future<void> cancelNotification() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }
}
