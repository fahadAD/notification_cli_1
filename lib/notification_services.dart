
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
       print("=============================refresh");
       print(event);
      });
  }

//part 4 notification add or not add is showing
  void firebaseInit(){
  FirebaseMessaging.onMessage.listen((massage) {
    print("notification tittle massage===== ${massage.notification!.title.toString()}");
    print("notification body massage===== ${massage.notification!.body.toString()}");
    print("notification android massage===== ${massage.notification!.android.toString()}");
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

      },
      onDidReceiveBackgroundNotificationResponse: (details) {

      },

    );
  }

//part 5
Future<void> showNotification(RemoteMessage message)async {

}

}