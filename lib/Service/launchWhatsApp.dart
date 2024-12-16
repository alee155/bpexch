// whatsapp_service.dart
import 'package:url_launcher/url_launcher.dart';

Future<void> launchWhatsApp(String? storedWhatsappNo) async {
  if (storedWhatsappNo != null) {
    final url = 'https://wa.me/$storedWhatsappNo';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  } else {
    print('No WhatsApp number found.');
  }
}
