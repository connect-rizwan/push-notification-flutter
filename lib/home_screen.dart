import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/notification_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    super.initState();
    notificationServices.requestNotificationPermission();
    notificationServices.forgroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.isTokenRefresh();

    notificationServices.getDeviceToken().then((value) {
      if (kDebugMode) {
        print('device token');
        print(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Notifications'),
      ),
      body: Center(
        child: TextButton(
            onPressed: () {
              // send notification from one device to another
              notificationServices.getDeviceToken().then((value) async {
                var data = {
                  'to': value.toString(),
                  'notification': {
                    'title': 'Rizwan Ali',
                    'body': 'Testing the push notification',
                    "sound": "jetsons_doorbell.mp3"
                  },
                  'android': {
                    'notification': {
                      'notification_count': 12,
                    },
                  },
                  'data': {'type': 'message', 'id': 'Rizwan Ali'}
                };
              });
            },
            child: const Text('Send Notifications')),
      ),
    );
  }
}
