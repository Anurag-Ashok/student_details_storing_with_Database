import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_details/pages/phone.dart';

import 'package:student_details/pages/signUpPage.dart';
import 'package:student_details/signingMethods.dart';

class signInPage extends StatefulWidget {
  const signInPage({super.key});

  @override
  State<signInPage> createState() => _signInPageState();
}

class _signInPageState extends State<signInPage> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    Size mq = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Text(
                  'Welcome Back',
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.green[600],
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                  width: mq.width * 0.5, child: Image.asset('images/img1.png')),
              SizedBox(
                height: mq.height * .03,
              ),
              SizedBox(
                width: mq.width * 0.7,
                child: Column(
                  children: [
                    TextField(
                      controller: emailcontroller,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          labelText: ' email or username',
                          hintText: 'Enter valid  abc@gmail.com'),
                    ),
                    SizedBox(
                      height: mq.height * .03,
                    ),
                    TextField(
                      controller: passwordcontroller,
                      obscureText: true,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          labelText: 'Password',
                          hintText: 'Enter secure password'),
                    ),
                    SizedBox(
                      height: mq.height * .03,
                    ),
                    Container(
                      width: mq.width * 0.7,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade600),
                        child: Text(
                          'Sign in ',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () {
                          if (emailcontroller.text.isNotEmpty &&
                              passwordcontroller.text.length > 6) {
                            signingWithemail();
                          } else {
                            SnackBar(
                                content: Text('Invalid Email or Password'));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('You Have no Account '),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => signupPage(),
                            ));
                      },
                      child: Text('SignUp'))
                ],
              ),
              SizedBox(
                height: mq.height * .03,
              ),
              Divider(
                endIndent: mq.width * 0.1,
                indent: mq.width * 0.1,
              ),
              SizedBox(
                height: mq.height * .01,
              ),
              Text(
                'SignIn With',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: mq.height * .04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      AuthService().googleSinIn(context);
                    },
                    child: Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: 50,
                              child: Image.asset('images/google.png')),
                          Text(
                            'Google',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => phoneAuth(),
                          ));
                    },
                    child: Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: 50,
                              child: Image.asset('images/smartphone-call.png')),
                          Text(
                            'Phone',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  signingWithemail() async {
    final auth = FirebaseAuth.instance;
    auth.signInWithEmailAndPassword(
        email: emailcontroller.text, password: passwordcontroller.text);
    SnackBar(content: Text('LogIn Succes'));
  }
}
