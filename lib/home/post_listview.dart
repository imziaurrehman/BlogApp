import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Postlistview extends StatelessWidget {
  Postlistview({Key? key}) : super(key: key);
  static const routeName = "viewpost";
  CollectionReference db = FirebaseFirestore.instance.collection("blog");

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text(
          "post listview",
          style: TextStyle(color: Color.fromARGB(221, 154, 66, 170)),
        ),
        centerTitle: true,
        elevation: 0.0,
        iconTheme:
            const IconThemeData(color: Color.fromARGB(221, 154, 66, 170)),
      ),
      body: StreamBuilder(
        stream: db.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot?> snapshot) {
          if (!snapshot.hasData) {
            return Text("data is not here");
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
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
                  datalayout(context, "Title: ${documentSnapshot.get("title")}",
                      "Details: ${documentSnapshot.get("description")}"),
                ]);
              },
            );
          }
        },
      ),
    );
  }

  Column datalayout(
    BuildContext context,
    String title,
    String description,
  ) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          width: size.width * 0.6,
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
          margin: EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
              // border: Border.all(color: Colors.purple, width: 0.6),
              borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: Text(
              title,
              textScaleFactor: 1.28,
              style: TextStyle(),
            ),
          ),
        ),
        Container(
          width: size.width * 0.6,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          margin: EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
              // border: Border.all(color: Colors.purple, width: 0.6),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.purple, width: 0.01)),
          child: Center(
            child: Text(
              description,
              textScaleFactor: 1.15,
              style: TextStyle(),
            ),
          ),
        ),
      ],
    );
  }
}
