import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ToastService {
  static void showToast({
    required BuildContext context,
    required String title,
    required String message,
    ToastificationType type = ToastificationType.success,
  }) {
    toastification.show(
      context: context,
      type: type,
      style: ToastificationStyle.flat,
      autoCloseDuration: const Duration(seconds: 5),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      description: Text(message),
      alignment: Alignment.bottomCenter,
      animationDuration: const Duration(milliseconds: 300),
      icon: type == ToastificationType.success
          ? const Icon(Icons.check_circle, color: Colors.green)
          : type == ToastificationType.error
              ? const Icon(Icons.error, color: Colors.red)
              : const Icon(Icons.info, color: Colors.blue),
      showIcon: true,
      primaryColor: type == ToastificationType.success
          ? Colors.green
          : type == ToastificationType.error
              ? Colors.red
              : Colors.blue,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Color(0x07000000),
          blurRadius: 16,
          offset: Offset(0, 16),
          spreadRadius: 0,
        )
      ],
      showProgressBar: true,
      closeButtonShowType: CloseButtonShowType.onHover,
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: true,
      callbacks: ToastificationCallbacks(
        onTap: (toastItem) => print('Toast ${toastItem.id} tapped'),
        onCloseButtonTap: (toastItem) =>
            print('Toast ${toastItem.id} close button tapped'),
        onAutoCompleteCompleted: (toastItem) =>
            print('Toast ${toastItem.id} auto complete completed'),
        onDismissed: (toastItem) => print('Toast ${toastItem.id} dismissed'),
      ),
    );
  }
}
