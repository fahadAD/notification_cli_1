
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notification_part/msg_screen.dart';

class NotificationServices{
FirebaseMessaging _messaging=FirebaseMessaging.instance;
final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();

     //part 1 requestNotificationPermission step
void requestNotificationPermission()async{
  NotificationSettings _settings=await _messaging.requestPermission(
    alert: true,
    announcement: true,
    badge: true,
    carPlay: true,
    sound: true,
    criticalAlert: true,
    provisional: true
  );

  if(_settings.authorizationStatus==AuthorizationStatus.authorized){
       print("fahad=??????????????????????????=====User granted permission");
  }else  if(_settings.authorizationStatus==AuthorizationStatus.provisional){
    print("fahad=??????????????????????????=====User granted provision permission");
  }else{
    print("User Denied not granted permission");
  }


}

//part 2 DeviceToken step
Future<String> getDeviceToken()async{
String? tokean=await _messaging.getToken();
 return tokean!;
}

//part 3 by change isTokenRefresh then..
   void  isTokenRefresh()async{
      _messaging.onTokenRefresh.listen((event) {
       event.toString();
       print("=============================refresh   $event");
       print(event);
      });
  }

//part 4 notification add or not add is showing
  void firebaseInit(BuildContext context){
  FirebaseMessaging.onMessage.listen((massage) {
    if (kDebugMode) {
      print(" foreground notification tittle massage===== ${massage.notification!.title.toString()}");
      print("foreground notification body massage===== ${massage.notification!.body.toString()}");
      print("foreground notification android massage===== ${massage.notification!.android.toString()}");
      print("foreground notification data ===== ${massage.data.toString()}");

    }


   initLocalNotification(context, massage);
   showNotification(massage);
   });
  }

//part 5
  void initLocalNotification(BuildContext context,RemoteMessage message)async{

    var androidinitializationSetting=const AndroidInitializationSettings("@mipmap/ic_launcher");
    var iosinitializationSetting=const DarwinInitializationSettings();

    var initializationSetting=InitializationSettings(
      android: androidinitializationSetting,
      iOS: iosinitializationSetting,

    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSetting,
      onDidReceiveNotificationResponse: (details) {
           print("fahad onDidReceiveNotificationResponse === $details ===");
      },
      onDidReceiveBackgroundNotificationResponse: (details) {
        print("fahad onDidReceiveBackgroundNotificationResponse === $details ===");
      },

    );
  }

//part 5 notification show fun

Future<void> showNotification(RemoteMessage message)async {
     AndroidNotificationChannel _AndroidNotificationChannel=AndroidNotificationChannel(
         Random.secure().nextInt(100000).toString(),
         "hi fahad how are you $message",
       importance: Importance.max,
         showBadge: true

     );
  AndroidNotificationDetails _AndroidNotificationDetails=AndroidNotificationDetails(
      _AndroidNotificationChannel.id.toString(),
      _AndroidNotificationChannel.name.toString(),
       channelDescription: "your description",
    importance: Importance.high,
    priority: Priority.high,
    ticker: "==Ticker==",
      channelShowBadge: true,
    );

  DarwinNotificationDetails   _IosDarwinNotificationDetails= const DarwinNotificationDetails(
 presentAlert: true,
    presentBadge: true,
    presentSound: true,

  );

  NotificationDetails _NotificationDetails=NotificationDetails(
    android: _AndroidNotificationDetails,
    iOS: _IosDarwinNotificationDetails,

  );


  Future.delayed(Duration.zero,() {
    _flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        _NotificationDetails,

    );
  },);



}


void handleMassage(BuildContext context,RemoteMessage message){

  if(message.data['type']=='massage'){
    Navigator.push(context, MaterialPageRoute(builder: (context) => MSG_Screen(),));
  }
}
}