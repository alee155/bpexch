import 'dart:convert';

import 'package:bpexch/utils/copy_bank_details.dart';
import 'package:bpexch/utils/saveToken.dart';
import 'package:bpexch/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';

Future<void> fetchTransactionDetails(
    BuildContext context, String transactionId) async {
  String? token = await getToken();
  if (token == null) {
    print("No authorization token found");
    return;
  }

  try {
    final response = await http.post(
      Uri.parse('https://bpexchdeals.com/api/view_transaction'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({'source_id': transactionId}),
    );

    print('Response Status: ${response.statusCode}');
    print('Response Headers: ${response.headers}');

    if (response.statusCode == 200) {
      if (response.headers['content-type']?.contains('image') ?? false) {
        // Handle the image response here
        print('Received an image.');

        // Show the image in a dialog with a download option
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Transaction Image'),
              content: Image.memory(response.bodyBytes),
              actions: <Widget>[
                TextButton(
                  onPressed: () async {
                    // Save the image to the gallery
                    final result = await ImageGallerySaverPlus.saveImage(
                      response.bodyBytes,
                      name: 'transaction_image_$transactionId',
                    );
                    print('Image saved to gallery: $result');

                    Navigator.of(context).pop(); // Close the dialog

                    // Provide feedback to the user
                    if (result['isSuccess']) {
                      showCustomToastMessage(
                          context, 'Image saved to gallery!');
                    } else {
                      showCustomToastMessage(context, 'Failed to save image.');
                    }
                  },
                  child: Text(
                    'Download',
                    style: AppTextStyles.whiteText(18),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text(
                    'Close',
                    style: AppTextStyles.whiteText(18),
                  ),
                ),
              ],
            );
          },
        );
      } else {
        // If the response is not an image, treat it as JSON
        final transactionDetails = json.decode(response.body);
        print('Transaction details: $transactionDetails');
      }
    } else {
      print('Failed to fetch transaction details: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}
