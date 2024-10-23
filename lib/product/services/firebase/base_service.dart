import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class BaseService {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final storage = FirebaseStorage.instance;
}

enum FireStoreCollections {
  //Top Level Collections
  users,
  polls,
  categories,
  communities,
  //Sub Collections
  votes,
  followers,
  following,
  members,
}

enum FireStoreFields {
  none,
  ownerId,
  name,
  title,
  userName,
}
