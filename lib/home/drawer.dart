import 'dart:io';

import 'package:blogging_app/home/edit-profile.dart';
import 'package:blogging_app/models/firebase-fetch-data.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../customs.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("user");

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;
  @override
  // void initState() {
  //   username.dispose();
  //   // TODO: implement initState
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Drawer(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: CircleAvatar(
                radius: 70,
                backgroundImage: user!.photoURL == null
                    ? NetworkImage("$netimg")
                    : NetworkImage(
                        "${user.photoURL}",
                      ),

                // child: Image.file(getimage!),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(onPressed: update, child: const Text("Edit Profile")),
            Container(
              child: Text("Email:\t${user.email}", textScaleFactor: 1.35),
              alignment: Alignment.center,
              height: 35,
              // width: 44,
              margin: EdgeInsets.only(top: size.height * 0.02),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.purple, width: 0.6),
                  borderRadius: BorderRadius.circular(15)),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              color: Colors.purple,
              thickness: 0.2,
            ),
            Text("Username:\t${user.displayName}"),
            Divider(
              color: Colors.purple,
              thickness: 0.2,
            ),
            ListTile(
              onTap: (() => FirebaseAuth.instance.signOut()),
              title: Text("Logout"),
              trailing: Icon(Icons.logout_outlined),
            ),
            Divider(
              color: Colors.purple,
              thickness: 0.2,
            ),
          ],
        ),
      )),
    );
  }

  String usernamedata = "";
  void get docsData => collectionReference.get().then(
        (QuerySnapshot<Object?> snapshot) => snapshot.docs.forEach((documents) {
          print(documents.id);
          // docId = documents.id;
          usernamedata = documents["displayusername"];
        }),
      );
  bool isloading = false;

  Future update() async {
    if (usernamedata.isNotEmpty) {
      setState(() {
        username.text = usernamedata;
      });
    }
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          final size = MediaQuery.of(context).size;
          return SingleChildScrollView(
            child: SizedBox(
              height: size.height * 0.75,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Container(
                  //   height: 100,
                  // ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: EditProfile(),
                    width: 100,
                    height: 120,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                    ),
                    child: TextField(
                      controller: username,
                      onChanged: (value) {
                        setState(() {
                          value = usernamedata;
                        });
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          fillColor: Colors.white60,
                          filled: true,
                          enabled: true,
                          hintText: "Edit the Username",
                          prefix: Icon(
                            Icons.person_add_alt_1_outlined,
                            color: Colors.black,
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 8)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // SizedBox(
                  //   height: 20,
                  // ),

                  ElevatedButton(
                      onPressed: () async {
                        final String name = username.text;
                        User? _user = FirebaseAuth.instance.currentUser;

                        Reference ref =
                            _storage.ref().child("user/").child(_user!.uid);
                        setState(() {
                          isloading = true;
                        });
                        UploadTask upoadtask = ref.putFile(getimage!);
                        upoadtask.whenComplete(() async {
                          String url = await ref.getDownloadURL();
                          await collectionReference.doc(_user.uid).update({
                            "displayusername": name,
                            "img": url,
                          }).then((_) => {
                                _user.updateDisplayName(
                                  name,
                                ),
                                _user.updatePhotoURL(url)
                              });
                        }).then((_) {
                          setState(() {
                            isloading = false;
                          });
                          Navigator.pop(context);
                        });
                      },
                      child: isloading == false
                          ? Text("update")
                          : CircularProgressIndicator())
                ],
              ),
            ),
          );
        });
  }
}
