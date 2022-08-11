import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../customs.dart';
import 'package:path/path.dart' as Path;

class Create_Post extends StatefulWidget {
  const Create_Post({Key? key}) : super(key: key);
  static const routeName = "createpost";
  @override
  State<Create_Post> createState() => _Create_PostState();
}

class _Create_PostState extends State<Create_Post> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  FirebaseStorage storage = FirebaseStorage.instance;
  CollectionReference db = FirebaseFirestore.instance.collection("blog");
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future uploaddata(String title, String description) async {
    DocumentReference blogRef = db.doc();

    String path = Path.basename(pickedimage!.path);
    Reference ref = await storage.ref().child("blog/${path}");
    await ref.putFile(pickedimage!).whenComplete(() async {
      String imgurl = await ref.getDownloadURL();
      User? uid = _auth.currentUser;
      await blogRef.set({
        "imgurl": imgurl,
        "title": title,
        "description": description,
        "uid": uid!.uid,
        "docid": blogRef.id,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text(
          "create post",
          style: TextStyle(color: Color.fromARGB(221, 154, 66, 170)),
        ),
        centerTitle: true,
        elevation: 0.0,
        iconTheme:
            const IconThemeData(color: Color.fromARGB(221, 154, 66, 170)),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  image_picker_container(const Image_Picker()),
                  const SizedBox(
                    height: 40,
                  ),
                  _buildtitlefield(),
                  const SizedBox(
                    height: 20,
                  ),
                  _builddescriptionfield(),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      uploaddata(_title.text, _description.text)
                          .whenComplete(() {
                        setState(() {
                          Navigator.pop(context);
                        });
                      });
                    },
                    child: Text("Create Post"),
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.29,
                            vertical: size.height * 0.02),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18))),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Container image_picker_container(Widget child) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(left: 0),
      child: child,
      width: size.width * 0.8,
      height: size.height * 0.35,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 0.6),
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
    );
  }

  TextFormField _buildtitlefield() {
    return TextFormField(
      controller: _title,
      decoration: InputDecoration(
          hintText: "add title here",
          label: Text("title"),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20), gapPadding: 6),
          contentPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          prefixIcon: Icon(Icons.title_outlined)),
      keyboardType: TextInputType.text,
      maxLength: 20,
      maxLines: 1,
      textInputAction: TextInputAction.next,
    );
  }

  TextFormField _builddescriptionfield() {
    return TextFormField(
      controller: _description,
      decoration: InputDecoration(
          hintText: "add description here",
          label: Text("Description"),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20), gapPadding: 6),
          contentPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          prefixIcon: Icon(Icons.description_outlined)),
      keyboardType: TextInputType.text,
      maxLength: 100,
      maxLines: 4,
      textInputAction: TextInputAction.done,
    );
  }
}
