import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class signupPage extends StatefulWidget {
  const signupPage({super.key});

  @override
  State<signupPage> createState() => _signupPageState();
}

class _signupPageState extends State<signupPage> {
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
                padding: EdgeInsets.only(top: 50),
                child: Text(
                  'Sign Up Here',
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.green[600],
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
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
                          labelText: ' email',
                          hintText: 'Enter valid Email'),
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
                            backgroundColor: Colors.green[600]),
                        child: const Text(
                          'Sign Up ',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () {
                          signup();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  signup() async {
    final auth = FirebaseAuth.instance;
    auth.createUserWithEmailAndPassword(
        email: emailcontroller.text, password: passwordcontroller.text);
    SnackBar(content: Text(' Succes '));
    Navigator.pop(context);
  }
}
