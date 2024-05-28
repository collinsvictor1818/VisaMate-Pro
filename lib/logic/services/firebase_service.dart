import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }

  static Future<void> addMessage(Map<String, dynamic> message) async {
    await _firestore.collection('messages').add(message);
  }

  static Stream<QuerySnapshot> getMessages() {
    return _firestore.collection('messages').snapshots();
  }
}