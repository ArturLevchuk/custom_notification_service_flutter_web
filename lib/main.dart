import 'dart:developer';
import 'package:custom_notification_service_flutter_test/notification_service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    NotificationService.init(baseUrl: 'http://localhost:3000');
    NotificationService.notificationStream.listen((event) {
      log('Notification Received: $event');
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Notification Service'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FilledButton(
              onPressed: () async {
                NotificationService.subscribeToPushNotifications();
              },
              child: const Text(
                'Subscribe to Notifications',
              ),
            ),
            FilledButton(
              onPressed: () async {
                final status = NotificationService.getNotificationStatus();
                log("Notification Status: $status");
              },
              child: const Text(
                'Is Notifications Allowed',
              ),
            ),
            FilledButton(
              onPressed: () async {
                final status = await NotificationService.isUserSubscribed();
                log("Is User Subscribed: $status");
              },
              child: const Text(
                'Is User Subscribed',
              ),
            ),
            FilledButton(
              onPressed: () async {
                NotificationService.unsubscribeFromPushNotifications();
              },
              child: const Text(
                'Unsubscribe from Notifications',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
