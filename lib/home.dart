import 'package:flutter/material.dart';
import 'package:notification_part/notification_services.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  NotificationServices _notificationServices=NotificationServices();

  @override
  void initState() {
    // TODO: implement initState
    _notificationServices.requestNotificationPermission();
    _notificationServices.getDeviceToken().then((value)  {
      print(value);
    });
    _notificationServices.isTokenRefresh();
    _notificationServices.firebaseInit();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notification")),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
