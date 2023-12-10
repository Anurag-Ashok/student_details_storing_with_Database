import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:student_details/databaseMethod.dart';
import 'package:student_details/pages/homePage.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  getCurrenUser() async {
    return await _auth.currentUser;
  }

  // // google sign in
  // signInWithGoogle() async {
  //   final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
  //   //
  //   final GoogleSignInAuthentication gAuth = await gUser!.authentication;
  //   //
  //   final credential = GoogleAuthProvider.credential(
  //       accessToken: gAuth.accessToken, idToken: gAuth.idToken);
  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  // }

  googleSinIn(BuildContext context) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    final GoogleSignInAuthentication? googleSignInAuthentication =
        await googleSignInAccount?.authentication;

    final AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication?.idToken,
        accessToken: googleSignInAuthentication?.accessToken);
    UserCredential result =
        await firebaseAuth.signInWithCredential(authCredential);

    User? userDetails = result.user;

    Map<String, dynamic> userInfo = {
      "email": userDetails!.email,
      "name": userDetails.displayName,
      "imgUrl": userDetails.photoURL,
      "id": userDetails.uid
    };
    await DatabaseMethod().addUser(userDetails.uid, userInfo).then((value) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => homePage(),
          ));
    });
  }
}
