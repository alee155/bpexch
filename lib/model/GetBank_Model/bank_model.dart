class Bank {
  final String id;
  final String name;
  final String acTitle;
  final String acNumber;
  final String? iconName;
  final int status;
  final int limits;
  final double? currentAmount;
  final String category;
  final String image;

  Bank({
    required this.id,
    required this.name,
    required this.acTitle,
    required this.acNumber,
    this.iconName,
    required this.status,
    required this.limits,
    this.currentAmount,
    required this.category,
    required this.image,
  });

  // Factory method to create a Bank object from a JSON object
  factory Bank.fromJson(Map<String, dynamic> json) {
    return Bank(
      id: json['id'] as String,
      name: json['name'] as String,
      acTitle: json['ac_title'] as String,
      acNumber: json['ac_number'] as String,
      iconName: json['icon_name'] as String?,
      status: json['status'] as int,
      limits: json['limits'] as int,
      currentAmount: json['current_amount'] as double?,
      category: json['category'] as String,
      image: json['image'] as String,
    );
  }
}
