import 'package:flutter/material.dart';

import 'package:push_local/src/providers/push_notifications_provider.dart';

import 'package:push_local/src/pages/home_page.dart';
import 'package:push_local/src/pages/mensaje_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();

    final pushProvider = new PushNotificationProvider();
    pushProvider.initNotifications();
    
    pushProvider.mensajes.listen((data) {
      // Navigator.pushNamed(context, MensajePage.routeName);
      print('Argumento del push');
      print(data);

      navigatorKey.currentState.pushNamed(MensajePage.routeName, arguments: data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: 'Material App',
      initialRoute: 'home',
      routes: {
        HomePage.routeName:     (BuildContext context) => HomePage(),
        MensajePage.routeName:  (BuildContext context) => MensajePage(),
      },
    );
  }
}