class OrderModel {
  final String orderId;
  final String customerId;
  final String sellerId;
  final String productId;
  final double amount;
  final double commissionAmount; // ১০% কমিশন
  final String paymentMethod; // 'bKash', 'Nagad', 'COD'
  final String transactionId;
  final String status; // 'pending', 'approved', 'delivered', 'cancelled'
  final DateTime createdAt;

  OrderModel({
    required this.orderId,
    required this.customerId,
    required this.sellerId,
    required this.productId,
    required this.amount,
    required this.commissionAmount,
    required this.paymentMethod,
    required this.transactionId,
    required this.status,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'customerId': customerId,
      'sellerId': sellerId,
      'productId': productId,
      'amount': amount,
      'commissionAmount': commissionAmount,
      'paymentMethod': paymentMethod,
      'transactionId': transactionId,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      orderId: map['orderId'] ?? '',
      customerId: map['customerId'] ?? '',
      sellerId: map['sellerId'] ?? '',
      productId: map['productId'] ?? '',
      amount: (map['amount'] ?? 0.0).toDouble(),
      commissionAmount: (map['commissionAmount'] ?? 0.0).toDouble(),
      paymentMethod: map['paymentMethod'] ?? '',
      transactionId: map['transactionId'] ?? '',
      status: map['status'] ?? 'pending',
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}