import 'package:flutter/material.dart';
import './pages/home.dart';
import './pages/login.dart';
import './utils/secure_storage.dart';
import './utils/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var initialRoute = 'login';

  var isUserLoggedIn = await UserSecureStorage.getUserEmail() ?? '';

  if (isUserLoggedIn != '') {
    initialRoute = 'home';
  }

  await UserPreferences.init();

  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  MyApp({required this.initialRoute});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Anota Aí',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: initialRoute,
      routes: {
        'login': (context) => Login(),
        'home': (context) => Home(),
      },
    );
  }
}
