import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ১. নতুন ইউজার রেজিস্ট্রেশন (কাস্টমার বা সেলার)
  Future<UserCredential?> signUp({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
    required String role, // 'customer' অথবা 'seller'
  }) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Firestore-এ ইউজার ডাটা সেভ
      UserModel newUser = UserModel(
        uid: userCredential.user!.uid,
        name: name,
        email: email,
        role: role,
        phoneNumber: phoneNumber,
        isApproved: role == 'seller' ? false : true, // সেলার হলে অ্যাডমিন অ্যাপ্রুভাল লাগবে
      );

      await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(newUser.toMap());

      return userCredential;
    } catch (e) {
      print("Registration Error: $e");
      return null;
    }
  }

  // ২. ইউজার লগইন
  Future<UserCredential?> login(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print("Login Error: $e");
      return null;
    }
  }

  // ৩. ইউজার তথ্য ও রোল (Role) নেওয়া
  Future<UserModel?> getUserDetails(String uid) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print("Get User Error: $e");
    }
    return null;
  }

  // ৪. লগআউট
  Future<void> signOut() async {
    await _auth.signOut();
  }
}