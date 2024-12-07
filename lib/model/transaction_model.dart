class Transaction {
  final String id;
  final int userId;
  final String type;
  final String date;
  final String bank;
  final String accountNumber;
  final String accountTitle;
  final double amount;
  final double balance;
  final String? remark;
  final String status;

  Transaction({
    required this.id,
    required this.userId,
    required this.type,
    required this.date,
    required this.bank,
    required this.accountNumber,
    required this.accountTitle,
    required this.amount,
    required this.balance,
    this.remark,
    required this.status,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      userId: json['user_id'],
      type: json['type'],
      date: json['date'],
      bank: json['bank'],
      accountNumber: json['ac_number'],
      accountTitle: json['ac_title'],
      amount: double.parse(json['amount']),
      balance: double.parse(json['balance'].toString()),
      remark: json['remark'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'type': type,
      'date': date,
      'bank': bank,
      'accountNumber': accountNumber,
      'accountTitle': accountTitle,
      'amount': amount,
      'balance': balance,
      'remark': remark,
      'status': status,
    };
  }
}
