class UserModel {
  final String uid;
  final String name;
  final String email;
  final String role; // 'customer', 'seller', 'admin'
  final String phoneNumber;
  final bool isApproved; // সেলারের জন্য অ্যাকাউন্ট অ্যাপ্রুভালের কাজ করবে

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.role,
    required this.phoneNumber,
    this.isApproved = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'role': role,
      'phoneNumber': phoneNumber,
      'isApproved': isApproved,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      role: map['role'] ?? 'customer',
      phoneNumber: map['phoneNumber'] ?? '',
      isApproved: map['isApproved'] ?? true,
    );
  }
}