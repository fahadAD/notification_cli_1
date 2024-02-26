
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationServices{
FirebaseMessaging _messaging=FirebaseMessaging.instance;

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
       print("User granted permission");
  }else  if(_settings.authorizationStatus==AuthorizationStatus.provisional){
    print("User granted provision permission");
  }else{
    print("User Denied not granted permission");
  }


}
}