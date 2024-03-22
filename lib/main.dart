import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:safedrive/common/theme.dart';
import 'package:safedrive/presentation/post_wall_design_container_screen/post_wall_design_container_screen.dart';
import 'package:safedrive/presentation/service_Center_Request_design_container_screen/service_request_design_container_screen.dart';
import 'package:safedrive/screens/Home.dart';
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
        '/Home': (context) => GalileoDesignContainerScreen(),
      },
      initialRoute: '/welcome',
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:safe_drive/view/profile_view.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home:  const ProfileView(),
//     );
//   }
// }
//

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();
