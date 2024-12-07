import 'package:flutter/material.dart';

class PaymentMethodProvider extends ChangeNotifier {
  String? _selectedPaymentMethod;

  String? get selectedPaymentMethod => _selectedPaymentMethod;

  void selectPaymentMethod(String? value) {
    _selectedPaymentMethod = value;
    notifyListeners();
  }
}
