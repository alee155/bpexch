import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void copyBankDetails(BuildContext context, String bankName,
    String accountNumber, String accountTitle) {
  final bankDetails = '''
Bank Name: $bankName
Account Number: $accountNumber
Account Title: $accountTitle
''';

  Clipboard.setData(ClipboardData(text: bankDetails)).then((_) {
    // Show a custom animated message widget to indicate that the bank details were copied
    showAnimatedMessage(context);
  });
}

void showAnimatedMessage(BuildContext context) {
  OverlayState? overlayState = Overlay.of(context);
  OverlayEntry overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 100.0,
      left: 20.0,
      right: 20.0,
      child: AnimatedOpacity(
        opacity: 1.0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 10),
                Text(
                  'Bank details copied!',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );

  overlayState.insert(overlayEntry);

  // Remove the overlay entry after the animation completes
  Future.delayed(const Duration(seconds: 2), () {
    overlayEntry.remove();
  });
}

void showCustomToastMessage(BuildContext context, String message) {
  OverlayState? overlayState = Overlay.of(context);
  OverlayEntry overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 100.0,
      left: 20.0,
      right: 20.0,
      child: AnimatedOpacity(
        opacity: 1.0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.white),
                const SizedBox(width: 10),
                Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );

  overlayState.insert(overlayEntry);

  // Remove the overlay entry after the animation completes
  Future.delayed(const Duration(seconds: 2), () {
    overlayEntry.remove();
  });
}
