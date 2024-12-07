import 'package:bpexch/provider/webview_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late InAppWebViewGroupOptions options;
  bool _isLoading = true; // Track loading state

  @override
  void initState() {
    super.initState();
    options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get the WebViewProvider from the context
    final webViewProvider = Provider.of<WebViewProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: const Text(''),
      ),
      body: Stack(
        children: [
          // Show the WebView
          InAppWebView(
            initialUrlRequest: URLRequest(
              url: WebUri(
                  Uri.parse("https://www.bpexch.com/Users/Login/").toString()),
            ),
            initialOptions: options,
            onWebViewCreated: (InAppWebViewController controller) {
              // Set the WebViewController in the provider
              webViewProvider.setWebViewController(controller);
            },
            onLoadStart: (InAppWebViewController controller, Uri? url) {
              // When loading starts, set _isLoading to true
              setState(() {
                _isLoading = true;
              });
              print("Loading started: $url");
            },
            onLoadStop: (InAppWebViewController controller, Uri? url) async {
              // When loading stops, set _isLoading to false
              setState(() {
                _isLoading = false;
              });
              print("Loading stopped: $url");
            },
            onProgressChanged:
                (InAppWebViewController controller, int progress) {
              print("Loading progress: $progress%");
            },
          ),
          // Show loading indicator when the page is loading
          if (_isLoading)
            Center(
              child: SpinKitFadingCircle(
                color: Colors.white,
                size: 60.r,
              ),
            ),
        ],
      ),
    );
  }
}
