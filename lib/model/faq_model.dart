class Faq {
  final String id;
  final int userId;
  final int companyId;
  final String subject;
  final String status;
  final String type;
  final String content;

  Faq({
    required this.id,
    required this.userId,
    required this.companyId,
    required this.subject,
    required this.status,
    required this.type,
    required this.content,
  });

  factory Faq.fromJson(Map<String, dynamic> json) {
    return Faq(
      id: json['id'] ?? '',
      userId: _parseInt(json['user_id']),
      companyId: _parseInt(json['company_id']),
      subject: json['subject'] ?? 'No title',
      status: json['status'] ?? 'Inactive',
      type: json['type'] ?? 'Unknown',
      content: json['content'] ?? 'No content available',
    );
  }

  // A helper function to handle cases where values can be either string or integer
  static int _parseInt(dynamic value) {
    if (value is int) {
      return value;
    } else if (value is String) {
      return int.tryParse(value) ?? 0; // Return 0 if parsing fails
    }
    return 0;
  }
}
