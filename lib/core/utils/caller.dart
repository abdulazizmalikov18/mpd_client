import 'package:url_launcher/url_launcher.dart';

class Caller {
  static Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    await launchUrl(launchUri);
  }

  static Future<void> openPlayStore() async {
    final url = Uri.parse(
      "https://play.google.com/store/apps/details?id=uz.mpd.work",
    );

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Play Market ochilmadi: $url');
    }
  }
}
