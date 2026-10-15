import 'package:cloud_firestore/cloud_firestore.dart';

class AdminService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ১. ম্যানুয়াল পেমেন্ট (bKash/Nagad) ভেরিফাই করা
  Future<void> approveOrder(String orderId) async {
    await _firestore.collection('orders').doc(orderId).update({
      'status': 'approved',
    });
  }

  // ২. Cash on Delivery (COD) অন বা অফ করা
  Future<void> toggleCOD(bool isEnabled) async {
    await _firestore.collection('app_settings').doc('global').set({
      'codEnabled': isEnabled,
    }, SetOptions(merge: true));
  }

  // ৩. বিকাশ ও নগদ নম্বর আপডেট করা
  Future<void> updatePaymentNumbers({
    required String bkash,
    required String nagad,
  }) async {
    await _firestore.collection('app_settings').doc('global').set({
      'bkashNumber': bkash,
      'nagadNumber': nagad,
    }, SetOptions(merge: true));
  }
}