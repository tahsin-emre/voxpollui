import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseService {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
}
