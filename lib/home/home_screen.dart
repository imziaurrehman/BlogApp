import 'package:blogging_app/home/create_post.dart';
import 'package:blogging_app/home/drawer.dart';
import 'package:blogging_app/home/edit-profile.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import './image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../customs.dart';
import 'post_listview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? image;
  Future imagegetter() async {
    showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text("choose one option"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context, ImageSource.gallery);
              },
              child: const Text("open gallery")),
          const SizedBox(
            height: 20,
          ),
          TextButton(
              onPressed: () {
                Navigator.pop(context, ImageSource.camera);
              },
              child: const Text("open camera")),
        ],
      ),
    ).then((ImageSource? imageSource) async {
      XFile? image = await ImagePicker().pickImage(source: imageSource!);
      setState(() {
        if (image == null && imageSource == null) {
          return;
        } else {
          getimage = File(image!.path);
        }
      });
    });
  }

  FirebaseStorage storage = FirebaseStorage.instance;
  // CollectionReference db = FirebaseFirestore.instance.collection("blog");
  CollectionReference db = FirebaseFirestore.instance.collection("blog");

  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text(
          "Home Screen",
          style: TextStyle(color: Color.fromARGB(221, 154, 66, 170)),
        ),
        centerTitle: true,
        elevation: 0.0,
        iconTheme:
            const IconThemeData(color: Color.fromARGB(221, 154, 66, 170)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: size.height * 0.68,
                  child: StreamBuilder(
                    stream: db.snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot?> snapshot) {
                      if (!snapshot.hasData) {
                        return Text("data is not here");
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot documentSnapshot =
                                snapshot.data!.docs[index];

                            return Column(children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                child: Image.network(
                                  documentSnapshot.get("imgurl"),
                                  height: size.height * 0.3,
                                  width: size.width * 0.6,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                width: size.width * 0.6,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 8),
                                margin: EdgeInsets.only(bottom: 20),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.purple, width: 0.01),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text(
                                    "Title: ${documentSnapshot.get("title")}",
                                    textScaleFactor: 1.6,
                                    style: TextStyle(),
                                  ),
                                ),
                              )
                            ]);
                          },
                        );
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                SizedBox(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(Postlistview.routeName);
                      },
                      child: const Text("Post")),
                  width: size.width * 0.85,
                  height: size.height * 0.056,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 180, 45, 204),
        elevation: 0.0,
        onPressed: () {
          Navigator.pushNamed(context, Create_Post.routeName);
        },
        tooltip: 'add blogs',
        child: const Icon(
          Icons.add_a_photo_outlined,
        ),
      ),
      drawer: MyWidget(),
    );
  }
}
