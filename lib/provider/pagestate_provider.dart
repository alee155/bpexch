import 'package:flutter/material.dart';

class PageStateProvider with ChangeNotifier {
  int _currentPage = 0;

  int get currentPage => _currentPage;

  // Method to update the current page
  void setPage(int page) {
    _currentPage = page;
    notifyListeners();
  }
}
