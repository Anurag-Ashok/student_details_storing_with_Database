import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:student_details/widget/drawer.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
//creat items

  // text field controller
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _qtyController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  final CollectionReference _items =
      FirebaseFirestore.instance.collection('items');

  String imageUrl = '';
  String searchText = '';
  // for create operation
  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                right: 20,
                left: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    "Add Items",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: IconButton(
                      onPressed: () async {
                        ImagePicker imagePicker = ImagePicker();
                        XFile? file = await imagePicker.pickImage(
                            source: ImageSource.gallery);
                        print(" file path = ${file?.path}");
                        if (file == null) return;
                        String fileName =
                            DateTime.now().microsecondsSinceEpoch.toString();
                        Reference referenceRoot =
                            FirebaseStorage.instance.ref();
                        //
                        Reference referenceDirectImage =
                            referenceRoot.child('images');
                        //
                        Reference referenceImageToUpload =
                            referenceDirectImage.child(fileName);
                        try {
                          await referenceImageToUpload.putFile(File(file.path));
                          imageUrl = await referenceImageToUpload
                              .getDownloadURL(); // ignore: empty_catches
                        } catch (error) {}
                      },
                      icon: Icon(Icons.camera_alt_sharp)),
                ),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                      labelText: 'Item Name', hintText: 'eg.Book'),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _qtyController,
                  decoration: const InputDecoration(
                      labelText: 'Quantity', hintText: 'eg.30'),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _priceController,
                  decoration: const InputDecoration(
                      labelText: 'Price', hintText: 'eg.30'),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: ElevatedButton(
                      onPressed: () async {
                        // if (imageUrl.isEmpty) {
                        //   Fluttertoast.showToast(msg: "Please upload an image");
                        //   return;
                        // }
                        final String name = _nameController.text;
                        final int? qty = int.tryParse(_qtyController.text);
                        final int? price = int.tryParse(_priceController.text);

                        // ignore: unnecessary_null_comparison
                        if (name != null && qty != null) {
                          await _items.add({
                            "name": name,
                            "qty": qty,
                            'image': imageUrl,
                            "price": price,
                          });
                          _nameController.text = '';
                          _qtyController.text = '';
                          _priceController.text = '';

                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text("Create")),
                )
              ],
            ),
          );
        });
  }

  late Stream<QuerySnapshot> _stream;
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    _stream = FirebaseFirestore.instance.collection('items').snapshots();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        key: _globalKey,
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          centerTitle: true,
          title: const Text("Our Item"),
          leading: IconButton(
              onPressed: () {
                _globalKey.currentState!.openDrawer();
              },
              icon: const Icon(Icons.menu)),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.logout),
            )
          ],
        ),
        drawer: drawer(),
        floatingActionButton: SizedBox(
          width: 150,
          child: FloatingActionButton(
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.shopping_cart),
                Text('Add Items'),
              ],
            ),
            onPressed: () {
              _create();
            },
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: _stream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text("Error${snapshot.error}"));
              }
              if (snapshot.hasData) {
                QuerySnapshot querySnapshot = snapshot.data;
                List<QueryDocumentSnapshot> document = querySnapshot.docs;
                List<Map> items = document.map((e) => e.data() as Map).toList();
                // List <MapEntry <String,int>> sortList =document.e
                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    Map thisItems = items[index];

                    return Card(
                      color: Color.fromARGB(255, 203, 244, 217),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        leading: thisItems.containsKey('image')
                            ? SizedBox(
                                height: 50,
                                width: 50,
                                child: CircleAvatar(
                                    radius: 17,
                                    backgroundColor:
                                        Color.fromARGB(255, 129, 226, 243),
                                    child: ClipOval(child: Icon(Icons.person))),
                              )
                            : SizedBox(
                                height: 50,
                                width: 50,
                                child: CircleAvatar(
                                    radius: 17,
                                    backgroundColor:
                                        Color.fromARGB(255, 122, 247, 238),
                                    child: Icon(Icons.person)),
                              ),
                        title: Text(
                          "${thisItems['name']}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Quantity : ${thisItems['qty']}",
                              style: const TextStyle(color: Colors.black),
                            ),
                            Text(
                              "Price : ${thisItems['price']}",
                              style: const TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
