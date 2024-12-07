import 'package:bpexch/model/user_model.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  final UserModel user;

  const UserProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${user.firstName} ${user.lastName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${user.name ?? "N/A"}',
                style: const TextStyle(fontSize: 18)),
            Text('Email: ${user.email ?? "N/A"}',
                style: const TextStyle(fontSize: 18)),
            Text('Phone: ${user.phone}', style: const TextStyle(fontSize: 18)),
            Text('Username: ${user.username}',
                style: const TextStyle(fontSize: 18)),
            Text('Role: ${user.role ?? "N/A"}',
                style: const TextStyle(fontSize: 18)),
            Text('status: ${user.status ?? "N/A"}',
                style: const TextStyle(fontSize: 18)),
            Text('email_verified_at: ${user.emailVerifiedAt ?? "N/A"}',
                style: const TextStyle(fontSize: 18)),

            Text('created_at: ${user.createdAt ?? "N/A"}',
                style: const TextStyle(fontSize: 18)),
            Text('bp_username: ${user.bpUsername ?? "N/A"}',
                style: const TextStyle(fontSize: 18)),
            Text('bp_password: ${user.bpPassword ?? "N/A"}',
                style: const TextStyle(fontSize: 18)),

            // You can add more fields as needed
          ],
        ),
      ),
    );
  }
}
