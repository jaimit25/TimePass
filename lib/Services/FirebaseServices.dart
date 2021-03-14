import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class crudMethods {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<QuerySnapshot> getVideo() async {
    return await FirebaseFirestore.instance.collection('Videos').get();
  }

  Future<QuerySnapshot> filter(collectionname,filterby) async {
    return await FirebaseFirestore.instance
        .collection(collectionname)
        .where('uid', isEqualTo: filterby)
        .get();
  }

  Future<QuerySnapshot> fav(uid) async {
    return await FirebaseFirestore.instance
        .collection('favourites')
        .doc(uid)
        .collection('fav')
        .get();
  }

  updateData(sDoc, newValues) {
    return FirebaseFirestore.instance
        .collection('products')
        .doc(sDoc)
        .update(newValues)
        .catchError((e) {
      print(e);
    });
  }

  deletefav(uid, docId) async {
    return await FirebaseFirestore.instance
        .collection('favourites')
        .doc(uid)
        .collection('fav')
        .doc(docId)
        .delete()
        .catchError((e) => print(e));
  }

  deleteFile(docId) {
    return FirebaseFirestore.instance
        .collection('products')
        .doc(docId)
        .delete()
        .catchError((e) => print(e));
  }
}
