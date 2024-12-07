import 'user_model.dart';

class LoginResponseModel {
  final UserModel user;
  final String token;

  LoginResponseModel({required this.user, required this.token});

  // Factory constructor to create a LoginResponseModel from JSON
  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      user: UserModel.fromJson(json['user']),
      token: json['token'],
    );
  }

  // Method to convert the LoginResponseModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'token': token,
    };
  }
}
