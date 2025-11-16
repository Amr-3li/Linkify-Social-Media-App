import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:linkify/core/services/local_notification_services.dart';
import 'package:linkify/core/services/sharedpreference_singelton.dart';

class PushNotificationServices {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  static bool _isInitialized = false;

  static Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      await _initializeFirebase();
      await _initializeLocalNotifications();
      await _requestPermissions();
      await _getToken();
      _setupInteractedMessage();
      _setupForegroundListener();

      _isInitialized = true;
      print('Push Notification Services initialized successfully');
    } catch (e) {
      print('Error initializing push notifications: $e');
    }
  }

  static Future<void> _initializeFirebase() async {
    try {
      await Firebase.initializeApp();
      print('Firebase initialized');
    } catch (e) {
      print('Firebase initialization error: $e');
    }
  }

  static Future<void> _initializeLocalNotifications() async {
    try {
      // إنشاء notification channel للاندرويد
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'main_channel', // id
        'Main Channel', // title
        description: 'Main channel for important notifications',
        importance: Importance.high,
        playSound: true,
        enableVibration: true,
        showBadge: true,
      );

      // إنشاء ال channel
      await _localNotifications
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      // initialization settings
      const AndroidInitializationSettings androidSettings =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      const DarwinInitializationSettings iosSettings =
          DarwinInitializationSettings();

      const InitializationSettings settings = InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      );

      await _localNotifications.initialize(
        settings,
        onDidReceiveNotificationResponse: (NotificationResponse response) {
          _handleNotificationClick(response.payload);
        },
      );

      print('Local notifications initialized');
    } catch (e) {
      print('Local notifications initialization error: $e');
    }
  }

  static Future<void> _requestPermissions() async {
    try {
      // للـ iOS
      await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        provisional: false,
      );

      // للـ Android
      if (defaultTargetPlatform == TargetPlatform.android) {
        final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
            _localNotifications.resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>();

        await androidImplementation?.requestNotificationsPermission();
      }

      print('Permissions requested');
    } catch (e) {
      print('Permission request error: $e');
    }
  }

  static Future<void> _getToken() async {
    try {
      String? token = await _firebaseMessaging.getToken();
      print("Firebase Messaging Token: $token");
      SharedPreferenceSingelton.setString("fcm_token", token ?? '');
      // Listen for token refresh
      _firebaseMessaging.onTokenRefresh.listen((newToken) {
        print("New FCM Token: $newToken");
        // Update token on your server here
      });
    } catch (e) {
      print('Token error: $e');
    }
  }

  static void _setupInteractedMessage() {
    try {
      // Handle when app is launched from terminated state
      FirebaseMessaging.instance
          .getInitialMessage()
          .then((RemoteMessage? message) {
        if (message != null) {
          print(
              'App launched from terminated state with message: ${message.messageId}');
          _handleMessage(message);
        }
      });

      // Handle when app is in background and opened
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('App opened from background with message: ${message.messageId}');
        _handleMessage(message);
      });

      print('Interacted message setup completed');
    } catch (e) {
      print('Interacted message setup error: $e');
    }
  }

  static void _setupForegroundListener() {
    try {
      // Handle when app is in foreground
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('Foreground message received: ${message.messageId}');
        print('Message data: ${message.data}');
        print('Message notification: ${message.notification}');

        // Show local notification when app is in foreground
        LocalNotificationService.showBasicNotification(message);
      });

      print('Foreground listener setup completed');
    } catch (e) {
      print('Foreground listener setup error: $e');
    }
  }

  // @pragma('vm:entry-point')
  // static Future<void> _firebaseMessagingBackgroundHandler(
  //     RemoteMessage message) async {
  //   print('Handling background message: ${message.messageId}');

  //   try {
  //     await Firebase.initializeApp();
  //     await _showLocalNotification(message);
  //     print('Background message handled successfully');
  //   } catch (e) {
  //     print('Background message handling error: $e');
  //   }
  // }

  static void _handleMessage(RemoteMessage message) {
    try {
      print('Message handled: ${message.messageId}');
      print('Message data: ${message.data}');

      // Navigate to specific screen based on message data
      _navigateToScreen(message.data);
    } catch (e) {
      print('Error handling message: $e');
    }
  }

  static void _handleNotificationClick(String? payload) {
    try {
      print('Notification clicked with payload: $payload');
      // Handle notification click here
      if (payload != null) {}
    } catch (e) {
      print('Error handling notification click: $e');
    }
  }

  static void _navigateToScreen(Map<String, dynamic> data) {
    try {
      // Handle navigation based on message data
      if (data['type'] == 'chat') {
        print('Navigating to chat screen');
        // Navigate to chat screen
      } else if (data['type'] == 'friend_request') {
        print('Navigating to friends screen');
        // Navigate to friends screen
      } else {
        print('Unknown message type: ${data['type']}');
      }
    } catch (e) {
      print('Error navigating to screen: $e');
    }
  }

  // دالة لتعطيل الإشعارات مؤقتاً
  static Future<void> disableNotifications() async {
    try {
      await _firebaseMessaging.setAutoInitEnabled(false);
      await _firebaseMessaging.deleteToken();
      print('Notifications disabled');
    } catch (e) {
      print('Error disabling notifications: $e');
    }
  }

  // دالة لتفعيل الإشعارات
  static Future<void> enableNotifications() async {
    try {
      await _firebaseMessaging.setAutoInitEnabled(true);
      await _getToken();
      print('Notifications enabled');
    } catch (e) {
      print('Error enabling notifications: $e');
    }
  }
}
