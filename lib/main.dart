import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_app/pages/login_page.dart';
import 'package:my_chat_app/services/navigation_service.dart';

import 'pages/registration_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My chat app',
      navigatorKey: NavigationService.instance.navigatorKey,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color.fromRGBO(42, 117, 188, 1),
        dialogBackgroundColor: Color.fromRGBO(28, 27, 27, 1),
      ),
      initialRoute: 'login',
      routes: {
        'login': (BuildContext _context) => const LoginPage(),
        'register': (BuildContext _context) => const RegistrationPage(),
      },
    );
  }
}
