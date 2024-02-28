import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:safedrive/common/theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:safedrive/services/services.dart';
import 'firebase_options.dart';
import 'screens/screens.dart';

// Lisitnening to the background messages
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  final NotificationService notificationService = NotificationService();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await notificationService.setupFlutterNotifications();
  notificationService.showFlutterNotification(message);
  print('Handling a background message ${message.messageId}');
}

Future<void> main() async {
  await dotenv.load(fileName: "assets/.env");
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Listening to the background messages
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    await NotificationService().setupFlutterNotifications();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Safe Drive',
      debugShowCheckedModeBanner: false,
      theme: light,
      themeMode: ThemeMode.light,
      routes: {
        '/welcome': (context) => const Welcome(),
        '/login': (context) => const Login(),
        '/register': (context) => const Register(),
        '/my-vehicle': (context) => const MyVehicle(),
      },
      initialRoute: '/welcome',
    );
  }
}
