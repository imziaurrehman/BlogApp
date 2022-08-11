import 'package:blogging_app/customs.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("user");

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;
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
      image = await ImagePicker().pickImage(source: imageSource!);
      setState(() {
        if (image == null && imageSource == null) {
          return;
        } else {
          getimage = File(image!.path);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: Stack(
        children: [
          InkWell(
            child: getimage == null
                ? const Center(
                    child: Icon(
                      Icons.add_a_photo_outlined,
                      size: 55,
                    ),
                  )
                : Center(
                    child: CircleAvatar(
                      backgroundImage: FileImage(
                        getimage!,
                        scale: 0.5,
                      ),
                      radius: 80,
                      // child: Image.file(
                      //   getimage!,
                      //   height: size.height * 0.1,
                      //   width: size.width * 0.1,
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                  ),
            onTap: () => imagegetter(),
          ),
          // TextButton(
          //   style: TextButton.styleFrom(
          //       elevation: 0.0, padding: EdgeInsets.only(left: 65, bottom: 20)),
          //   onPressed: () {
          //     print("image deleted");
          //     setState(() {
          //       pickedimage = null;
          //     });
          //   },
          //   child: const Icon(
          //     Icons.close,
          //     color: Colors.black,
          //   ),
          // ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
