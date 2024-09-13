import 'package:ecommer_test_mode_admin/views/screens/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter_easyloading/flutter_easyloading.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: kIsWeb || Platform.isAndroid? FirebaseOptions(
        apiKey: "AIzaSyCDiIDI4bIaq0FM_0SHeO2bxdY2Gr3IyEo",
        appId: "1:467738422124:web:b49eaf9aecb41e2a5aa149",
        messagingSenderId: "467738422124",
        projectId: "ecommerceapp-a2c98",
        storageBucket: "ecommerceapp-a2c98.appspot.com")
        : null
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.

        useMaterial3: true,
      ),
      home: MainScreen(),
      builder: EasyLoading.init(),
    );
  }
}
