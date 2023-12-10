import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class drawer extends StatefulWidget {
  const drawer({super.key});

  @override
  State<drawer> createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.green,
            ), //BoxDecoration
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              accountName: Text(
                '${user?.email}',
                style: TextStyle(fontSize: 18),
              ),
              accountEmail: Text('${user?.email}'),
              currentAccountPictureSize: Size.square(50),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Color.fromARGB(255, 165, 255, 137),
                child: Text(
                  "A",
                  style: TextStyle(fontSize: 30.0, color: Colors.blue),
                ), //Text
              ), //circleAvatar
            ), //UserAccountDrawerHeader
          ), //DrawerHeader

          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('LogOut'),
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      //
    );
  }
}
