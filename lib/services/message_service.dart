// TODO: Notification feature not available for free plan in Firebase. Consider upgrading to a paid plan for full functionality.
// Comment for now

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class MessageService {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   // Initialize FCM and local notifications
//   Future<void> initialize() async {
//     // Request notification permissions (iOS)
//     // NotificationSettings settings = await _firebaseMessaging.requestPermission(
//     //   alert: true,
//     //   badge: true,
//     //   sound: true,
//     // );

//     // Get the FCM token
//     String? token = await _firebaseMessaging.getToken();
//     print("FCM Token: $token");

//     // Subscribe to a topic (e.g., 'allUsers')
//     await _firebaseMessaging.subscribeToTopic('allUsers');

//     // Initialize local notifications
//     await _initializeLocalNotifications();

//     // Handle foreground messages
//     FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

//     // Handle background messages
//     FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);
//   }

//   // Initialize local notifications
//   Future<void> _initializeLocalNotifications() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings(
//           '@mipmap/ic_launcher',
//         ); // Use your app's launcher icon

//     const InitializationSettings initializationSettings =
//         InitializationSettings(
//           android: initializationSettingsAndroid,
//           iOS: null, // Configure for iOS if needed
//         );

//     await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }

//   // Handle foreground messages
//   void _handleForegroundMessage(RemoteMessage message) {
//     print("Foreground Message: ${message.notification?.title}");

//     // Display a local notification
//     if (message.notification != null) {
//       _showLocalNotification(message);
//     }
//   }

//   // Handle background messages
//   static Future<void> _handleBackgroundMessage(RemoteMessage message) async {
//     print("Background Message: ${message.notification?.title}");
//   }

//   // Show a local notification
//   Future<void> _showLocalNotification(RemoteMessage message) async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//           'your_channel_id', // Channel ID
//           'your_channel_name', // Channel Name
//           importance: Importance.max,
//           priority: Priority.high,
//         );

//     const NotificationDetails platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//       iOS: null, // Configure for iOS if needed
//     );

//     await _flutterLocalNotificationsPlugin.show(
//       0, // Notification ID
//       message.notification?.title, // Title
//       message.notification?.body, // Body
//       platformChannelSpecifics,
//     );
//   }
// }
