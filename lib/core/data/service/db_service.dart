
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_achiver/core/data/model/database_item.dart';

class DatabaseService<T extends DatabaseItem> {
  final String collection;
  final Firestore _db = Firestore.instance;
  final T Function(String, Map<String,dynamic>) fromDS;
  final Map<String,dynamic> Function(T) toMap;
  DatabaseService(this.collection, {this.fromDS,this.toMap});

  Future<T> getSingle(String id) async {
    var snap = await _db.collection(collection).document(id).get();
    return fromDS(snap.documentID,snap.data);
  }

  Stream<T> streamSingle(String id) {
    return _db
        .collection(collection)
        .document(id)
        .snapshots()
        .map((snap) => fromDS(snap.documentID,snap.data));
  }

  Stream<List<T>> streamList() {
    var ref = _db.collection(collection);

    return ref.snapshots().map((list) =>
        list.documents.map((doc) => fromDS(doc.documentID,doc.data)).toList());
  }

  Future<DocumentReference> createItem(T item) {
    return _db
        .collection(collection)
        .add(toMap(item));
  }

  Future<void> updateItem(T item) {
    return _db
      .collection(collection)
      .document(item.id)
      .setData(toMap(item));
  }

  Future<void> removeItem(String id) {
    return _db
        .collection(collection)
        .document(id)
        .delete();
  }
}
