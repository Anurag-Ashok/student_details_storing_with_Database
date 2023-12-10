import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:student_details/firebase_options.dart';
import 'package:student_details/pages/homePage.dart';
import 'package:student_details/pages/signInPage.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return homePage();
          }
          return signInPage();
        }),
  ));
}
