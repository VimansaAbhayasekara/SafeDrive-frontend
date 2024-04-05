import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:safedrive/common/theme.dart';
import 'package:safedrive/presentation/post_wall_design_container_screen/post_wall_design_container_screen.dart';
import 'package:safedrive/presentation/service_Center_Request_design_container_screen/service_request_design_container_screen.dart';
import 'package:safedrive/presentation/service_request_design_page/service_request_design_page.dart';
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
        '/welcome': (context) => Welcome(),
        '/login': (context) => const Login(),
        '/register': (context) => const Register(),
        '/Home': (context) => Home(),
        '/GalileoDesignPage': (context) =>
            const GalileoDesignPage(), // Define other routes as needed

        '/PostWallDesignContainerScreen': (context) =>
            PostWallDesignContainerScreen(),
      },
      initialRoute: '/welcome',
    );
  }
}

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();

// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:safedrive/firebase_options.dart';
// import 'package:safedrive/screens/Home.dart';

// // Updated import
// import 'package:safedrive/services/auth/auth_service.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   runApp(ChangeNotifierProvider(
//     create: (context) => AuthService(),
//     child: const MyApp(),
//   ));
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Home(), // No need to use AuthGate anymore, directly set HomePage
//     );
//   }
// }
