import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

FirebaseStorage storage = FirebaseStorage.instance;
CollectionReference db = FirebaseFirestore.instance.collection("user");

class FetchDatafromFirebase with ChangeNotifier {
  void fetchfirebasedata() {
    StreamBuilder(
      stream: db.snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot?> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(documentSnapshot.get("imgurl")),
                            fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(documentSnapshot["title"]),
                  ],
                );
              },
            ),
          );
        }
      },
    );
  }
}
