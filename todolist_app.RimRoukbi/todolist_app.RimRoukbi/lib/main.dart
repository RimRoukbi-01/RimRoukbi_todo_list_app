import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tp2/auth_verify.dart';
import 'firebase_options.dart';

import 'application.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const AuthVerify(),
    );
  }
}
