import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:news_app/providers/articles_provider.dart';
import 'package:news_app/screens/headlines_screen.dart';

// API KEY: https://newsapi.org/
// 9ea00ae7f3184781aa9f52edb4ebda9b

void main() {
  Get.lazyPut(() => ArticlesProvider());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'headlines',
      routes: {
        'headlines': (context) => const HeadlinesScreen(),
      },
    );
  }
}