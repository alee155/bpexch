import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewProvider extends ChangeNotifier {
  Uri? _url;
  InAppWebViewController? _webViewController;

  Uri? get url => _url;
  InAppWebViewController? get webViewController => _webViewController;

  void setUrl(Uri url) {
    _url = url;
    notifyListeners();
  }

  void setWebViewController(InAppWebViewController controller) {
    _webViewController = controller;
    notifyListeners();
  }
}
