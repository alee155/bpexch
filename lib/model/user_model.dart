class UserModel {
  final int id;
  final int? parentId;
  final String name;
  final String? email;
  final String? emailVerifiedAt;
  final String createdAt;
  final String updatedAt;
  final String? ntn;
  final String? role;
  final String firstName;
  final String lastName;
  final String profile;
  final String status;
  final String phone;
  final String username;
  final String? bpUsername;
  final String? bpPassword;
  final int isAdmin;

  UserModel({
    required this.id,
    this.parentId,
    required this.name,
    this.email,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    this.ntn,
    this.role,
    required this.firstName,
    required this.lastName,
    required this.profile,
    required this.status,
    required this.phone,
    required this.username,
    this.bpUsername,
    this.bpPassword,
    required this.isAdmin,
  });

  // Factory constructor to create a UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      parentId: json['parent_id'],
      name: json['name'] ?? 'Unknown', // Default value if null
      email: json['email'] ?? 'N/A', // Default value if null
      emailVerifiedAt: json['email_verified_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      ntn: json['ntn'],
      role: json['role'] ?? 'N/A', // Default value if null
      firstName: json['firstName'] ?? 'Unknown', // Default value if null
      lastName: json['lastName'] ?? 'Unknown', // Default value if null
      profile: json['profile'] ?? 'Unknown', // Default value if null
      status: json['status'] ?? 'Active', // Default value if null
      phone: json['phone'] ?? 'N/A', // Default value if null
      username: json['username'] ?? 'Unknown', // Default value if null
      bpUsername: json['bp_username'],
      bpPassword: json['bp_password'],
      isAdmin: json['is_admin'],
    );
  }

  // Method to convert the UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'parent_id': parentId,
      'name': name,
      'email': email,
      'email_verified_at': emailVerifiedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'ntn': ntn,
      'role': role,
      'firstName': firstName,
      'lastName': lastName,
      'profile': profile,
      'status': status,
      'phone': phone,
      'username': username,
      'bp_username': bpUsername,
      'bp_password': bpPassword,
      'is_admin': isAdmin,
    };
  }
}
