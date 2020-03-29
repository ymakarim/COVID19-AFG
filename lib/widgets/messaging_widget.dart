import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newschin/single/single_page2.dart';

bool letGoToSingle = false;

class FirebaseNotifications {
  FirebaseMessaging _firebaseMessaging;
  BuildContext _context;

  void setUpFirebase(BuildContext context) {
    this._context = context;
    _firebaseMessaging = FirebaseMessaging();
  }

  void fcmSubscribe() {
    firebaseCloudMessagingListeners();
  }

  void fcmUnSubscribe() {
    _firebaseMessaging.unsubscribeFromTopic('global');
  }

  void firebaseCloudMessagingListeners() {
//    if (Platform.isIOS) iOS_Permission();

    _firebaseMessaging.getToken().then((token) {
      _firebaseMessaging.subscribeToTopic('global');
      print('token: $token');
    });

    _firebaseMessaging.configure(
      // onBackgroundMessage: Platform.isIOS ? null : myBackgroundMessageHandler,
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');

        if (Platform.isIOS) {
          print('notification on [IOS]');
          print('post_id ${message['post_id']}');
          print('notification body: ${message['notification']['body']}');
          print('notification body: ${message['notification']['title']}');

//          Post post = new Post(
//            id: int.parse('${message['post_id']}'),
//            post_title: '${message['title']}',
//            post_content: '${message['message']}',
//            image: '${message['image_url_full']}',
//            post_formatted_date: '',
//          );
//          _post = post;
//          inPost = post;
        } else {
          print('notification on [Android]');
//          Post post = new Post(
//            id: int.parse('${message['data']['post_id']}'),
//            post_title: message['data']['title'],
//            post_content: message['data']['message'],
//            image: message['data']['image'],
//            post_formatted_date: '',
//          );
//          _post = post;
//          inPost = post;
        }
//        await _showBigPictureNotification2(_post);
      },
      onResume: (Map<String, dynamic> message) async {
        print('on onResume $message');

        if (Platform.isIOS) {
          print('notification on [IOS]');
          print('post_id ${message['post_id']}');
          print('notification body: ${message['notification']['body']}');
          print('notification body: ${message['notification']['title']}');
        } else {
          print('notification on [Android]');
//          Post post = new Post(
//            id: int.parse('${message['data']['post_id']}'),
//            post_title: message['data']['title'],
//            post_content: message['data']['message'],
//            image: message['data']['image'],
//            post_formatted_date: '',
//          );
//          _post = post;
//          inPost = post;
        }

        Navigator.push(
          _context,
          MaterialPageRoute(
            builder: (context) {
              return SinglePage2(
                id: int.parse('${message['data']['post_id']}'),
                author: "Freshta Farhang",
                title: "${message['data']['title']}",
                image: "${message['data']['image']}",
              );
            },
          ),
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');

        if (Platform.isIOS) {
//          Post post = new Post(
//            id: int.parse('${message['post_id']}'),
//            post_title: '${message['title']}',
//            post_content: '${message['message']}',
//            image: '${message['image_url_full']}',
//            post_formatted_date: '',
//          );
//          data = post;
        } else {
//          Post post = new Post(
//            id: int.parse('${message['data']['post_id']}'),
//            post_title: message['data']['title'],
//            post_content: message['data']['message'],
//            image: message['data']['image'],
//            post_formatted_date: '',
//          );
//
//          data = post;
        }

        Navigator.push(
          _context,
          MaterialPageRoute(
            builder: (context) {
              return SinglePage2(
                id: int.parse('${message['data']['post_id']}'),
                author: "Freshta Farhang",
                title: "${message['data']['title']}",
                image: "${message['data']['image']}",
              );
            },
          ),
        );
      },
    );
  }

//  Future<void> _showNotification() async {
//    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//        'your channel id', 'your channel name', 'your channel description',
//        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
//    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//    var platformChannelSpecifics = NotificationDetails(
//        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//    await flutterLocalNotificationsPlugin.show(
//        0, 'plain title', 'plain body', platformChannelSpecifics,
//        payload: 'item x');
//  }
//
//  void iOS_Permission() async {
//    await _firebaseMessaging.requestNotificationPermissions(
//        IosNotificationSettings(sound: true, badge: true, alert: true));
//    await _firebaseMessaging.onIosSettingsRegistered
//        .listen((IosNotificationSettings settings) {
//      print("Settings registered: $settings");
//    });
//  }
//
//  Future<void> _showBigPictureNotification(var message) async {
//    // print('showing: ${message['data']}');
//    var largeIconPath =
//    await _downloadAndSaveImage('${message['data']['image']}', 'largeIcon');
//    var bigPicturePath = await _downloadAndSaveImage(
//        '${message['data']['image']}', 'bigPicture');
//    var bigPictureStyleInformation = BigPictureStyleInformation(
//        bigPicturePath, BitmapSource.FilePath,
//        largeIcon: largeIconPath,
//        largeIconBitmapSource: BitmapSource.FilePath,
//        contentTitle: '${message['notification']['title']}',
//        htmlFormatContentTitle: true,
//        summaryText: '${message['notification']['body']}',
//        htmlFormatSummaryText: true);
//    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//      'crossingthestreams.io/resourceResolver',
//      'crossingthestreams.io/resourceResolver',
//      '${message['notification']['body']}',
//      style: AndroidNotificationStyle.BigPicture,
//      styleInformation: bigPictureStyleInformation,
//    );
//    var platformChannelSpecifics =
//    NotificationDetails(androidPlatformChannelSpecifics, null);
//    await flutterLocalNotificationsPlugin.show(
//        int.parse('${message['data']['post_id']}0'),
//        '${message['notification']['title']}',
//        '${message['notification']['body']}',
//        platformChannelSpecifics,
//        payload: '${message['data']['post_id']}');
//  }
//
//  Future<void> _showBigPictureNotification2(Post _post) async {
//    var largeIconPath =
//    await _downloadAndSaveImage('${_post.image}', 'largeIcon');
//    var bigPicturePath =
//    await _downloadAndSaveImage('${_post.image}', 'bigPicture');
//    var bigPictureStyleInformation = BigPictureStyleInformation(
//        bigPicturePath, BitmapSource.FilePath,
//        largeIcon: largeIconPath,
//        largeIconBitmapSource: BitmapSource.FilePath,
//        contentTitle: '${_post.post_title}',
//        htmlFormatContentTitle: true,
//        summaryText: '${_post.post_content}',
//        htmlFormatSummaryText: true);
//    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//      'crossingthestreams.io/resourceResolver',
//      'crossingthestreams.io/resourceResolver',
//      '${_post.post_content}',
//      style: AndroidNotificationStyle.BigPicture,
//      styleInformation: bigPictureStyleInformation,
//    );
//    var iosPlatformChannelSpecifics = IOSNotificationDetails(
//      presentAlert: true,
//      presentSound: true,
//      presentBadge: true,
//    );
//    var platformChannelSpecifics = NotificationDetails(
//      androidPlatformChannelSpecifics,
//      iosPlatformChannelSpecifics,
//    );
//    await flutterLocalNotificationsPlugin.show(
//        int.parse('${_post.id}0'),
//        '${_post.post_title}',
//        '${_post.post_content}',
//        platformChannelSpecifics,
//        payload: '${_post.id}');
//  }
//
//  Future<String> _downloadAndSaveImage(String url, String fileName) async {
//    if (url.length > 0) {
//      var directory = (await getApplicationDocumentsDirectory()).path;
//      var filePath = '${directory}/$fileName';
//      var response = await http.get(url);
//      var file = File(filePath);
//      await file.writeAsBytes(response.bodyBytes);
//      return filePath;
//    }
//    return '';
//  }
//
//  _saveNotification() async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    // int counter = (prefs.getInt('counter') ?? 0) + 1;
//    // print('Pressed $counter times.');
//    await prefs.setString('counter', 'yes');
//
//    const MethodChannel('plugins.flutter.io/shared_preferences')
//        .setMockMethodCallHandler((MethodCall methodCall) async {
//      if (methodCall.method == 'getAll') {
//        return <String, dynamic>{}; // set initial values here if desired
//      }
//      return null;
//    });
//  }
}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  print('------------> $message');
}
